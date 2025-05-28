import '../../auth/model/user_model.dart';

class Video {
  final int id;
  final DateTime createdAt;
  final String userId;
  final String title;
  final String description;
  final String videoUrl;
  final String thumbnailUrl;
  final int likeCount;
  final int dislikeCount;
  final String category;
  final String duration;
  final String videoType;
  final int viewCount;
  UserModel? user; // ✅ Added this line

  Video({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.likeCount,
    required this.dislikeCount,
    required this.category,
    required this.duration,
    required this.videoType,
    required this.viewCount,
    this.user, // ✅ Added this line
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'],
      createdAt: DateTime.parse(json['created_at']),
      userId: json['user_id'],
      title: json['title'],
      description: json['description'],
      videoUrl: json['video_url'],
      thumbnailUrl: json['thumbnail_url'],
      likeCount: json['like_count'],
      dislikeCount: json['dislike_count'],
      category: json['category'],
      duration: json['duration'],
      videoType: json['video_type'],
      viewCount: json['view_count'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt.toIso8601String(),
      'user_id': userId,
      'title': title,
      'description': description,
      'video_url': videoUrl,
      'thumbnail_url': thumbnailUrl,
      'like_count': likeCount,
      'dislike_count': dislikeCount,
      'category': category,
      'duration': duration,
      'video_type': videoType,
      'view_count': viewCount,
    };
  }
}
