import 'package:collabcar/models/search.dart';

class Histories {
  final List<Search> searches;

  Histories({
    required this.searches,
  });

  factory Histories.fromJson(Map<String, dynamic> parsedJson) {
    List<Search> histories = [];
    histories = (parsedJson['searches'] as List<dynamic>)
        .map((e) => Search.fromJson(e))
        .toList();

    return Histories(searches: histories);
  }

  Map<String, dynamic> toJson() {
    return {
      "searches": searches.map((e) => Search.toJson(e)).toList(),
    };
  }
}
