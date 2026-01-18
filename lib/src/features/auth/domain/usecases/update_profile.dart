import 'dart:io';

import 'package:dartz/dartz.dart';
import '../../../../core/services/session/session_service.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../repositories/upload_file_repository.dart';
import '../value_objects/date_of_birth.dart';
import '../value_objects/name.dart';

class UpdateProfileParams {
  final File? avatar;
  final Name name;
  final DateOfBirth birthday;
  final String? gender;
  final int? countryId;
  final File? identityCardImageFront;
  final File? identityCardImageBack;

  final String? initialAvatarUrl;
  final String? initialIdentityCardImageFrontUrl;
  final String? initialIdentityCardImageBackUrl;

  const UpdateProfileParams({
    required this.avatar,
    required this.name,
    required this.birthday,
    required this.gender,
    required this.countryId,
    required this.identityCardImageFront,
    required this.identityCardImageBack,
    required this.initialAvatarUrl,
    required this.initialIdentityCardImageFrontUrl,
    required this.initialIdentityCardImageBackUrl,
  });

  static Either<InputValidationFailure, UpdateProfileParams> create({
    required File? avatar,
    required String? name,
    required DateTime? birthday,
    required String? gender,
    required int? countryId,
    required File? identityCardImageFront,
    required File? identityCardImageBack,
    required String? initialAvatarUrl,
    required String? initialIdentityCardImageFrontUrl,
    required String? initialIdentityCardImageBackUrl,
  }) {
    final nameValidation = Name.create(name);
    final birthdayValidation = DateOfBirth.create(birthday);

    return nameValidation.fold(
      (failure) => left(failure),
      (validName) => birthdayValidation.fold(
        (failure) => left(failure),
        (validBirthday) => right(UpdateProfileParams(
          avatar: avatar,
          name: validName,
          birthday: validBirthday,
          gender: gender,
          countryId: countryId,
          identityCardImageFront: identityCardImageFront,
          identityCardImageBack: identityCardImageBack,
          initialAvatarUrl: initialAvatarUrl,
          initialIdentityCardImageFrontUrl: initialIdentityCardImageFrontUrl,
          initialIdentityCardImageBackUrl: initialIdentityCardImageBackUrl,
        )),
      ),
    );
  }
}

class UpdateProfileUseCase implements UseCase<UserEntity, UpdateProfileParams> {
  final AuthRepository _authRepository;
  final UploadFileRepository _uploadFileRepository;

  UpdateProfileUseCase({
    required AuthRepository authRepository,
    required UploadFileRepository uploadFileRepository,
  })  : _authRepository = authRepository,
        _uploadFileRepository = uploadFileRepository;

  @override
  Future<Either<Failure, UserEntity>> call(UpdateProfileParams params) async {
    String? avatarUrl; //= params.initialAvatarUrl;
    String? identityCardImageFrontUrl; //= params.initialIdentityCardImageFrontUrl;
    String? identityCardImageBackUrl; //= params.initialIdentityCardImageBackUrl;

    try {
      await Future.wait([
        if (params.avatar != null)
          _uploadFileRepository.uploadFileAuthorized(files: [params.avatar!]).then(
            (result) {
              return result.fold(
                (failure) => throw failure,
                (response) {
                  avatarUrl = response.first.name;
                  return response;
                },
              );
            },
          ),
        if (params.identityCardImageFront != null)
          _uploadFileRepository.uploadFileAuthorized(files: [params.identityCardImageFront!]).then(
            (result) {
              return result.fold(
                (failure) => throw failure,
                (response) {
                  identityCardImageFrontUrl = response.first.name;
                  return response;
                },
              );
            },
          ),
        if (params.identityCardImageBack != null)
          _uploadFileRepository.uploadFileAuthorized(files: [params.identityCardImageBack!]).then(
            (result) {
              return result.fold(
                (failure) => throw failure,
                (response) {
                  identityCardImageBackUrl = response.first.name;
                  return response;
                },
              );
            },
          ),
      ]);

      final result = await _authRepository.updateProfile(
        avatar: avatarUrl,
        fullName: params.name.value,
        dateOfBirth: params.birthday.value,
        gender: params.gender,
        countryId: params.countryId,
        identityCardImageFront: identityCardImageFrontUrl,
        identityCardImageBack: identityCardImageBackUrl,
      );

      return result.fold(
        (failure) => left(failure),
        (user) {
          SessionService.instance.updateSessionWithUser(user);

          return right(user);
        },
      );
    } catch (e) {
      return left(UnknownFailure(
        title: 'Update Profile Failed',
        message: e.toString(),
      ));
    }
  }
}
