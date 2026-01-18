import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/address_entity.dart';
import '../../domain/repositories/address_repository.dart';
import '../datasources/address_remote_data_source.dart';

class AddressRepositoryImpl implements AddressRepository {
  final AddressRemoteDataSource remoteDataSource;

  AddressRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, AddressListEntity>> getAddresses() async {
    try {
      final response = await remoteDataSource.getAddresses();
      return Right(response);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi tải danh sách địa chỉ',
        message: e.description ?? 'Lỗi tải danh sách địa chỉ',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> createAddress({
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
    try {
      final response = await remoteDataSource.createAddress(
        name: name,
        phone: phone,
        street: street,
        note: note,
        wardCode: wardCode,
        provinceCode: provinceCode,
        lat: lat,
        lng: lng,
        isDefault: isDefault,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi tạo địa chỉ',
        message: e.description ?? 'Lỗi tạo địa chỉ',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> updateAddress({
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
    try {
      final response = await remoteDataSource.updateAddress(
        id: id,
        name: name,
        phone: phone,
        street: street,
        note: note,
        wardCode: wardCode,
        provinceCode: provinceCode,
        lat: lat,
        lng: lng,
        isDefault: isDefault,
      );
      return Right(response);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi cập nhật địa chỉ',
        message: e.description ?? 'Lỗi cập nhật địa chỉ',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> getAddress({
    required int id,
  }) async {
    try {
      final response = await remoteDataSource.getAddress(id: id);
      return Right(response);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi tải địa chỉ',
        message: e.description ?? 'Lỗi tải địa chỉ',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, AddressEntity>> setDefaultAddress({
    required int id,
  }) async {
    try {
      final response = await remoteDataSource.setDefaultAddress(id: id);
      return Right(response);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi đặt địa chỉ mặc định',
        message: e.description ?? 'Lỗi đặt địa chỉ mặc định',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAddress({
    required int id,
  }) async {
    try {
      await remoteDataSource.deleteAddress(id: id);
      return const Right(null);
    } on HttpException catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi xóa địa chỉ',
        message: e.description ?? 'Lỗi xóa địa chỉ',
      ));
    } catch (e) {
      return Left(AddressFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
