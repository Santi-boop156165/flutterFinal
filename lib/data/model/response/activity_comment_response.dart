import 'package:equatable/equatable.dart';

import '../../../domain/entities/activity_comment.dart';
import 'user_response.dart';

class ActivityCommentResponse extends Equatable {
  final String id;

  final DateTime createdAt;

  final UserResponse user;

  final String content;

  const ActivityCommentResponse(
      {required this.id,
      required this.createdAt,
      required this.user,
      required this.content});

  @override
  List<Object?> get props => [id, createdAt, user, content];

  factory ActivityCommentResponse.fromMap(Map<String, dynamic> map) {
    return ActivityCommentResponse(
        id: map['id'].toString(),
        createdAt: DateTime.parse(map['createdAt']),
        user: UserResponse.fromMap(map['user']),
        content: map['content'].toString());
  }

  ActivityComment toEntity() {
    return ActivityComment(
      id: id,
      createdAt: createdAt,
      user: user.toEntity(),
      content: content,
    );
  }
}
