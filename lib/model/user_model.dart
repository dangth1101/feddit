import 'package:flutter/foundation.dart';

class UserModel {
  final String name;
  final String avatar;
  final String banner;
  final String uid;
  final bool isGuest;
  final int karma;
  final List<String> awards;
  UserModel({
    required this.name,
    required this.avatar,
    required this.banner,
    required this.uid,
    required this.isGuest,
    required this.karma,
    required this.awards,
  });

  UserModel copyWith({
    String? name,
    String? avatar,
    String? banner,
    String? uid,
    bool? isGuest,
    int? karma,
    List<String>? awards,
  }) {
    return UserModel(
      name: name ?? this.name,
      avatar: avatar ?? this.avatar,
      banner: banner ?? this.banner,
      uid: uid ?? this.uid,
      isGuest: isGuest ?? this.isGuest,
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
      'isGuest': isGuest,
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
      isGuest: map['isGuest'] ?? false,
      karma: map['karma']?.toInt() ?? 0,
      awards: List<String>.from(map['awards']),
    );
  }

  @override
  String toString() {
    return 'UserModel(name: $name, avatar: $avatar, banner: $banner, uid: $uid, isGuest: $isGuest, karma: $karma, awards: $awards)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.name == name &&
        other.avatar == avatar &&
        other.banner == banner &&
        other.uid == uid &&
        other.isGuest == isGuest &&
        other.karma == karma &&
        listEquals(other.awards, awards);
  }

  @override
  int get hashCode {
    return name.hashCode ^
        avatar.hashCode ^
        banner.hashCode ^
        uid.hashCode ^
        isGuest.hashCode ^
        karma.hashCode ^
        awards.hashCode;
  }
}
