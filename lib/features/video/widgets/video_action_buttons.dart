import 'package:flutter/material.dart';

class VideoActionButtons extends StatelessWidget {
  final int likes;
  final int dislikes;
  const VideoActionButtons({super.key, required this.likes, required this.dislikes});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _actionButton(Icons.thumb_up, likes.toString()),
        const SizedBox(width: 8),
        _actionButton(Icons.thumb_down, dislikes.toString()),
        const SizedBox(width: 8),
        _actionButton(Icons.more_horiz, ''),
      ],
    );
  }

  Widget _actionButton(IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: Colors.black),
      label: Text(label, style: const TextStyle(color: Colors.black)),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        side: const BorderSide(color: Colors.black12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    );
  }
}