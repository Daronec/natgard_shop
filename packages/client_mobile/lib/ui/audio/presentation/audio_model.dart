import 'package:shared/imports.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class AudioModel extends BaseModel {
  late FirebaseFirestore db;
  late FirebaseStorage storage;

  final _audio = UnionStateNotifier<List<AudioDto>>.new([]);
  final _audioUploaded = UnionStateNotifier<List<String>>.new([]);
  final _result = UnionStateNotifier<bool>.new(false);
  final _uploadState = UnionStateNotifier<bool>.new(false);
  String? fileLink;

  /// State of screen.
  UnionStateNotifier<List<AudioDto>> get audio => _audio;

  UnionStateNotifier<List<String>> get audioUploaded => _audioUploaded;

  UnionStateNotifier<bool> get result => _result;

  UnionStateNotifier<bool> get uploadState => _uploadState;

  /// {@macro feature_example_model.class}
  AudioModel({
    required super.logWriter,
  })  : db = FirebaseFirestore.instance,
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
    List<AudioDto> audioList = [];
    await db.collection("audio").get().then(
          (doc) {
        if (doc.docs.isNotEmpty) {
          audioList.addAll(
            doc.docs.map(
                  (e) => AudioDto.fromJson(e.data()),
            ),
          );
        }
      },
      onError: (err) => print('Documents: $err'),
    );
    _audio.content(audioList);

  }

  void addAudio(AudioDto value) {
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

  void editAudio(AudioDto value) {
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

  void deleteAudio(AudioDto value) async {
    try {
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
}
