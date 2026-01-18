import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class RegisterCooperationParams {
  final String customerType;
  final String fullName;
  final String phone;
  final String email;
  final String provinceCode;
  final String job;
  final String note;

  const RegisterCooperationParams({
    required this.customerType,
    required this.fullName,
    required this.phone,
    required this.email,
    required this.provinceCode,
    required this.job,
    required this.note,
  });
}

class RegisterCooperationUseCase extends UseCase<AuthResponse, RegisterCooperationParams> {
  final AuthRepository _authRepository;

  RegisterCooperationUseCase({
    required AuthRepository authRepository,
  }) : _authRepository = authRepository;

  @override
  Future<Either<Failure, AuthResponse>> call(RegisterCooperationParams params) async {
    return await _authRepository.registerCooperation(
      customerType: params.customerType,
      fullName: params.fullName,
      phone: params.phone,
      email: params.email,
      provinceCode: params.provinceCode,
      job: params.job,
      note: params.note,
    );
  }
}
