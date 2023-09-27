import 'dart:math';

import 'package:bam_dojo/calendar_drag%20copy/team_1.dart';
import 'package:bam_dojo/helpers/team_class.dart';
import 'package:collection/collection.dart';

import 'package:flutter/material.dart';

import 'data/data_point.dart';
import 'package:fl_chart/fl_chart.dart';

final monthNames = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec'
};

List<FlSpot> aggregateByMonth(List<DataPoint> dataPoints) {
  final aggregatedData = dataPoints.fold<Map<int, List<double>>>({},
      (Map<int, List<double>> acc, DataPoint current) {
    final int key = current.date.month;

    acc[key] = (acc[key] ?? []) + [current.value];

    return acc;
  });

  final List<FlSpot> aggregatedList = aggregatedData.entries.map((entry) {
    int l = entry.value.length;
    return FlSpot(
        entry.key.toDouble(), entry.value.reduce((a, b) => a + b) / l);
  }).toList();

  return aggregatedList;
}

class GradientGraphTeam2 extends StatefulWidget with TeamMixin {
  final teamName = 'Team2';
  final List<DataPoint> dataPoints = getDataPoints();

  @override
  State<GradientGraphTeam2> createState() => _GradientGraphTeam2State();
}

class _GradientGraphTeam2State extends State<GradientGraphTeam2>
    with TickerProviderStateMixin {
  late List<FlSpot> dataPoints;
  int touchedIndex = 0;

  late final _controller = AnimationController(
    duration: const Duration(milliseconds: 600),
    vsync: this,
  );
  late final _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.linear,
  );
  late double maxY;

  @override
  void initState() {
    super.initState();
    final basePoints = getDataPoints();
    setState(() {
      dataPoints = aggregateByMonth(basePoints);
      maxY = dataPoints.map((e) => e.y).toList().reduce(max);
      _controller.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 300,
                width: 350,
                child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, _) {
                      final lineChartBarData = LineChartBarData(
                          showingIndicators: [touchedIndex],
                          spots: dataPoints
                              .map((entry) => FlSpot(
                                  entry.x,
                                  entry.y * _animation.value +
                                      (1 - _animation.value) * 100))
                              .toList(),
                          isCurved: true,
                          isStrokeCapRound: true,
                          barWidth: 5,
                          dotData: const FlDotData(
                            show: false,
                          ),
                          belowBarData: BarAreaData(
                              show: true,
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepOrange[100]!,
                                  Colors.white,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              )),
                          gradient: LinearGradient(
                            colors: [
                              Colors.deepOrange[200]!,
                              Colors.deepOrange[300]!,
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ));

                      return LineChart(LineChartData(
                        minY: 100,
                        maxY: maxY,
                        lineTouchData: LineTouchData(
                          enabled: false,
                          handleBuiltInTouches: false,
                          getTouchedSpotIndicator: (LineChartBarData barData,
                              List<int> spotIndexes) {
                            return spotIndexes.map((index) {
                              return TouchedSpotIndicatorData(
                                const FlLine(
                                    color: Colors.grey, dashArray: [7, 3]),
                                FlDotData(
                                  show: true,
                                  getDotPainter:
                                      (spot, percent, barData, index) =>
                                          FlDotCirclePainter(
                                    radius: 8,
                                    strokeWidth: 7,
                                    strokeColor: Colors.white,
                                    color: Colors.deepOrange[300]!,
                                  ),
                                ),
                              );
                            }).toList();
                          },
                        ),
                        lineBarsData: [lineChartBarData],
                        gridData: FlGridData(
                          show: false,
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        titlesData: FlTitlesData(
                            show: true,
                            topTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            leftTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            rightTitles: const AxisTitles(
                                sideTitles: SideTitles(showTitles: false)),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                reservedSize: 30,
                                interval: 1,
                                getTitlesWidget: ((value, meta) =>
                                    bottomTitleWidgets(
                                      value: value,
                                      meta: meta,
                                      changeIndex: () => setState(() {
                                        touchedIndex = value.toInt() - 3;
                                      }),
                                      isFocused:
                                          value.toInt() == touchedIndex + 3,
                                    )),
                              ),
                            )),
                      ));
                    })),
          ],
        )),
      ),
    );
  }
}

class bottomTitleWidgets extends StatelessWidget {
  const bottomTitleWidgets(
      {Key? key,
      required this.value,
      required this.meta,
      required this.changeIndex,
      required this.isFocused})
      : super(key: key);
  final double value;
  final TitleMeta meta;
  final void Function() changeIndex;
  final bool isFocused;

  @override
  Widget build(BuildContext context) {
    return SideTitleWidget(
        axisSide: meta.axisSide,
        child: Material(
          color: isFocused ? Colors.deepOrange[300] : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
          child: Padding(
            padding: const EdgeInsets.only(left: 6, right: 6),
            child: InkWell(
              borderRadius: BorderRadius.circular(10),
              onTap: changeIndex,
              child: Center(
                child: Text(
                  monthNames[value.toInt()]!,
                  style:
                      TextStyle(color: isFocused ? Colors.white : Colors.black),
                ),
              ),
            ),
          ),
        ));
  }
}
