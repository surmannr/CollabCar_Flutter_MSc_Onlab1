import 'package:collabcar/models/search.dart';

import 'package:json_annotation/json_annotation.dart';

part 'histories.g.dart';

@JsonSerializable()
class Histories {
  final List<Search> searches;

  Histories({
    required this.searches,
  });

  factory Histories.fromJson(Map<String, dynamic> json) =>
      _$HistoriesFromJson(json);

  Map<String, dynamic> toJson() => _$HistoriesToJson(this);
}
