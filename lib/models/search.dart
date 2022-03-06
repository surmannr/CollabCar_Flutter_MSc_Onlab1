import 'package:collabcar/models/place.dart';

class Search {
  Place? placeFrom;
  Place? placeTo;
  DateTime date = DateTime.now();
  int? minSeatingCapacity;
  int? maxPrice;
  String? driverName;
  bool? canTransportPets;
  bool? canTransportBicycle;
  bool? isGoingHighway;

  Search({
    this.placeFrom,
    this.placeTo,
    required this.date,
    this.minSeatingCapacity,
    this.maxPrice,
    this.driverName,
    this.canTransportPets,
    this.canTransportBicycle,
    this.isGoingHighway,
  });

  static Map<String, dynamic> toJson(Search value) => {
        'placeFrom':
            value.placeFrom != null ? Place.toJson(value.placeFrom!) : null,
        'placeTo': value.placeTo != null ? Place.toJson(value.placeTo!) : null,
        'date': value.date.toString(),
        'minSeatingCapacity': value.minSeatingCapacity,
        'maxPrice': value.maxPrice,
        'driverName': value.driverName,
        'canTransportPets': value.canTransportPets,
        'canTransportBicycle': value.canTransportBicycle,
        'isGoingHighway': value.isGoingHighway,
      };
}
