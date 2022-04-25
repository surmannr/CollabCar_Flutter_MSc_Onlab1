// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'histories.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Histories _$HistoriesFromJson(Map<String, dynamic> json) => Histories(
      searches: (json['searches'] as List<dynamic>)
          .map((e) => Search.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$HistoriesToJson(Histories instance) => <String, dynamic>{
      'searches': instance.searches.map((e) => e.toJson()).toList(),
    };
