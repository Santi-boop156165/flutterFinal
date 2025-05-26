import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/entities/activity.dart';
import '../../core/utils/color_utils.dart';
import '../../core/utils/ui_utils.dart';
import '../../core/utils/user_utils.dart';
import '../../user/view_model/profile_picture_view_model.dart';
import '../view_model/activity_item_view_model.dart';

class ActivityItemUserInformation extends StatelessWidget {
  final Activity activity;

  const ActivityItemUserInformation({super.key, required this.activity});

  // Ejemplo con DiceBear (puedes cambiar por robohash.org, etc.)
  String getProfileImageUrl(String userId) {
    return 'https://api.dicebear.com/8.x/identicon/png?seed=$userId';
    // Alternativas:
    // 'https://robohash.org/$userId'
    // 'https://ui-avatars.com/api/?name=${Uri.encodeComponent(name)}'
  }

  Widget buildProfilePicture(String userId) {
    final imageUrl = getProfileImageUrl(userId);
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Image.network(
        imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => UserUtils.personIcon,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(child: UIUtils.loader);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = activity.user.id;
    final name = UserUtils.getNameOrUsername(activity.user);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: ColorUtils.greyLight,
              width: 0.5,
            ),
          ),
        ),
        child: TextButton(
          onPressed: () => UserUtils.goToProfile(activity.user),
          child: Row(
            children: [
              buildProfilePicture(userId),
              const SizedBox(width: 20),
              Flexible(
                child: Text(
                  name,
                  style: TextStyle(color: ColorUtils.black),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
