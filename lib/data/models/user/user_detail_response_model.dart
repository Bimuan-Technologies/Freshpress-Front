class UserResponseModel {
  final int statusCode;
  final String message;
  final UserData userData;

  UserResponseModel({
    required this.statusCode,
    required this.message,
    required this.userData,
  });

  factory UserResponseModel.fromJson(Map<String, dynamic> json) {
    return UserResponseModel(
      statusCode: json['statusCode'] as int,
      message: json['message'] as String,
      userData: UserData.fromJson(json['data'] as Map<String, dynamic>),
    );
  }
}

class UserData {
  final UserProfile profile;
  final String id;
  final String email;
  final String? username;
  final String refcode;
  final String provider;
  final bool hasVerifiedEmail;
  final bool getProductUpdate;
  final String role;
  final bool isBlocked;
  final String? blockedReason;
  final DateTime? blockedAt;
  final bool isLocked;
  final String? lockedReason;
  final DateTime? lockedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  final dynamic referrer;
  final List<dynamic> referees;
  final KycProgress kycProgress;

  UserData({
    required this.profile,
    required this.id,
    required this.email,
    this.username,
    required this.refcode,
    required this.provider,
    required this.hasVerifiedEmail,
    required this.getProductUpdate,
    required this.role,
    required this.isBlocked,
    this.blockedReason,
    this.blockedAt,
    required this.isLocked,
    this.lockedReason,
    this.lockedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.referrer,
    required this.referees,
    required this.kycProgress,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      profile: UserProfile.fromJson(json['profile'] ?? {}),
      id: json['id'] ?? '',
      email: json['email'] ?? '',
      username: json['username'],
      refcode: json['refcode'] ?? '',
      provider: json['provider'] ?? '',
      hasVerifiedEmail: json['has_verified_email'] ?? false,
      getProductUpdate: json['get_product_update'] ?? false,
      role: json['role'] ?? '',
      isBlocked: json['is_blocked'] ?? false,
      blockedReason: json['blocked_reason'],
      blockedAt: json['blocked_at'] != null ? DateTime.tryParse(json['blocked_at']) : null,
      isLocked: json['is_locked'] ?? false,
      lockedReason: json['locked_reason'],
      lockedAt: json['locked_at'] != null ? DateTime.tryParse(json['locked_at']) : null,
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
      referrer: json['referrer'],
      referees: List<dynamic>.from(json['referees'] ?? []),
      kycProgress: KycProgress.fromJson(json['kyc_progress'] ?? {}),
    );
  }
}

class UserProfile {
  final String id;
  final String? avatar;
  final String? avatarPublicId;
  final String? phoneNumber;
  final String? firstName;
  final String? lastName;
  final String? otherName;
  final String? gender;
  final String? state;
  final String? lga;
  final String? location;
  final String? postalCode;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserProfile({
    required this.id,
    this.avatar,
    this.avatarPublicId,
    this.phoneNumber,
    this.firstName,
    this.lastName,
    this.otherName,
    this.gender,
    this.state,
    this.lga,
    this.location,
    this.postalCode,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['id'] ?? '',
      avatar: json['avatar'],
      avatarPublicId: json['avatar_public_id'],
      phoneNumber: json['phone_number'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      otherName: json['other_name'],
      gender: json['gender'],
      state: json['state'],
      lga: json['lga'],
      location: json['location'],
      postalCode: json['postal_code'],
      userId: json['user_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}

class KycProgress {
  final String id;
  final bool hasVerifiedEmail;
  final bool hasVerifiedPhone;
  final bool hasProfileImage;
  final bool profileSetupComplete;
  final String userId;
  final DateTime createdAt;
  final DateTime updatedAt;

  KycProgress({
    required this.id,
    required this.hasVerifiedEmail,
    required this.hasVerifiedPhone,
    required this.hasProfileImage,
    required this.profileSetupComplete,
    required this.userId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory KycProgress.fromJson(Map<String, dynamic> json) {
    return KycProgress(
      id: json['id'] ?? '',
      hasVerifiedEmail: json['has_verified_email'] ?? false,
      hasVerifiedPhone: json['has_verified_phone'] ?? false,
      hasProfileImage: json['has_profile_image'] ?? false,
      profileSetupComplete: json['profile_setup_complete'] ?? false,
      userId: json['user_id'] ?? '',
      createdAt: DateTime.tryParse(json['created_at']) ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updated_at']) ?? DateTime.now(),
    );
  }
}


//
// class UserResponse {
//   final int statusCode;
//   final String message;
//   final UserData? data;
//
//   UserResponse({
//     required this.statusCode,
//     required this.message,
//     this.data,
//   });
//
//   factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
//     statusCode: json['statusCode'] as int,
//     message: json['message'] as String,
//     data: UserData.fromJson(json['data'] as Map<String, dynamic>?),
//   );
// }
//
// class UserData {
//   final String id;
//   final String email;
//   final String? username;
//   final String refcode;
//   final String provider;
//   final bool hasVerifiedEmail;
//   final bool getProductUpdate;
//   final String role;
//   final bool isBlocked;
//   final String? blockedReason;
//   final DateTime? blockedAt;
//   final bool isLocked;
//   final String? lockedReason;
//   final DateTime? lockedAt;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final dynamic referrer;
//   final List<dynamic> referees;
//   final KycProgress? kycProgress;
//
//   UserData({
//     required this.id,
//     required this.email,
//     this.username,
//     required this.refcode,
//     required this.provider,
//     required this.hasVerifiedEmail,
//     required this.getProductUpdate,
//     required this.role,
//     required this.isBlocked,
//     this.blockedReason,
//     this.blockedAt,
//     required this.isLocked,
//     this.lockedReason,
//     this.lockedAt,
//     required this.createdAt,
//     required this.updatedAt,
//     this.referrer,
//     required this.referees,
//     this.kycProgress,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//
//     return UserData(
//       id: json['id'] as String,
//       email: json['email'] as String,
//       username: json['username'] as String?,
//       refcode: json['refcode'] as String,
//       provider: json['provider'] as String,
//       hasVerifiedEmail: json['has_verified_email'] as bool,
//       getProductUpdate: json['get_product_update'] as bool,
//       role: json['role'] as String,
//       isBlocked: json['is_blocked'] as bool,
//       blockedReason: json['blocked_reason'] as String?,
//       blockedAt: json['blocked_at'] != null ? DateTime.parse(json['blocked_at'] as String) : null,
//       isLocked: json['is_locked'] as bool,
//       lockedReason: json['locked_reason'] as String?,
//       lockedAt: json['locked_at'] != null ? DateTime.parse(json['locked_at'] as String) : null,
//       createdAt: DateTime.parse(json['created_at'] as String),
//       updatedAt: DateTime.parse(json['updated_at'] as String),
//       referrer: json['referrer'] != null ? Referrer.fromJson(json['referrer'] as Map<String, dynamic>) : null,
//       referees: json['referees'] as List<dynamic>,
//       kycProgress: json['kyc_progress'] != null ? KycProgress.fromJson(json['kyc_progress'] as Map<String, dynamic>) : null,
//     );
//   }
// }
//
//
//
// class KycProgress {
//   final String id;
//   final bool hasVerifiedEmail;
//   final bool hasVerifiedPhone;
//   final bool hasProfileImage;
//   final bool profileSetupComplete;
//   final String userId;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//
//   KycProgress({
//     required this.id,
//     required this.hasVerifiedEmail,
//     required this.hasVerifiedPhone,
//     required this.hasProfileImage,
//     required this.profileSetupComplete,
//     required this.userId,
//     required this.createdAt,
//     required this.updatedAt,
//   });
//
//   factory KycProgress.fromJson(Map<String, dynamic> json) => KycProgress(
//     id: json['id'] as String,
//     hasVerifiedEmail: json['has_verified_email'] as bool,
//     hasVerifiedPhone: json['has_verified_phone'] as bool,
//     hasProfileImage: json['has_profile_image'] as bool,
//     profileSetupComplete: json['profile_setup_complete'] as bool,
//     userId: json['user_id'] as String,
//     createdAt: DateTime.parse(json['created_at'] as String),
//     updatedAt: DateTime.parse(json['updated_at'] as String),
//   );
// }


