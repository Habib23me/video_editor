import 'package:flutter/material.dart';
import 'package:video_editor/domain/bloc/controller.dart';
import 'package:video_player/video_player.dart';

class VideoViewer extends StatefulWidget {
  const VideoViewer({
    Key? key,
    required this.controller,
    this.child,
  }) : super(key: key);

  final VideoEditorController? controller;
  final Widget? child;

  @override
  State<VideoViewer> createState() => _VideoViewerState();
}

class _VideoViewerState extends State<VideoViewer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = widget.controller!.video;
    super.initState();
  }

  double get aspectRatio => _controller.value.size.aspectRatio > 0.8
      ? _controller.value.size.aspectRatio
      : MediaQuery.of(context).size.width /
          (MediaQuery.of(context).size.height - 80);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_controller.value.isPlaying) {
          _controller.pause();
        } else {
          _controller.play();
        }
      },
      child: Center(
        child: Stack(children: [
          Align(
            alignment: Alignment.center,
            child: AspectRatio(
              aspectRatio: aspectRatio,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          ),
          if (widget.child != null)
            AspectRatio(
              aspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height - 80),
              child: widget.child,
            ),
        ]),
      ),
    );
  }
}
