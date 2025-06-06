import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../../domain/entities/activity.dart';
import '../../../../domain/entities/enum/friend_request_status.dart';
import '../../../../domain/entities/page.dart';
import '../../../../domain/entities/user.dart';
import '../../activity/widgets/activity_list.dart';
import '../../core/enums/infinite_scroll_list.enum.dart';
import '../../core/utils/ui_utils.dart';
import '../../core/utils/user_utils.dart';
import '../view_model/profile_picture_view_model.dart';
import '../view_model/profile_view_model.dart';
import '../widgets/friend_request.dart';


class ProfileScreen extends HookConsumerWidget {
  final User user;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey();

  ProfileScreen({super.key, required this.user});

  final futureDataProvider =
      FutureProvider.family<void, User>((ref, user) async {
    String userId = user.id;
    final profileProvider = ref.read(profileViewModelProvider(userId).notifier);
    profileProvider.getFriendshipStatus(userId);
    // Ya no se necesita profileProvider.getProfilePicture(userId);
  });

  final activitiesDataFutureProvider =
      FutureProvider.family<EntityPage<Activity>, User>((ref, user) async {
    String userId = user.id;
    final provider = ref.read(profileViewModelProvider(userId).notifier);
    return await provider.fetchActivities();
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileViewModelProvider(user.id));
    final provider = ref.watch(profileViewModelProvider(user.id).notifier);
    final futureProvider = ref.watch(futureDataProvider(user));
    final activitiesStateProvider = ref.watch(activitiesDataFutureProvider(user));

    return Scaffold(
      body: SafeArea(
        child: state.isLoading
            ? Expanded(child: Center(child: UIUtils.loader))
            : Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Image.network(
                            'https://api.dicebear.com/8.x/identicon/png?seed=${user.id}',
                            width: 150,
                            height: 150,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 100),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Center(child: UIUtils.loader);
                            },
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                UserUtils.getNameOrUsername(user),
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                              const SizedBox(height: 10),
                              futureProvider.when(
                                data: (_) {
                                  if (state.friendshipStatus !=
                                      FriendRequestStatus.noDisplay) {
                                    return FriendRequestWidget(userId: user.id);
                                  }
                                  return Container();
                                },
                                loading: () =>
                                    Center(child: UIUtils.loader),
                                error: (error, stackTrace) =>
                                    Text('$error'),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(),
                  Expanded(
                    child: RefreshIndicator(
                      key: _refreshIndicatorKey,
                      onRefresh: () async {
                        provider.refreshList();
                        return ref.refresh(activitiesDataFutureProvider(user));
                      },
                      child: Column(
                        children: [
                          activitiesStateProvider.when(
                            data: (initialData) {
                              return ActivityList(
                                id: '${InfiniteScrollListEnum.profile}_${user.id}',
                                activities: initialData.list,
                                total: initialData.total,
                                canOpenActivity: false,
                                bottomListScrollFct: provider.fetchActivities,
                              );
                            },
                            loading: () => Expanded(
                              child: Center(child: UIUtils.loader),
                            ),
                            error: (error, stackTrace) =>
                                Text('$error'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UIUtils.createBackButton(context),
    );
  }
}
