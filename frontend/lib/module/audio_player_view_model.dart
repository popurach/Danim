import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';

class AudioPlayerViewModel extends ChangeNotifier {
  // 파일 경로
  String? _audioFilePath;
  late bool _playStarted = false;
  late bool _isPlaying = false;
  late Duration _duration = const Duration(microseconds: 0);

  final AudioPlayer audioPlayer = AudioPlayer();
  Duration _audioPosition = Duration.zero;

  String? get getAudioFilePath => _audioFilePath;

  set audioFilePath(String value) {
    _audioFilePath = value;
  }

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
  AudioPlayerViewModel(this._audioFilePath) {
    audioPlayer.onDurationChanged.listen((newDuration) {
      duration = newDuration;
      notifyListeners();
    });
    if (_audioFilePath != null) initDuration();
  }

  Future<void> initDuration() async {
    await audioPlayer.setSourceUrl(_audioFilePath!);
  }

  // 재생 시작
  Future<void> playRecordedFile() async {
    if (isPlaying == true ||
        getAudioFilePath == null ||
        getAudioFilePath!.isEmpty) {
      return;
    } else {
      await audioPlayer.play(DeviceFileSource(_audioFilePath!));
      isPlaying = true;

      notifyListeners();
      // 재생이 완료 되었을 때 변수 바꿔주기
      audioPlayer.onPlayerComplete.listen((event) {
        isPlaying = false;
        notifyListeners();
      });

      // 음성 파일에서의 현재 위치 갱신
      audioPlayer.onPositionChanged.listen((curPos) {
        audioPosition = curPos;
        notifyListeners();
      });
    }
  }

  // 일시정지
  Future<void> pauseRecordedFile() async {
    if (isPlaying == true) {
      audioPlayer.pause();
      isPlaying = false;
      notifyListeners();
    } else {
      return;
    }
  }

  // 계속 재생
  Future<void> resumeRecordedFile() async {
    if (isPlaying == false) {
      audioPlayer.resume();
      isPlaying = true;
      notifyListeners();
    } else {
      return;
    }
  }

  // 완전 멈춤
  Future<void> stopRecordedFile() async {
    if (isPlaying == true) {
      audioPlayer.stop();
      isPlaying = false;
      notifyListeners();
    } else {
      return;
    }
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

  getDurationTimeToString() {
    return timeToString(duration.inSeconds);
  }

  getAudioPosTimeToString() {
    return timeToString(audioPosition.inSeconds);
  }

  timeToString(int time) {
    if (time <= 9) return '00:0$time';
    return '00:$time';
  }
}
