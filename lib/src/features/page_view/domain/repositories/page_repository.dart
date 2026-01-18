import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/page_entity.dart';

abstract class PageRepository {
  Future<Either<Failure, PageEntity>> getPage({
    required String slug,
  });
}
