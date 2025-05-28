import 'package:flutter/material.dart';

import '../helper/home_helper.dart';
import '../model/video_model.dart';

class VideoItem extends StatelessWidget {
  final Video video;

  const VideoItem({super.key, required this.video});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  video.thumbnailUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(color: Colors.grey[300]);
                  },
                ),
              ),
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  video.duration.isEmpty ? '0:00' : video.duration,
                  style: const TextStyle(
                      color: Colors.white, fontSize: 12),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ListTile(
          leading:  CircleAvatar(
            backgroundColor: Colors.grey.shade300,
            child: (video.user?.profilePic != null &&
                video.user!.profilePic!.isNotEmpty)
                ? ClipOval(
              child: Image.network(
                video.user!.profilePic!,
                fit: BoxFit.cover,
              ),
            )
                : Icon(Icons.person, size: 50, color: Colors.grey.shade700),
          ),
          title: Text(
            video.title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            '${video.user?.channelName} • ${video.viewCount} views • ${getTimeAgoText(video.createdAt)}',
          ),
          trailing: const Icon(Icons.more_vert),
        ),
        const SizedBox(height: 16),
      ],
    );
  }
}

