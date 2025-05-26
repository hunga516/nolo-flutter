import 'package:flutter/material.dart';

class VideoPlayerWidget extends StatelessWidget {
  final String videoUrl;
  const VideoPlayerWidget({super.key, required this.videoUrl});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 9 / 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Ảnh/video giả lập
            Opacity(
              opacity: 0.5,
              child: Image.network(
                'https://via.placeholder.com/300x500?text=Video',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
            ),
            // Nút play
            Icon(Icons.play_circle_fill, color: Colors.white, size: 64),
            // Thanh điều khiển
            Positioned(
              left: 0,
              right: 0,
              bottom: 8,
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.volume_up, color: Colors.white),
                    onPressed: () {},
                  ),
                  const Expanded(
                    child: LinearProgressIndicator(
                      value: 0.3,
                      backgroundColor: Colors.white24,
                      color: Colors.white,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.closed_caption, color: Colors.white),
                    onPressed: () {},
                  ),
                  IconButton(
                    icon: const Icon(Icons.fullscreen, color: Colors.white),
                    onPressed: () {},
                  ),
                ],
              ),
            ),
            // Nhãn *Music*
            const Positioned(
              bottom: 40,
              child: Text(
                '*Music*',
                style: TextStyle(color: Colors.white, fontStyle: FontStyle.italic),
              ),
            ),
          ],
        ),
      ),
    );
  }
}