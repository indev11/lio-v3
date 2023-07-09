import 'package:flutter/material.dart';
import 'package:project/colors.dart';
import 'package:project/pages/selfcare/yoga/landscape_player_page.dart';
import 'package:video_player/video_player.dart';
import 'package:perfect_volume_control/perfect_volume_control.dart';




 
 

class V1yoga extends StatefulWidget {
  const V1yoga({Key? key}) : super(key: key);

  @override
  State<V1yoga> createState() => _V1yogaState();
}

class _V1yogaState extends State<V1yoga> {
  double currentvol = 0.5;
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    /// load video from network
    // _controller = VideoPlayerController.network(
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4')
    //   ..initialize().then((_) {
    //     // Ensure the first frame is shown after the video is initialized,
    //     // even before the play button has been pressed.
    //     setState(() {});
    //   });

    /// load video from asset
    _controller = VideoPlayerController.asset("images/yoga1.mp4")..initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized,
      // even before the play button has been pressed.
      setState(() {});
    });

    /// _controller = VideoPlayerController.file(file) -> load video from file

    /// _controller.seekTo(position) -> go to specific point in video
    /// _controller.setVolume(volume) -> value between 0.0 (silent) and 1.0 (full volume)
    /// _controller.setLooping(looping) -> repeat video
  }
   String _videoDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    
    ].join(':');
  }

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Session 1"),
      ),
      body: Column(
        
        children: [
         SizedBox(height: 130,),
          
          Center(
            child: _controller!=null && _controller!.value.isInitialized? AspectRatio(
              aspectRatio: _controller!.value.aspectRatio,
              child: VideoPlayer(_controller!,),
            ) : Container(),
          ),
          Row(
            children: [
              SizedBox(width: 15,),
              Positioned(
            
            child: IconButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(builder: (context) => LandscapePlayerPage(controller: _controller!),));
              },
              icon: const Icon(
                Icons.fullscreen,
                color: primary,
                size: 30,
              ),
            ),
          ),
          
              ValueListenableBuilder(valueListenable: _controller!, builder: 
                (context, VideoPlayerValue value, child) {
                  return Text(
                    _videoDuration(value.position),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  );
                }
              ),
              Expanded(child: SizedBox(
                height: 20,
                child: VideoProgressIndicator(_controller!, allowScrubbing: true,
                padding: const EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 0,
                ),
                )
                ),
              ),
              Text(
                _videoDuration(_controller!.value.duration),
                style: const TextStyle(
                  color: primary,
                  fontSize: 20,
                ),
              ),

            ],
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: buttonPressed,
        child: Icon(
          _controller!=null && _controller!.value.isPlaying? Icons.pause : Icons.play_arrow,
        ),
      ),
    );
  }

  void buttonPressed() {
    if (_controller != null) {
      setState(() {
        _controller!.value.isPlaying? _controller!.pause() : _controller!.play();
      });
    }
  }

}
