import 'package:feddit/core/common/error_text.dart';
import 'package:feddit/core/common/loading.dart';
import 'package:feddit/core/common/post_card.dart';
import 'package:feddit/feature/authentication/controller/auth_controller.dart';
import 'package:feddit/feature/community/controller/community_controller.dart';
import 'package:feddit/feature/post/controller/post_controller.dart';
import 'package:feddit/theme/pallet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreen extends ConsumerWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    final isGuest = user.isGuest;
    if (!isGuest) {
      return ref.watch(userCommunityProvider).when(
            data: (communities) =>
                ref.watch(userPostProvider(communities)).when(
                      data: (posts) {
                        return ListView.builder(
                          itemCount: posts.length,
                          itemBuilder: ((context, index) {
                            final post = posts[index];
                            return PostCard(post: post);
                          }),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loading(),
                    ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loading(),
          );
    } else {
      return ref.watch(userCommunityProvider).when(
            data: (communities) => ref.watch(guestPostProvider).when(
                  data: (posts) {
                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: ((context, index) {
                        final post = posts[index];
                        return PostCard(post: post);
                      }),
                    );
                  },
                  error: (error, stackTrace) => ErrorText(
                    error: error.toString(),
                  ),
                  loading: () => const Loading(),
                ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loading(),
          );
    }
  }
}
