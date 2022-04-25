import 'package:json_annotation/json_annotation.dart';

part 'place.g.dart';

@JsonSerializable(explicitToJson: true)
class Place {
  late double latitude;
  late double longitude;
  late String address;

  Place({
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  Map<String, dynamic> toJson() => _$PlaceToJson(this);
}
