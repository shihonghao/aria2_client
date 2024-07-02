enum DataUnit {
  B("b"),
  KB("kb"),
  MB("mb"),
  GB("gb");

  final String name;

  const DataUnit(this.name);

  static DataUnit fromName(String name) {
    for (var value in DataUnit.values) {
      if (value.name == name) {
        return value;
      }
    }
    return DataUnit.B;
  }
}

class Util {
  static Pair<double, String> formatBytes(int? bytes) {
    if (bytes == null) {
      return Pair(0.0, "b");
    }
    double first = 0;
    String second = "b";
    if (bytes >= 1024 && bytes < 1024 * 1024) {
      first = double.parse((bytes.toDouble() / 1024).toStringAsFixed(2));
      second = "kb";
    } else if (bytes >= 1024 * 1024 && bytes < 1024 * 1024 * 1024) {
      first = double.parse((bytes.toDouble() / 1024 / 1024).toStringAsFixed(2));
      second = "mb";
    } else if (bytes >= 1024 * 1024 * 1024) {
      first = double.parse(
          (bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2));
      second = "gb";
    }
    return Pair(first, second);
  }

  static Pair<double, String> formatBytesWithUnit(int? bytes, DataUnit unit) {
    if (bytes == null) {
      return Pair(0.0, unit.name);
    }
    double value = 0;

    switch (unit) {
      case DataUnit.B:
        value = bytes.toDouble();
      case DataUnit.KB:
        value = double.parse((bytes.toDouble() / 1024).toStringAsFixed(2));
      case DataUnit.MB:
        value = double.parse((bytes.toDouble() / 1024 / 1024).toStringAsFixed(2));
      case DataUnit.GB:
        value = double.parse(
            (bytes.toDouble() / 1024 / 1024 / 1024).toStringAsFixed(2));
    }

    return Pair(value, unit.name);
  }
}

class Pair<T1, T2> {
  T1? first;
  T2? second;

  Pair(this.first, this.second);
}
