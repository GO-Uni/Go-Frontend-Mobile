import 'package:flutter/material.dart';
import 'package:panorama_viewer/panorama_viewer.dart';

class PanoramaViewerWidget extends StatelessWidget {
  final String imageUrl;

  const PanoramaViewerWidget({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      width: double.infinity,
      child: PanoramaViewer(child: Image.network(imageUrl)),
    );
  }
}
