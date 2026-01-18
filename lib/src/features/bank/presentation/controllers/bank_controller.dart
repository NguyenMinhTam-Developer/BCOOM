import 'package:get/get.dart';

import '../../../../core/services/session/session_service.dart';
import '../../../../core/usecases/usecase.dart';
import '../../../auth/domain/entities/user.dart';
import '../../domain/entities/bank_entity.dart';
import '../../domain/usecases/create_bank_usecase.dart';
import '../../domain/usecases/delete_bank_usecase.dart';
import '../../domain/usecases/get_bank_options_usecase.dart';
import '../../domain/usecases/get_banks_usecase.dart';

class BankController extends GetxController {
  final GetBanksUseCase _getBanksUseCase;
  final GetBankOptionsUseCase _getBankOptionsUseCase;
  final CreateBankUseCase _createBankUseCase;
  final DeleteBankUseCase _deleteBankUseCase;

  BankController({
    required GetBanksUseCase getBanksUseCase,
    required GetBankOptionsUseCase getBankOptionsUseCase,
    required CreateBankUseCase createBankUseCase,
    required DeleteBankUseCase deleteBankUseCase,
  })  : _getBanksUseCase = getBanksUseCase,
        _getBankOptionsUseCase = getBankOptionsUseCase,
        _createBankUseCase = createBankUseCase,
        _deleteBankUseCase = deleteBankUseCase;

  final RxBool isLoading = false.obs;
  final RxList<BankEntity> banks = <BankEntity>[].obs;
  final RxList<BankOptionEntity> bankOptions = <BankOptionEntity>[].obs;

  bool _isUserVerified(UserEntity? user) => user?.emailVerifiedAt != null;

  @override
  Future<void> onInit() async {
    super.onInit();
    final sessionService = Get.find<SessionService>();

    // Only load bank data (options + list) if user is verified
    if (_isUserVerified(sessionService.currentUser.value)) {
      await loadBankOptions();
      await loadBanks();
    } else {
      banks.clear();
      bankOptions.clear();
    }
    
    // Listen to user changes to load bank data when user becomes verified
    ever<UserEntity?>(sessionService.currentUser, (user) {
      if (_isUserVerified(user)) {
        loadBankOptions();
        loadBanks();
      } else {
        banks.clear();
        bankOptions.clear();
      }
    });
  }

  Future<void> loadBanks() async {
    isLoading.value = true;
    final result = await _getBanksUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        banks.clear();
      },
      (entity) {
        banks.value = entity.banks;
      },
    );
    isLoading.value = false;
  }

  Future<void> loadBankOptions() async {
    final result = await _getBankOptionsUseCase(NoParams());
    result.fold(
      (failure) {
        Get.snackbar(
          failure.title,
          failure.message,
          snackPosition: SnackPosition.BOTTOM,
        );
        bankOptions.clear();
      },
      (options) {
        bankOptions.value = options;
      },
    );
  }

  Future<void> createBank({
    required int bankId,
    required String accountNumber,
    required String accountName,
  }) async {
    isLoading.value = true;
    final result = await _createBankUseCase(
      CreateBankParams(
        bankId: bankId,
        accountNumber: accountNumber,
        accountName: accountName,
      ),
    );
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (entity) {
        banks.add(entity);
        Get.snackbar('Thành công', 'Tạo tài khoản ngân hàng thành công');
        loadBanks(); // Reload to get updated list
      },
    );
    isLoading.value = false;
  }

  Future<void> deleteBank(int id) async {
    isLoading.value = true;
    final result = await _deleteBankUseCase(DeleteBankParams(id: id));
    result.fold(
      (failure) => Get.snackbar(failure.title, failure.message),
      (_) {
        banks.removeWhere((b) => b.id == id);
        Get.snackbar('Thành công', 'Xóa tài khoản ngân hàng thành công');
      },
    );
    isLoading.value = false;
  }
}
