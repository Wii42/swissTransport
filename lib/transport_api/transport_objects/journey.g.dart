// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'journey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Journey _$JourneyFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const [
      'name',
      'category',
      'subcategory',
      'categoryCode',
      'number',
      'operator',
      'to',
      'passList',
      'capacity1st',
      'capacity2nd',
      'stop'
    ],
  );
  return Journey(
    name: json['name'] as String?,
    category: json['category'] as String?,
    subcategory: json['subcategory'] as String?,
    categoryCode: (json['categoryCode'] as num?)?.toInt(),
    number: json['number'] as String?,
    operator: json['operator'] as String?,
    to: json['to'] as String?,
    passList: (json['passList'] as List<dynamic>?)
        ?.map((e) => Stop.fromJson(e as Map<String, dynamic>))
        .toList(),
    capacity1st: (json['capacity1st'] as num?)?.toInt(),
    capacity2nd: (json['capacity2nd'] as num?)?.toInt(),
    stop: json['stop'] == null
        ? null
        : Stop.fromJson(json['stop'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$JourneyToJson(Journey instance) => <String, dynamic>{
      'name': instance.name,
      'category': instance.category,
      'subcategory': instance.subcategory,
      'categoryCode': instance.categoryCode,
      'number': instance.number,
      'operator': instance.operator,
      'to': instance.to,
      'passList': instance.passList?.map((e) => e.toJson()).toList(),
      'capacity1st': instance.capacity1st,
      'capacity2nd': instance.capacity2nd,
      'stop': instance.stop?.toJson(),
    };
