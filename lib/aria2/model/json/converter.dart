import 'package:json_annotation/json_annotation.dart';

class StringToIntegerConverter extends JsonConverter<int, String> {
  const StringToIntegerConverter();

  @override
  int fromJson(String json) {
    if(json == "" ){
      json = "0";
    }
    return int.parse(json);
  }

  @override
  String toJson(int object) {
    return object.toString();
  }
}

class StringToDoubleConverter extends JsonConverter<double, String> {
  const StringToDoubleConverter();

  @override
  double fromJson(String json) {
    if(json == "" ){
      json = "0.0";
    }
    return double.parse(json);
  }

  @override
  String toJson(double object) {
    return object.toString();
  }
}

class StringToBoolConverter extends JsonConverter<bool, String> {
  const StringToBoolConverter();

  @override
  bool fromJson(String json) {
    if(json == "" ){
      json = "false";
    }
    return json == "true";
  }

  @override
  String toJson(bool object) {
    return object.toString();
  }
}
