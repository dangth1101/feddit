import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feddit/core/constant/firebase_constant.dart';
import 'package:feddit/core/failure.dart';
import 'package:feddit/core/provider/firebase_provider.dart';
import 'package:feddit/core/type_def.dart';
import 'package:feddit/model/comment_model.dart';
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

  CollectionReference get _comments =>
      _firestore.collection(FirebaseConstant.commentsCollection);

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstant.usersCollection);

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

  FutureVoid deletePost(Post post) async {
    try {
      return right(_posts.doc(post.id).delete());
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  void upVote(Post post, String userID) async {
    if (post.downvotes.contains(userID)) {
      _posts.doc(post.id).update({
        'downvotes': FieldValue.arrayRemove([userID]),
      });
    }

    if (post.upvotes.contains(userID)) {
      _posts.doc(post.id).update({
        'upvotes': FieldValue.arrayRemove([userID])
      });
    } else {
      _posts.doc(post.id).update({
        'upvotes': FieldValue.arrayUnion([userID])
      });
    }
  }

  void downVote(Post post, String userID) async {
    if (post.upvotes.contains(userID)) {
      _posts.doc(post.id).update({
        'upvotes': FieldValue.arrayRemove([userID]),
      });
    }

    if (post.downvotes.contains(userID)) {
      _posts.doc(post.id).update({
        'downvotes': FieldValue.arrayRemove([userID])
      });
    } else {
      _posts.doc(post.id).update({
        'downvotes': FieldValue.arrayUnion([userID])
      });
    }
  }

  Stream<Post> getPostById(String id) {
    return _posts
        .doc(id)
        .snapshots()
        .map((event) => Post.fromMap(event.data() as Map<String, dynamic>));
  }

  FutureVoid addComment(Comment comment) async {
    try {
      await _comments.doc(comment.id).set(comment.toMap());

      return right(_posts.doc(comment.postId).update({
        'commentCount': FieldValue.increment(1),
      }));
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }

  Stream<List<Comment>> getComments(String postId) {
    return _comments
        .where('postId', isEqualTo: postId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (event) => event.docs
              .map(
                (e) => Comment.fromMap(
                  e.data() as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  FutureVoid awardPost(Post post, String award, String senderId) async {
    try {
      _posts.doc(post.id).update({
        'awards': FieldValue.arrayUnion([award]),
      });
      _users.doc(senderId).update({
        'awards': FieldValue.arrayRemove([award]),
      });
      return right(_users.doc(post.uid).update({
        'awards': FieldValue.arrayUnion([award]),
      }));
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }
}
