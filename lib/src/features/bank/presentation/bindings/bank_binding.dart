import 'package:get/get.dart';

import '../../../../core/network/authorized_client.dart';
import '../../data/datasources/bank_remote_data_source.dart';
import '../../data/repositories/bank_repository_impl.dart';
import '../../domain/repositories/bank_repository.dart';
import '../../domain/usecases/create_bank_usecase.dart';
import '../../domain/usecases/delete_bank_usecase.dart';
import '../../domain/usecases/get_bank_options_usecase.dart';
import '../../domain/usecases/get_banks_usecase.dart';
import '../controllers/bank_controller.dart';

class BankBinding {
  static void init() {
    // Initialize remote data source
    Get.lazyPut<BankRemoteDataSource>(
      () => BankRemoteDataSourceImpl(
        authorizedClient: Get.find<AuthorizedClient>(),
      ),
      fenix: true,
    );

    // Initialize repository
    Get.lazyPut<BankRepository>(
      () => BankRepositoryImpl(
        Get.find<BankRemoteDataSource>(),
      ),
      fenix: true,
    );

    // Initialize use cases
    Get.lazyPut<GetBanksUseCase>(
      () => GetBanksUseCase(
        bankRepository: Get.find<BankRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<GetBankOptionsUseCase>(
      () => GetBankOptionsUseCase(
        bankRepository: Get.find<BankRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<CreateBankUseCase>(
      () => CreateBankUseCase(
        bankRepository: Get.find<BankRepository>(),
      ),
      fenix: true,
    );

    Get.lazyPut<DeleteBankUseCase>(
      () => DeleteBankUseCase(
        bankRepository: Get.find<BankRepository>(),
      ),
      fenix: true,
    );

    // Initialize controller as permanent global instance
    Get.put<BankController>(
      BankController(
        getBanksUseCase: Get.find<GetBanksUseCase>(),
        getBankOptionsUseCase: Get.find<GetBankOptionsUseCase>(),
        createBankUseCase: Get.find<CreateBankUseCase>(),
        deleteBankUseCase: Get.find<DeleteBankUseCase>(),
      ),
      permanent: true,
    );
  }
}
