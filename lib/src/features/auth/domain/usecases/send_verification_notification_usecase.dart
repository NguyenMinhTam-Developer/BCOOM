import 'package:dartz/dartz.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../../core/errors/failures.dart';
import '../repositories/auth_repository.dart';

class SendVerificationNotificationUseCase extends UseCase<DateTime, NoParams> {
  final AuthRepository repository;

  SendVerificationNotificationUseCase(this.repository);

  @override
  Future<Either<Failure, DateTime>> call(NoParams params) {
    return repository.sendVerificationNotification();
  }
}
