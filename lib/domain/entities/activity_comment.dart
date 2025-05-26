import 'package:equatable/equatable.dart';

import 'user.dart';

class ActivityComment extends Equatable {
  final String id;

  final DateTime createdAt;

  final User user;

  final String content;

  const ActivityComment({
    required this.id,
    required this.createdAt,
    required this.user,
    required this.content,
  });

  @override
  List<Object?> get props => [id, createdAt, user, content];
}
