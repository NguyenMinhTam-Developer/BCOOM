import '../../../../core/services/session/session_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../value_objects/otp_code.dart';

class VerifyOtpUseCase extends UseCase<UserEntity, num?> {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  @override
  Future<Either<Failure, UserEntity>> call(num? otp) async {
    final otpCodeOrFailure = OtpCode.create(otp);

    return otpCodeOrFailure.fold(
      (failure) => Left(failure),
      (otpCode) async {
        // // 4. Save the session with updated data
        final user = await repository.verifyOtp(otp: otpCode.value);
        return user.fold(
          (failure) => Left(failure),
          (user) async {
            await SessionService.instance.updateUser();
            return Right(user);
          },
        );
      },
    );
  }
}
