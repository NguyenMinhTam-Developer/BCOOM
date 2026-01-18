import '../../../../core/utils/json_mapper_utils.dart';
import '../../domain/entities/landing_page_entity.dart';
import 'position_model.dart';

class LandingPageModel extends LandingPageEntity {
  const LandingPageModel({
    required super.positions,
  });

  factory LandingPageModel.fromJson(Map<String, dynamic> json) {
    final positionsJson = JsonMapperUtils.safeParseMap(json['positions']);
    final Map<String, PositionModel> positions = (positionsJson.entries)
        .map(
      (entry) => MapEntry(
        entry.key,
        PositionModel.fromJson(
          JsonMapperUtils.safeParseMap(entry.value),
        ),
      ),
    )
        .fold<Map<String, PositionModel>>(
      {},
      (map, entry) => map..[entry.key] = entry.value,
    );

    return LandingPageModel(positions: positions);
  }
}
