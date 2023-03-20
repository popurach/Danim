import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';



class AudioPlayerViewModel extends ChangeNotifier{
  // 파일 경로
  late String? audioFilePath;
  late bool _playStarted = false;
  late bool _isPlaying = false;
  late Duration _duration = Duration(seconds: 0);

  AudioPlayer audioPlayer = AudioPlayer();
  Duration _audioPosition = Duration.zero;

  String? get getAudioFilePath => audioFilePath;

  bool get playStarted => _playStarted;
  set playStarted(bool newBool) {
    _playStarted = newBool;
  }

  bool get isPlaying => _isPlaying;
  set isPlaying(bool newBool) {
    _isPlaying = newBool;
  }

  Duration get duration => _duration;
  set duration(Duration newDuration) {
    _duration = newDuration;
  }

  Duration get audioPosition => _audioPosition;
  set audioPosition(Duration newPosition) {
    _audioPosition = newPosition;
  }

  // optional parameter
  AudioPlayerViewModel({this.audioFilePath});


  // 재생 시작
  Future<void> playRecordedFile() async {
    await audioPlayer.play(DeviceFileSource(audioFilePath!));
    if (audioFilePath == null) {
      return;
    }
    isPlaying = true;
    notifyListeners();

    // 녹음이 완료 되었을 때 변수 바꿔주기
    audioPlayer.onPlayerComplete.listen((event) {
      isPlaying = false;
      notifyListeners();
    });

    // 음성 파일에서의 현재 위치 갱신
    audioPlayer.onPositionChanged.listen((curPos) {
      audioPosition = curPos;
      notifyListeners();
    });

    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });

  }

  // 일시정지
  Future<void> pauseRecordedFile() async {
    audioPlayer.pause();
    isPlaying = false;
    notifyListeners();
  }

  // 계속 재생
  Future<void> resumeRecordedFile() async {
    audioPlayer.resume();
    isPlaying = true;
    notifyListeners();
  }

  // 완전 멈춤
  Future<void> stopRecordedFile() async {
    audioPlayer.stop();
    isPlaying = false;
    notifyListeners();
  }

  // 위치 갱신
  void updateAudioPosition(Duration position) {
    _audioPosition = position;
    notifyListeners();
  }

  // 현재 위치 참조
  Future<void> seekTo(Duration position) async {
    await audioPlayer.seek(position);
    updateAudioPosition(position);
  }
}