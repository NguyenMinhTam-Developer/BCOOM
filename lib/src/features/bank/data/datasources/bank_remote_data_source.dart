import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/bank_entity.dart';
import '../models/bank_model.dart';

abstract class BankRemoteDataSource {
  Future<BankListEntity> getBanks();

  Future<List<BankOptionEntity>> getBankOptions();

  Future<BankEntity> createBank({
    required int bankId,
    required String accountNumber,
    required String accountName,
  });

  Future<void> deleteBank({
    required int id,
  });
}

class BankRemoteDataSourceImpl implements BankRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  BankRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<BankListEntity> getBanks() async {
    final response = await _authorizedClient.get(
      '/api/customers/banks',
      query: {'limit': '999'},
    );

    RemoteDataSource.handleResponse(response);

    return BankListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<List<BankOptionEntity>> getBankOptions() async {
    final response = await _authorizedClient.get(
      '/api/customers/banks/options',
    );

    RemoteDataSource.handleResponse(response);

    final data = response.body['data'] as List<dynamic>;
    return data.map((e) => BankOptionModel.fromJson(
      e as Map<String, dynamic>,
    )).toList();
  }

  @override
  Future<BankEntity> createBank({
    required int bankId,
    required String accountNumber,
    required String accountName,
  }) async {
    final body = <String, dynamic>{
      'bank_id': bankId,
      'account_number': accountNumber,
      'account_name': accountName,
    };

    final response = await _authorizedClient.post(
      '/api/customers/banks',
      body,
    );

    RemoteDataSource.handleResponse(response);

    return BankModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> deleteBank({
    required int id,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/banks/$id/destroy',
      {},
    );

    RemoteDataSource.handleResponse(response);
  }
}
