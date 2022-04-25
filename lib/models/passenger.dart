import 'package:collabcar/models/service.dart';
import 'package:collabcar/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'passenger.g.dart';

@JsonSerializable(explicitToJson: true)
class Passenger {
  final Service service;
  final User user;
  final bool isAccepted;

  Passenger({
    required this.service,
    required this.user,
    required this.isAccepted,
  });

  factory Passenger.fromJson(Map<String, dynamic> json) =>
      _$PassengerFromJson(json);

  Map<String, dynamic> toJson() => _$PassengerToJson(this);
}
