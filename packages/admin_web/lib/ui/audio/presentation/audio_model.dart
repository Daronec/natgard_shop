import 'package:shared/core/architecture/domain/entity/result.dart';
import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enum_assist_annotation/enum_assist_annotation.dart';

@EnumAssist()
enum AudioState {
  list,
  add;

  T map<T>({
    required T Function() list,
    required T Function() add,
  }) {
    switch (this) {
      case AudioState.list:
        return list();
      case AudioState.add:
        return add();
    }
  }

  T maybeMap<T>({
    required T Function() orElse,
    T Function()? list,
    T Function()? add,
  }) =>
      map<T>(
        list: list ?? orElse,
        add: add ?? orElse,
      );
}

final class AudioModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;

  final ICloudBaseRepository _cloudRepository;
  final _audio = UnionStateNotifier<List<AudioDto>>.new([]);
  final _audioUploaded = UnionStateNotifier<List<String>>.new([]);
  final _result = UnionStateNotifier<bool>.new(false);
  final _uploadState = UnionStateNotifier<bool>.new(false);
  final _audioState = UnionStateNotifier<AudioState>.new(AudioState.list);
  String? fileLink;

  /// State of screen.
  UnionStateNotifier<List<AudioDto>> get audio => _audio;

  UnionStateNotifier<List<String>> get audioUploaded => _audioUploaded;

  UnionStateNotifier<bool> get result => _result;

  UnionStateNotifier<bool> get uploadState => _uploadState;

  UnionStateNotifier<AudioState> get audioState => _audioState;

  /// {@macro feature_example_model.class}
  AudioModel({
    required ICloudBaseRepository repository,
    required IFirebaseStorageRepository firebaseStorageRepository,
    required super.logWriter,
  })  : _cloudRepository = repository,
        db = FirebaseFirestore.instance,
        storage = FirebaseStorage.instance;

  @override
  void dispose() {
    _audio.dispose();
    _audioUploaded.dispose();
    _result.dispose();
    _uploadState.dispose();
    super.dispose();
  }

  Future<void> getAudioData() async {
    _audio.loading(_audio.value.data ?? []);
    final result = await _cloudRepository.getAudioData();
    switch (result) {
      case ResultOk(:final data):
        _audio.content(data);
      case ResultFailed(:final failure):
        _audio.failure(failure);
    }
  }

  void addAudio(AudioDto value) {
    _audioState.content(AudioState.list);
    List<String> audioFilesUpload = [];
    audioFilesUpload.addAll(_audioUploaded.value.data ?? []);
    audioFilesUpload.add(value.name ?? '');
    _audioUploaded.content(audioFilesUpload);
    print('AUDIO_FILES_UPLOADED_START: ${_audioUploaded.value.data?.length}');
    final ref = db.collection("audio");
    ref.add(value.toJson()).then((doc) async {
      final id = doc.id;
      debugPrint('ADD_AUDIO_RESPONSE: ${doc.id}');
      final reference = storage.ref().child('audio/${id}_${value.name}');
      final stream = await reference.putData(value.bytes!);
      stream.ref.getDownloadURL().then((link) async {
        debugPrint('UPLOAD_FILE_LINK: $link');
        final ref = db.collection("audio").doc(doc.id);
        final map = value.toJson();
        map["fileLink"] = link;
        map["id"] = id;
        await ref.update(map).then(
          (doc) {
            getAudioData();
            debugPrint('UPDATE_AUDIO_RESPONSE: TRUE');
            audioFilesUpload = [];
            audioFilesUpload.addAll(_audioUploaded.value.data ?? []);
            if (audioFilesUpload.contains(value.name)) {
              audioFilesUpload.remove(value.name);
            }
            _audioUploaded.content(audioFilesUpload);
            print('AUDIO_FILES_UPLOADED_END: ${_audioUploaded.value.data?.length}');
            audioFilesUpload = [];
            debugPrint('GET_ALL_AUDIO');
          },
          onError: (err) => debugPrint('Documents: $err'),
        );
      });
    });
  }

  Future<bool?> editAudio(AudioDto value) async {
    final ref = db.collection("audio").doc(value.id);
    final map = value.toJson();
    debugPrint('EDIT_AUDIO_RESPONSE: ${value.id}');
    if (value.bytes != null) {
      final reference = storage.ref().child('audio/${value.id}_${value.name}');
      await reference.putData(value.bytes!);
    }
    await ref.update(map).then(
      (doc) async {
        await getAudioData().then((_) {
          debugPrint('GET_ALL_AUDIO');
          _audioState.content(AudioState.list);
        });
        return true;

      },
      onError: (err) => debugPrint('Documents: $err'),
    );
  }

  void deleteAudio(AudioDto value) async {
    try {
      _audio.loading(_audio.value.data ?? []);
      debugPrint('DELETE_FILE: "audio/${value.id}_${value.name}"');
      final ref = storage.ref();
      final fileRef = ref.child("audio/${value.id}_${value.name}");
      await fileRef.delete().then((_) async {
        debugPrint('DELETE_FILE_DATA');
        final doc = db.collection("audio").doc(value.id);
        await doc.delete().then((v) async {
          await getAudioData();
        });
      });
    } on FirebaseException catch (ex) {
      print(ex);
    }
  }

  void changeAudioState() {
    _audioState.content(_audioState.value.data == AudioState.list ? AudioState.add : AudioState.list);
  }
}
