class CommentModel {
  final int id;
  final String createdAt;
  final String userId;
  final String commentText;
  final String videoId;

  CommentModel({
    required this.id,
    required this.createdAt,
    required this.userId,
    required this.commentText,
    required this.videoId,
  });

  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
      id: json['id'],
      createdAt: json['created_at'],
      userId: json['user_id'],
      commentText: json['comment_text'],
      videoId: json['video_id'],
    );
  }
}
