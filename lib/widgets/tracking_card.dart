import 'package:flutter/material.dart';

class TrackingCard extends StatelessWidget {
  final String title;
  final String imageAsset;
  final VoidCallback onTap;

  const TrackingCard({
    Key? key,
    required this.title,
    required this.imageAsset,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Image.asset(imageAsset)),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 16)),
            const SizedBox(height: 4),
            const Text("0", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            const Text("+ Know More", style: TextStyle(color: Colors.amber)),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
