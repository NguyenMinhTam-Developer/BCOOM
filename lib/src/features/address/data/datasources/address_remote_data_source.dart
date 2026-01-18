import '../../../../core/network/authorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/address_entity.dart';
import '../models/address_model.dart';

abstract class AddressRemoteDataSource {
  Future<AddressListEntity> getAddresses();

  Future<AddressEntity> createAddress({
    required String name,
    required String phone,
    required String street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool isDefault = false,
  });

  Future<AddressEntity> updateAddress({
    required int id,
    String? name,
    String? phone,
    String? street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool? isDefault,
  });

  Future<AddressEntity> getAddress({
    required int id,
  });

  Future<AddressEntity> setDefaultAddress({
    required int id,
  });

  Future<void> deleteAddress({
    required int id,
  });
}

class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final AuthorizedClient _authorizedClient;

  AddressRemoteDataSourceImpl({
    required AuthorizedClient authorizedClient,
  }) : _authorizedClient = authorizedClient;

  @override
  Future<AddressListEntity> getAddresses() async {
    final response = await _authorizedClient.post(
      '/api/customers/address',
      {},
    );

    RemoteDataSource.handleResponse(response);

    return AddressListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<AddressEntity> createAddress({
    required String name,
    required String phone,
    required String street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool isDefault = false,
  }) async {
    final body = <String, dynamic>{
      'name': name,
      'phone': phone,
      'street': street,
    };

    // Always include province_code and ward_code if provided
    if (provinceCode != null && provinceCode.isNotEmpty) {
      body['province_code'] = provinceCode;
    }
    if (wardCode != null && wardCode.isNotEmpty) {
      body['ward_code'] = wardCode;
    }
    // Include note (can be empty string)
    if (note != null) {
      body['note'] = note;
    }
    if (lat != null) body['lat'] = lat;
    if (lng != null) body['lng'] = lng;
    if (isDefault) body['is_default'] = 1;

    final response = await _authorizedClient.post(
      '/api/customers/address/create',
      body,
    );

    RemoteDataSource.handleResponse(response);

    return AddressModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<AddressEntity> updateAddress({
    required int id,
    String? name,
    String? phone,
    String? street,
    String? note,
    String? wardCode,
    String? provinceCode,
    num? lat,
    num? lng,
    bool? isDefault,
  }) async {
    final body = <String, dynamic>{};

    // Always include required fields if provided
    if (name != null) body['name'] = name;
    if (phone != null) body['phone'] = phone;
    if (street != null) body['street'] = street;
    
    // Include province_code and ward_code if provided
    if (provinceCode != null && provinceCode.isNotEmpty) {
      body['province_code'] = provinceCode;
    }
    if (wardCode != null && wardCode.isNotEmpty) {
      body['ward_code'] = wardCode;
    }
    
    // Include note (can be empty string or null)
    if (note != null) {
      body['note'] = note;
    }
    
    if (lat != null) body['lat'] = lat;
    if (lng != null) body['lng'] = lng;
    if (isDefault != null) body['is_default'] = isDefault ? 1 : 0;

    final response = await _authorizedClient.post(
      '/api/customers/address/$id/update',
      body,
    );

    RemoteDataSource.handleResponse(response);

    return AddressModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<AddressEntity> getAddress({
    required int id,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/address/$id/show',
      {},
    );

    RemoteDataSource.handleResponse(response);

    return AddressModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<AddressEntity> setDefaultAddress({
    required int id,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/address/$id/set-default',
      {},
    );

    RemoteDataSource.handleResponse(response);

    return AddressModel.fromJson(
      response.body['data'] as Map<String, dynamic>,
    );
  }

  @override
  Future<void> deleteAddress({
    required int id,
  }) async {
    final response = await _authorizedClient.post(
      '/api/customers/address/$id/destroy',
      {},
    );

    RemoteDataSource.handleResponse(response);
  }
}
