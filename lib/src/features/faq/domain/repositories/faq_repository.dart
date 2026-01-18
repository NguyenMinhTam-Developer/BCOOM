import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';
import '../entities/faq_category_list_entity.dart';
import '../entities/faq_list_entity.dart';

abstract class FaqRepository {
  Future<Either<Failure, FaqCategoryListEntity>> getFaqCategories();

  Future<Either<Failure, FaqListEntity>> getFaqs({
    required int categoryId,
  });

  Future<Either<Failure, FaqListEntity>> getAllFaqs();
}
