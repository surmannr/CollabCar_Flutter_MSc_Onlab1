import 'package:json_annotation/json_annotation.dart';

part 'passenger.g.dart';

@JsonSerializable()
class Passenger {
  final int serviceId;
  final int userId;
  final bool isAccepted;

  Passenger({
    required this.serviceId,
    required this.userId,
    required this.isAccepted,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);
}
