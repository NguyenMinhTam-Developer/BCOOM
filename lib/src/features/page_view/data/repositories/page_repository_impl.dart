import 'package:dartz/dartz.dart';

import '../../../../core/errors/exception.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/page_entity.dart';
import '../../domain/repositories/page_repository.dart';
import '../datasources/page_remote_data_source.dart';

class PageFailure extends Failure {
  const PageFailure({super.title = 'Lỗi trang', required super.message});
}

class PageRepositoryImpl implements PageRepository {
  final PageRemoteDataSource _remoteDataSource;

  PageRepositoryImpl({
    required PageRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<Either<Failure, PageEntity>> getPage({
    required String slug,
  }) async {
    try {
      final result = await _remoteDataSource.getPage(slug: slug);
      return Right(result);
    } on HttpException catch (e) {
      return Left(PageFailure(
        title: 'Lỗi tải trang',
        message: e.description ?? 'Lỗi tải trang',
      ));
    } catch (e) {
      return Left(PageFailure(
        title: 'Lỗi không xác định',
        message: 'Lỗi không xác định',
      ));
    }
  }
}
