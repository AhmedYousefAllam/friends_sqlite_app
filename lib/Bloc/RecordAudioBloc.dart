import 'dart:async';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';

final pathToSaveAudio = 'audio_example.aac';
class RecordAudioBloc {
  BehaviorSubject<String> audioPathSubject = BehaviorSubject.seeded("");
  static String? mPath;
  FlutterSoundRecorder? _audioRecorder;
  bool _isRecorderInitialized = false;

  bool get isRecording => _audioRecorder!.isRecording;

  Future _record(String path) async {
    if (!_isRecorderInitialized) return;
    var tempDir = await getTemporaryDirectory();
    mPath = '${tempDir.path}/$path.aac';
    await _audioRecorder!.startRecorder(toFile: mPath);
    audioPathSubject.sink.add(mPath!);
  }

  Future _stop() async {
    if (!_isRecorderInitialized) return;
    await _audioRecorder!.stopRecorder();
  }

  Future toggleRecording(String path) async {
    if (_audioRecorder!.isStopped) {
      await _record(path);
    } else {
      await _stop();
    }
  }

  Future init() async {
    _audioRecorder = FlutterSoundRecorder();
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted) {
      throw RecordingPermissionException("mic permission is not granted");
    }

    await _audioRecorder!.openAudioSession();
    _isRecorderInitialized = true;
  }

  void dispose() {
    if (!_isRecorderInitialized) return;
    _audioRecorder!.closeAudioSession();
    _audioRecorder = null;
    _isRecorderInitialized = false;
    audioPathSubject.close();
  }
}