import 'package:collabcar/models/service.dart';
import 'package:collabcar/models/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'service_application.g.dart';

@JsonSerializable(explicitToJson: true)
class ServiceApplication {
  Service service;
  User creatorUser;
  bool isAccepted;

  ServiceApplication({
    required this.service,
    required this.isAccepted,
    required this.creatorUser,
  });

  factory ServiceApplication.fromJson(Map<String, dynamic> json) =>
      _$ServiceApplicationFromJson(json);

  Map<String, dynamic> toJson() => _$ServiceApplicationToJson(this);
}
