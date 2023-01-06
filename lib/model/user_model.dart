import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String avatar;
  final String banner;
  final String uid;
  final bool isGuess;
  final int karma;
  final List<String> awards;
  UserModel({
    required this.name,
    required this.avatar,
    required this.banner,
    required this.uid,
    required this.isGuess,
    required this.karma,
    required this.awards,
  });

  UserModel copyWith({
    String? name,
    String? avatar,
    String? banner,
    String? uid,
    bool? isGuess,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isGuess: isGuess ?? this.isGuess,
      karma: karma ?? this.karma,
      awards: awards ?? this.awards,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'avatar': avatar,
      'banner': banner,
      'uid': uid,
      'isGuess': isGuess,
      'karma': karma,
      'awards': awards,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      name: map['name'] ?? '',
      avatar: map['avatar'] ?? '',
      banner: map['banner'] ?? '',
      uid: map['uid'] ?? '',
      isGuess: map['isGuess'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, avatar: $avatar, banner: $banner, uid: $uid, isGuess: $isGuess, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.avatar == avatar &&
        other.banner == banner &&
        other.uid == uid &&
        other.isGuess == isGuess &&
        other.karma == karma &&
        listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        banner.hashCode ^
        uid.hashCode ^
        isGuess.hashCode ^
        karma.hashCode ^
        awards.hashCode;
  }
}
