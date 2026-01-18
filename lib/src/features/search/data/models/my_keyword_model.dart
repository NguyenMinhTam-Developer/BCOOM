import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/my_keyword_entity.dart';

class MyKeywordModel extends MyKeywordEntity {
  const MyKeywordModel({
    required super.keyword,
    required super.searchedNumber,
  });

  factory MyKeywordModel.fromJson(Map<String, dynamic> json) {
    return MyKeywordModel(
      keyword: JsonMapperUtils.safeParseString(json['keyword']),
      searchedNumber: JsonMapperUtils.safeParseString(json['searched_number']),
    );
  }
}
