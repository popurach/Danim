import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';



class AudioPlayerViewModel extends ChangeNotifier{
  // 파일 경로
  late String? audioFilePath;

  late bool playStarted = false;
  late bool isPlaying = false;
  late Duration? duration = Duration(seconds: 0);

  AudioPlayer audioPlayer = AudioPlayer();

  // optional parameter
  AudioPlayerViewModel({this.audioFilePath});

  Duration _audioPosition = Duration.zero;
  Duration get audioPositon => _audioPosition;

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
      _audioPosition = curPos;
      notifyListeners();
    });

    audioPlayer.onDurationChanged.listen((duration) {
      this.duration = duration ?? Duration(seconds: 0);
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