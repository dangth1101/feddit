import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:feddit/core/constant/firebase_constant.dart';
import 'package:feddit/core/failure.dart';
import 'package:feddit/core/provider/firebase_provider.dart';
import 'package:feddit/core/type_def.dart';
import 'package:feddit/model/user_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

final userProfileRepositoryProvider = Provider((ref) {
  return UserProfileRepository(firestore: ref.watch(firestoreProvider));
});

class UserProfileRepository {
  final FirebaseFirestore _firestore;

  UserProfileRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _users =>
      _firestore.collection(FirebaseConstant.usersCollection);

  FutureVoid editProfile(UserModel user) async {
    try {
      return right(_users.doc(user.uid).update(user.toMap()));
    } on FirebaseException catch (error) {
      throw error.message!;
    } catch (error) {
      return left(Failure(error.toString()));
    }
  }
}