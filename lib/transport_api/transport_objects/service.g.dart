// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Service _$ServiceFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    allowedKeys: const ['regular', 'irregular'],
  );
  return Service(
    regular: json['regular'] as String?,
    irregular: json['irregular'] as String?,
  );
}

Map<String, dynamic> _$ServiceToJson(Service instance) => <String, dynamic>{
      'regular': instance.regular,
      'irregular': instance.irregular,
    };
