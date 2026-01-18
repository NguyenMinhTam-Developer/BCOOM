import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/faq_category_list_entity.dart';
import '../../domain/entities/faq_list_entity.dart';
import '../../domain/repositories/faq_repository.dart';
import '../datasources/faq_remote_data_source.dart';

class FaqRepositoryImpl implements FaqRepository {
  final FaqRemoteDataSource _remoteDataSource;

  FaqRepositoryImpl({
    required FaqRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, FaqCategoryListEntity>> getFaqCategories() async {
    try {
      final result = await _remoteDataSource.getFaqCategories();
      return Right(result);
    } on HttpException catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi tải danh mục FAQ',
        message: e.description ?? 'Lỗi tải danh mục FAQ',
      ));
    } catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, FaqListEntity>> getFaqs({
    required int categoryId,
  }) async {
    try {
      final result = await _remoteDataSource.getFaqs(categoryId: categoryId);
      return Right(result);
    } on HttpException catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi tải danh sách FAQ',
        message: e.description ?? 'Lỗi tải danh sách FAQ',
      ));
    } catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }

  @override
  Future<Either<Failure, FaqListEntity>> getAllFaqs() async {
    try {
      final result = await _remoteDataSource.getAllFaqs();
      return Right(result);
    } on HttpException catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi tải danh sách FAQ',
        message: e.description ?? 'Lỗi tải danh sách FAQ',
      ));
    } catch (e) {
      return Left(FaqFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
