class UserEntity {
  final int id;
  final String? code;
  final String? fullName;
  final String? username;
  final String? phone;
  final String? email;
  final String? gender;
  final String? imageLocation;
  final String? imageUrl;
  final DateTime? birthday;
  final int? countryId;
  final DateTime? emailVerifiedAt;
  final int? status;
  final DateTime? lastLogin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? site;
  final int? objectId;
  final String? customerType;
  final String? identityCard;
  final DateTime? identityCardAt;
  final String? _avatar;
  final String? identityCardImageFrontLink;
  final String? identityCardImageBackLink;
  final String? licenseCode;
  final String? licenseImage;
  final int? provinceId;
  final int? districtId;
  final int? wardId;
  final String? address;
  final num? numberOfLessons;
  final num? numberOfGifts;
  final num? points;
  final bool isRegAkiya;

  String? _resolveImageUrl(String? path) {
    if (path == null || path.trim().isEmpty) return null;
    final trimmedPath = path.trim();

    final pathUri = Uri.tryParse(trimmedPath);
    if (pathUri != null && pathUri.hasScheme) return trimmedPath;

    final base = imageUrl?.trim();
    if (base == null || base.isEmpty) return trimmedPath;

    // Ensure exactly one "/" between base and path when joining.
    if (base.endsWith('/') && trimmedPath.startsWith('/')) {
      return '$base${trimmedPath.substring(1)}';
    }
    if (!base.endsWith('/') && !trimmedPath.startsWith('/')) {
      return '$base/$trimmedPath';
    }
    return '$base$trimmedPath';
  }

  /// `imageUrl + avatar` (or the original value if already absolute).
  String? get avatar => _resolveImageUrl(_avatar);
  String? get avatarPath => _avatar;

  /// Backwards-compatible aliases.
  String? get avatarUrl => avatar;

  String get customerTypeName {
    switch (customerType) {
      case 'customer':
        return 'Khách hàng';
      default:
        return customerType ?? '';
    }
  }

  String get partialEmail {
    if (email == null || !email!.contains('@')) {
      return email ?? '';
    }
    final parts = email!.split('@');
    final local = parts[0];
    final domain = parts[1];
    if (local.length > 3) {
      return '${local.substring(0, 3)}...@$domain';
    }
    return email!;
  }

  String get trimmedEmail {
    if (email == null || !email!.contains('@')) {
      return email ?? '';
    }
    final parts = email!.split('@');
    final local = parts[0];
    final domain = parts[1];
    if (local.length > 9) {
      // Show first 3 and last 2 chars of local part
      final first = local.substring(0, 4);
      final last = local.substring(local.length - 2);
      return '$first...$last@$domain';
    }
    // If local part is 8 or less, keep the original
    return email!;
  }

  const UserEntity({
    required this.id,
    required this.code,
    required this.fullName,
    required this.username,
    required this.phone,
    required this.email,
    required this.gender,
    required this.imageLocation,
    required this.imageUrl,
    required this.birthday,
    required this.countryId,
    required this.emailVerifiedAt,
    required this.status,
    required this.lastLogin,
    required this.createdAt,
    required this.updatedAt,
    required this.site,
    required this.objectId,
    required this.customerType,
    required this.identityCard,
    required this.identityCardAt,
    required String? avatar,
    required this.identityCardImageFrontLink,
    required this.identityCardImageBackLink,
    required this.licenseCode,
    required this.licenseImage,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
    required this.numberOfLessons,
    required this.numberOfGifts,
    required this.points,
    required this.isRegAkiya,
  }) : _avatar = avatar;
}
