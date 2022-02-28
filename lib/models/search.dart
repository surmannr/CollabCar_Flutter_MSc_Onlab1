import 'package:collabcar/models/place.dart';

class Search {
  Place? placeFrom;
  Place? placeTo;
  DateTime? date;
  int? minSeatingCapacity;
  int? maxPrice;
  String? driverName;
  bool? canTransportPets;
  bool? canTransportBicycle;
  bool? isGoingHighway;

  Search({
    this.placeFrom,
    this.placeTo,
    this.date,
    this.minSeatingCapacity,
    this.maxPrice,
    this.driverName,
    this.canTransportPets,
    this.canTransportBicycle,
    this.isGoingHighway,
  });
}
