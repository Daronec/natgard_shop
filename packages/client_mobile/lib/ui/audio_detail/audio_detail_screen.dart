import 'dart:io';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:client_mobile/ui/widgets/app_scaffold/app_scaffold.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:shared/imports.dart';

class AudioDetailScreen extends StatefulWidget {
  /// {@macro feature_example_flow.class}
  const AudioDetailScreen({super.key, required this.audio});

  final AudioDto audio;

  @override
  State<AudioDetailScreen> createState() => _AudioDetailScreenState();
}

class _AudioDetailScreenState extends State<AudioDetailScreen> {
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
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return AppScaffold(
      appBar: CustomAppBar(
        title: widget.audio.title ?? '',
      ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.audio.youtubeId != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ImageWidget(
                  height: (size.width - 40) * 0.56,
                  width: size.width - 40,
                  imageId: 'https://img.youtube.com/vi/${widget.audio.youtubeId!}/0.jpg',
                ),
              ),
            if (widget.audio.fileLink != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: const BorderSide(
                      width: 1,
                      color: AppColors.darkGrey,
                    ),
                  ),
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
                        style: theme.textTheme.bodyMedium,
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
                  trailing: InkWell(
                    onTap: () async {
                      if (widget.audio.fileLink!.isNotEmpty) {
                        String referer = widget.audio.fileLink!;
                        await FlutterDownloader.enqueue(
                          url: widget.audio.fileLink!,
                          savedDir: directory?.path ?? '',
                          showNotification: defaultTargetPlatform == TargetPlatform.android,
                          openFileFromNotification: defaultTargetPlatform == TargetPlatform.android,
                        );
                      }
                    },
                    child: Icon(
                      isDownloaded ? Icons.download_done : Icons.download,
                      color: isDownloaded ? AppColors.primary : AppColors.darkGrey,
                    ),
                  ),
                ),
              ),
            if (widget.audio.videoLink != null)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                ),
                child: InkWell(
                  onTap: () {
                    openUrl(widget.audio.videoLink!);
                  },
                  child: Text(
                    'Перейти на YouTube',
                    style: theme.textTheme.bodyMedium!.copyWith(
                      decoration: TextDecoration.underline,
                      decorationColor: theme.colorScheme.scrim,
                      color: theme.colorScheme.scrim,
                    ),
                  ),
                ),
              ),
            if (widget.audio.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Linkify(
                  onOpen: (link) => openUrl(link.url),
                  text: widget.audio.description!
                      .replaceAll('•', '\n•')
                      .replaceAllMapped(
                        timeRegex,
                        (match) => '\n$match',
                      )
                      .replaceAllMapped(
                        timeShortRegex,
                        (match) => '\n$match',
                      ),
                  style: theme.textTheme.bodyMedium,
                ),
              ),
            if (widget.audio.description != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Пересказ',
                      style: theme.textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      widget.audio.retelling!.replaceAll(' 0', '\n\n0').replaceAll('•', '\n•'),
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
