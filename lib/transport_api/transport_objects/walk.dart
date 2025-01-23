import 'package:json_annotation/json_annotation.dart';

import 'json_converters/duration_in_seconds_converter.dart';

part 'walk.g.dart';

@JsonSerializable()
class Walk {
  /// walking duration
  @DurationInSecondsConverter()
  Duration? duration;

  Walk({required this.duration});

  factory Walk.fromJson(Map<String, dynamic> map) => _$WalkFromJson(map);

  Map<String, dynamic> toJson() => _$WalkToJson(this);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Walk && other.duration == duration;
  }

  @override
  int get hashCode => Object.hashAll([duration]);
}
