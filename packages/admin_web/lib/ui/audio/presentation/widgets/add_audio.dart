import 'package:admin_web/ui/audio/presentation/audio_wm.dart';
import 'package:shared/imports.dart';
import 'package:file_picker/file_picker.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddAudio extends StatefulWidget {
  const AddAudio({
    super.key,
    this.onAdd,
    this.onEdit,
    required this.wm,
    this.audio,
  });

  final Function(AudioDto)? onAdd;
  final Function(AudioDto)? onEdit;
  final IAudioWM wm;
  final AudioDto? audio;

  @override
  State<AddAudio> createState() => _AddAudioState();
}

class _AddAudioState extends State<AddAudio> {
  final TextEditingController titleTextController = TextEditingController();
  final TextEditingController descriptionTextController = TextEditingController();
  final TextEditingController shortDescriptionTextController = TextEditingController();
  final TextEditingController videoLinkTextController = TextEditingController();
  final TextEditingController youtubeIdTextController = TextEditingController();
  late YoutubePlayerController _controller;
  PlatformFile? audioFile;
  var uuid = const Uuid();

  @override
  void initState() {
    titleTextController.text = widget.audio?.title ?? '';
    descriptionTextController.text = widget.audio?.description ?? '';
    shortDescriptionTextController.text = widget.audio?.shortDescription ?? '';
    videoLinkTextController.text = widget.audio?.videoLink ?? '';
    youtubeIdTextController.text = widget.audio?.youtubeId ?? '';
    if (widget.audio?.youtubeId != null) {
      _controller = YoutubePlayerController(
        initialVideoId: widget.audio!.youtubeId!,
      );
    }
    super.initState();
  }

  @override
  void deactivate() {
    if (widget.audio?.youtubeId != null) {
      _controller.pause();
    }
    super.deactivate();
  }

  @override
  void dispose() {
    if (widget.audio?.youtubeId != null) {
      _controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final theme = Theme.of(context);
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UnionStateListenableBuilder(
                unionStateListenable: widget.wm.result,
                loadingBuilder: (_, __) {
                  return const SizedBox();
                },
                failureBuilder: (_, __, ___) => const SizedBox(),
                builder: (_, data) {
                  if (data) {
                    showMessage(
                      message: 'Файл добавлен',
                      type: PageState.success,
                    );
                  }
                  return ListView(
                    shrinkWrap: true,
                    children: [
                      Row(
                        children: [
                          Text(
                            widget.onAdd != null ? 'Добавление аудио файла' : 'Редактирование аудио файла',
                            style: theme.textTheme.labelLarge,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      AppTextField(
                        labelText: 'Название',
                        hintText: 'Введите название файла',
                        textController: titleTextController,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        labelText: 'Описание',
                        hintText: 'Введите описание файла',
                        textController: descriptionTextController,
                        minLines: 4,
                        maxLines: 8,
                        minHeight: 112,
                        height: 448,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AppTextField(
                        isDense: true,
                        labelText: 'Короткое описание',
                        hintText: 'Введите короткое описание файла',
                        textController: shortDescriptionTextController,
                        minLines: 4,
                        maxLines: 8,
                        minHeight: 112,
                        height: 448,
                      ),
                      if (widget.audio?.youtubeId != null)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 10),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: YoutubePlayer(
                                  width: (size.width * 0.7) / 2,
                                  controller: _controller,
                                ),
                              )
                            ],
                          ),
                        ),
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: AppTextField(
                              labelText: 'ID видео в YouTube',
                              hintText: 'Введите ID видео в YouTube',
                              textController: youtubeIdTextController,
                            ),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Expanded(
                            flex: 3,
                            child: AppTextField(
                              labelText: 'Ссылка на видео в YouTube',
                              hintText: 'Введите ссылку на видео в YouTube',
                              textController: videoLinkTextController,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: audioFile != null ? AppColors.primary : AppColors.grey,
                          ),
                        ),
                        child: Row(
                          children: [
                            AppButton(
                              title: 'Выбрать',
                              textColor: Colors.white,
                              onPressed: () async {
                                final result = await FilePicker.platform.pickFiles(
                                  type: FileType.audio,
                                );
                                if (result != null) {
                                  audioFile = result.files.first;
                                }
                                setState(() {});
                              },
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                audioFile != null ? audioFile!.name : 'Выберите аудио файл',
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                            const Spacer(),
                            if (audioFile != null)
                              AppButton(
                                title: 'Удалить',
                                color: AppColors.lightGrey,
                                textColor: Colors.white,
                                onPressed: () async {
                                  audioFile = null;
                                  setState(() {});
                                },
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: UnionStateListenableBuilder(
                          unionStateListenable: widget.wm.uploadState,
                          builder: (_, data) {
                            return Stack(
                              children: [
                                AppButton(
                                  title: 'Сохранить',
                                  color: audioFile != null && !data ? AppColors.primary : AppColors.grey,
                                  textColor: Colors.white,
                                  onPressed: () async {
                                    if (titleTextController.text.isEmpty) {
                                      showMessage(
                                        message: 'Введите заголовок',
                                        type: PageState.error,
                                      );
                                    } else if (descriptionTextController.text.isEmpty) {
                                      showMessage(
                                        message: 'Введите описание',
                                        type: PageState.error,
                                      );
                                    } else if (shortDescriptionTextController.text.isEmpty) {
                                      showMessage(
                                        message: 'Введите краткое описание',
                                        type: PageState.error,
                                      );
                                    } else if (videoLinkTextController.text.isEmpty) {
                                      showMessage(
                                        message: 'Введите ссылку на YouTube видео',
                                        type: PageState.error,
                                      );
                                    } else if (youtubeIdTextController.text.isEmpty) {
                                      showMessage(
                                        message: 'Введите ID YouTube видео',
                                        type: PageState.error,
                                      );
                                    } else {
                                      if (widget.onAdd != null) {
                                        if (audioFile == null) {
                                          showMessage(
                                            message: 'Выберите файл',
                                            type: PageState.error,
                                          );
                                        }
                                        final dto = AudioDto(
                                          id: uuid.v1(),
                                          name: audioFile!.name,
                                          title: titleTextController.text,
                                          description: descriptionTextController.text,
                                          shortDescription: shortDescriptionTextController.text,
                                          videoLink: videoLinkTextController.text,
                                          youtubeId: youtubeIdTextController.text,
                                          fileLink: widget.wm.fileLink,
                                          bytes: audioFile!.bytes!,
                                        );
                                        widget.onAdd!(dto);
                                      }
                                      if (widget.onEdit != null && widget.audio != null) {
                                        AudioDto? dto = widget.audio!.copyWith(
                                          title: titleTextController.text,
                                          description: descriptionTextController.text,
                                          shortDescription: shortDescriptionTextController.text,
                                          videoLink: videoLinkTextController.text,
                                          youtubeId: youtubeIdTextController.text,
                                          fileLink: widget.wm.fileLink,
                                        );
                                        if (audioFile != null) {
                                          dto = widget.audio!.copyWith(
                                            name: audioFile!.name,
                                            bytes: audioFile!.bytes!,
                                          );
                                        }
                                        widget.onEdit!(dto);
                                        Navigator.pop(context, true);
                                      }
                                    }
                                  },
                                ),
                                if (data)
                                  Container(
                                    height: 44,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                        width: 1,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                    child: const CircularProgressIndicatorWidget(),
                                  ),
                              ],
                            );
                          },
                          loadingBuilder: (_, __) => Container(
                            height: 44,
                            width: 160,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                width: 1,
                                color: AppColors.primary,
                              ),
                            ),
                            child: const CircularProgressIndicatorWidget(),
                          ),
                          failureBuilder: (_, __, ___) => const Text('Ошибка загрузки'),
                        ),
                      ),
                    ],
                  );
                }),
          ],
        ),
      ),
    );
  }
}
