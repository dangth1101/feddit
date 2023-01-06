import 'package:feddit/core/common/error_text.dart';
import 'package:feddit/core/common/loading.dart';
import 'package:feddit/feature/authentication/controller/auth_controller.dart';
import 'package:feddit/feature/community/controller/community_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddModScreen extends ConsumerStatefulWidget {
  final String name;
  const AddModScreen({super.key, required this.name});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddModScreenState();
}

class _AddModScreenState extends ConsumerState<AddModScreen> {
  int cnt = 0;
  List<String> mods = [];

  void addMod(String uid) {
    mods.add(uid);
  }

  void removeMod(String uid) {
    mods.remove(uid);
  }

  void saveMods() {
    ref
        .read(communityControllerProvider.notifier)
        .addMod(widget.name, mods, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: saveMods,
            icon: const Icon(Icons.done),
          ),
        ],
      ),
      body: ref.watch(getCommunityByNameProvider(widget.name)).when(
            data: (community) => ListView.builder(
              itemCount: community.members.length,
              itemBuilder: (context, index) {
                final memberID = community.members[index];
                if (community.mods.contains(memberID) && cnt == 0) {
                  mods.add(memberID);
                }
                return ref.watch(getUserDataProvider(memberID)).when(
                      data: (user) {
                        cnt++;
                        return CheckboxListTile(
                          value: mods.contains(user.uid),
                          onChanged: (val) {
                            if (val!) {
                              addMod(user.uid);
                            } else {
                              removeMod(user.uid);
                            }
                          },
                          title: Text(user.name),
                        );
                      },
                      error: (error, stackTrace) => ErrorText(
                        error: error.toString(),
                      ),
                      loading: () => const Loading(),
                    );
              },
            ),
            error: (error, stackTrace) => ErrorText(
              error: error.toString(),
            ),
            loading: () => const Loading(),
          ),
    );
  }
}
