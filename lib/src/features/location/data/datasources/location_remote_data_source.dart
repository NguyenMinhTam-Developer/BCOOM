import '../../../../core/network/unauthorized_client.dart';
import '../../../../core/services/remote_datasrouce.dart';
import '../../domain/entities/location_list_entity.dart';
import '../models/country_model.dart';
import '../models/province_model.dart';
import '../models/ward_model.dart';

abstract class LocationRemoteDataSource {
  Future<CountryListEntity> getCountries();

  Future<ProvinceListEntity> getProvinces();

  Future<WardListEntity> getWards({
    required String districtId,
  });
}

class LocationRemoteDataSourceImpl implements LocationRemoteDataSource {
  final UnauthorizedClient _unauthorizedClient;

  LocationRemoteDataSourceImpl({
    required UnauthorizedClient unauthorizedClient,
  }) : _unauthorizedClient = unauthorizedClient;

  @override
  Future<CountryListEntity> getCountries() async {
    final response = await _unauthorizedClient.post(
      '/api/locations/countries',
      {
        'limit': 999,
      },
    );

    RemoteDataSource.handleResponse(response);

    return CountryListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<ProvinceListEntity> getProvinces() async {
    final response = await _unauthorizedClient.post(
      '/api/locations/provinces',
      {
        'limit': 999,
      },
    );

    RemoteDataSource.handleResponse(response);

    return ProvinceListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }

  @override
  Future<WardListEntity> getWards({
    required String districtId,
  }) async {
    final response = await _unauthorizedClient.post(
      '/api/locations/wards',
      {
        'district_id': districtId,
        'limit': 999,
      },
    );

    RemoteDataSource.handleResponse(response);

    return WardListModel.fromJson(
      response.body as Map<String, dynamic>,
    );
  }
}
