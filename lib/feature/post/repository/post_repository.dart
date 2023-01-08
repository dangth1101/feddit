import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feddit/core/constant/firebase_constant.dart';
import 'package:feddit/core/failure.dart';
import 'package:feddit/core/provider/firebase_provider.dart';
import 'package:feddit/core/type_def.dart';
import 'package:feddit/model/community_model.dart';
import 'package:feddit/model/post_mode.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(firestore: ref.watch(firestoreProvider));
});

class PostRepository {
  final FirebaseFirestore _firestore;

  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstant.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  Stream<List<Post>> fetchUserPosts(List<Community> communities) {
    return _posts
        .where(
          'communityName',
          whereIn: communities.map((e) => e.name).toList(),
        )
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Post.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }
}
