import 'dart:io';

import 'package:csv/csv.dart';

class DataPoint {
  final DateTime date;
  final double value;

  const DataPoint({
    required this.date,
    required this.value,
  });
}

List<DataPoint> getDataPoints() {
  final data = File('./time_series-AAPL-1h.csv').readAsStringSync();
  final lines = const CsvToListConverter().convert(data);

  final points = <DataPoint>[];
  for (final line in lines) {
    points.add(DataPoint(
      date: DateTime.parse(line[0]),
      value: double.parse(line[2]),
    ));
  }

  return points;
}
