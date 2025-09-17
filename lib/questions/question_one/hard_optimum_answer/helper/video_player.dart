import 'package:flutter/material.dart';

class VideoPlayer extends StatelessWidget {
  const VideoPlayer({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text("assume video player for $data");
  }
}