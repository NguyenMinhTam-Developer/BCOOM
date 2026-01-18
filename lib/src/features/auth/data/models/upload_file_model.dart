import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/api_file.dart';

class UploadFileModel extends ApiFileEntity {
  UploadFileModel({
    required super.type,
    required super.fileName,
    required super.name,
    required super.size,
    super.linkView,
  });

  factory UploadFileModel.fromJson(Map<String, dynamic> json) {
    return UploadFileModel(
      type: JsonMapperUtils.safeParseString(json['type']),
      fileName: JsonMapperUtils.safeParseString(json['filename']),
      name: JsonMapperUtils.safeParseString(json['name']),
      size: JsonMapperUtils.safeParseInt(json['size']),
      linkView: JsonMapperUtils.safeParseString(json['link_view']),
    );
  }
}
