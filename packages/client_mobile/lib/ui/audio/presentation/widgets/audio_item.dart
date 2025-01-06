import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:client_mobile/source/routes.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared/imports.dart';

class AudioItem extends StatefulWidget {
  const AudioItem({
    super.key,
    required this.audio,
  });

  final AudioDto audio;

  @override
  State<AudioItem> createState() => _AudioItemState();
}

class _AudioItemState extends State<AudioItem> {
  bool isDownloaded = false;
  late AudioPlayer player = AudioPlayer();
  PlayerState? _playerState;
  Duration? _duration;
  Duration? _position;
  Directory? directory;
  StreamSubscription? _durationSubscription;
  StreamSubscription? _positionSubscription;
  StreamSubscription? _playerCompleteSubscription;
  StreamSubscription? _playerStateChangeSubscription;
  File? downloadedFile;

  bool get _isPlaying => _playerState == PlayerState.playing;

  bool get _isPaused => _playerState == PlayerState.paused;

  String get _durationText => _duration?.toString().split('.').first ?? '';

  String get _positionText => _position?.toString().split('.').first ?? '';

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    player.setReleaseMode(ReleaseMode.stop);
    _playerState = player.state;
    player.getDuration().then(
          (value) => setState(() {
            print('DURATION: $_duration / POSITION: $_position');
            _duration = value;
          }),
        );
    player.getCurrentPosition().then(
          (value) => setState(() {
            _position = value;
          }),
        );
    _initStreams();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      getDirectory();
    });
  }

  void getDirectory() async {
    await getExternalStorageDirectory().then((value) async {
      directory = value;
      if (directory != null) {
        final file = File('${directory!.path}/${widget.audio.id}_${widget.audio.name}');
        await file.exists().then((value) async {
          isDownloaded = value;
          if (value) {
            downloadedFile = file;
          }
          if (widget.audio.fileLink != null) {
            await player.setSource(
              downloadedFile != null
                  ? DeviceFileSource(
                      downloadedFile!.path,
                    )
                  : UrlSource(
                      widget.audio.fileLink!,
                    ),
            );
          }
          setState(() {});
        });
      } else {
        await player.setSource(UrlSource(widget.audio.fileLink!));
      }
    });
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerCompleteSubscription?.cancel();
    _playerStateChangeSubscription?.cancel();
    super.dispose();
  }

  void _initStreams() {
    _durationSubscription = player.onDurationChanged.listen((duration) {
      setState(() => _duration = duration);
    });

    _positionSubscription = player.onPositionChanged.listen(
      (p) => setState(() => _position = p),
    );

    _playerCompleteSubscription = player.onPlayerComplete.listen((event) {
      setState(() {
        _playerState = PlayerState.stopped;
        _position = Duration.zero;
      });
    });

    _playerStateChangeSubscription = player.onPlayerStateChanged.listen((state) {
      setState(() {
        _playerState = state;
      });
    });
  }

  Future<void> _play() async {
    await player.resume();
    setState(() => _playerState = PlayerState.playing);
  }

  Future<void> _pause() async {
    await player.pause();
    setState(() => _playerState = PlayerState.paused);
  }

  Future<void> _stop() async {
    await player.stop();
    setState(() {
      _playerState = PlayerState.stopped;
      _position = Duration.zero;
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {
        context.pushNamed(
          Pages.audioDetail,
          extra: widget.audio,
        );
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (widget.audio.youtubeId != null)
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ImageWidget(
                      height: 56,
                      width: 100,
                      imageId: 'https://img.youtube.com/vi/${widget.audio.youtubeId!}/0.jpg',
                    ),
                  ),
                Expanded(
                  child: Text(
                    widget.audio.title ?? '',
                    style: theme.textTheme.labelMedium,
                    softWrap: true,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            if (widget.audio.shortDescription != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Text(
                  widget.audio.shortDescription!,
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            if (widget.audio.fileLink != null)
              DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    width: 2,
                    color: AppColors.darkGrey,
                  ),
                ),
                child: ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_isPlaying) {
                            _pause();
                          } else {
                            _play();
                          }
                        },
                        child: Icon(
                          _isPlaying ? Icons.pause_circle_outline : Icons.play_circle_outline,
                          color: _isPlaying ? Colors.orange : AppColors.primary,
                          size: 36,
                        ),
                      ),
                      if (_isPlaying || _isPaused)
                        InkWell(
                          onTap: () {
                            _stop();
                          },
                          child: const Icon(
                            Icons.stop_circle_outlined,
                            color: AppColors.error,
                            size: 36,
                          ),
                        ),
                    ],
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.audio.name!,
                        style: theme.textTheme.bodySmall,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Slider(
                        onChanged: (value) {
                          final duration = _duration;
                          if (duration == null) {
                            return;
                          }
                          final position = value * duration.inMilliseconds;
                          player.seek(Duration(milliseconds: position.round()));
                        },
                        value: (_position != null &&
                                _duration != null &&
                                _position!.inMilliseconds > 0 &&
                                _position!.inMilliseconds < _duration!.inMilliseconds)
                            ? _position!.inMilliseconds / _duration!.inMilliseconds
                            : 0.0,
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _position != null
                              ? '$_positionText / $_durationText'
                              : _duration != null
                                  ? _durationText
                                  : '',
                          style: theme.textTheme.bodySmall,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
