import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './audio_player_view_model.dart';

class AudioPlayerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(top: 10, bottom: 10),
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Consumer<AudioPlayerViewModel>(
            builder: (context, viewModel, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // 재생 버튼
              Expanded(
                flex: 1,
                child: IconButton(
                    onPressed: () {
                      // playSound
                      if (viewModel.isPlaying) {
                        viewModel.pauseRecordedFile();
                      } else {
                        viewModel.playRecordedFile();
                      }
                    },
                    icon: Icon(
                      viewModel.isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.black,
                    )),
              ),
              // 프로그레스 바
              Expanded(
                flex: 5,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.65,
                  child: viewModel.duration != Duration(seconds: 0)
                      ? Slider(
                          // 현재 위치
                          value: viewModel.audioPosition.inSeconds.toDouble(),
                          // 최대 길이 = 음성 파일 길이
                          max: viewModel.duration!.inSeconds.toDouble(),
                          onChanged: (value) {
                            // 위치 지속적으로 갱신
                            final position = Duration(seconds: value.toInt());
                            viewModel.seekTo(position);
                          },
                        )
                      : Slider(
                          value: 0,
                          max: 0,
                          onChanged: (double value) {},
                        ),
                ),
              ),
              Expanded(
                flex: 1,
                  child: viewModel.duration != Duration(seconds: 0)
                      ? viewModel.duration!.inSeconds.toInt() <= 9
                      ? Text('00:0${viewModel.duration!.inSeconds.toInt()}')
                      : Text('00:${viewModel.duration!.inSeconds.toInt()}')
                      : Text('00:00')
              )
            ],
          );
        }));
  }
}
