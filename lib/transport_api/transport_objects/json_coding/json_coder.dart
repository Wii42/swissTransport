abstract class JsonCoder<T extends Object> {
  T fromJson(Map<String, dynamic> map);

  T? maybeFromJson(Map<String, dynamic>? map) {
    if (map == null) {
      return null;
    }
    return fromJson(map);
  }

  List<T> multipleFromJson(List<dynamic> list) {
    return [for (Map<String, dynamic> map in list) fromJson(map)];
  }

  List<T>? maybeMultipleFromJson(List<dynamic>? list) {
    if (list == null) {
      return null;
    }
    return multipleFromJson(list);
  }

  Map<String, dynamic> asJson(T object);

  List<Map<String, dynamic>> multipleAsJson(List<T> list) {
    return [for (T object in list) asJson(object)];
  }

  List<Map<String, dynamic>>? maybeMultipleAsJson(List<T>? list) {
    if (list == null) {
      return null;
    }
    return [for (T object in list) asJson(object)];
  }
}
