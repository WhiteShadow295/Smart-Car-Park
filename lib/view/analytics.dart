import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalyticsPage extends StatefulWidget {
  const AnalyticsPage({super.key});

  @override
  _AnalyticsPageState createState() => _AnalyticsPageState();
}

class _AnalyticsPageState extends State<AnalyticsPage> {
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('carpark_history');
  Map<int, double> _hourlyAverages = {};

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    DatabaseEvent event = await _database.once();
    Map<dynamic, dynamic> records =
        event.snapshot.value as Map<dynamic, dynamic>;
    Map<int, int> hourlyCounts = {};
    Map<int, int> hourlyTotals = {};

    records.forEach((key, value) {
      List<dynamic> checkInOutRecords = value['checkInOutRecords'];
      for (var record in checkInOutRecords) {
        if (record != null && record is Map) {
          DateTime checkInTime = DateTime.parse(record['checkInTime']);
          int hour = checkInTime.hour;

          if (hourlyCounts.containsKey(hour)) {
            hourlyCounts[hour] = hourlyCounts[hour]! + 1;
          } else {
            hourlyCounts[hour] = 1;
          }

          if (hourlyTotals.containsKey(hour)) {
            hourlyTotals[hour] = hourlyTotals[hour]! + 1;
          } else {
            hourlyTotals[hour] = 1;
          }
        }
      }
    });

    Map<int, double> hourlyAverages = {};
    hourlyCounts.forEach((hour, count) {
      hourlyAverages[hour] = count / records.length;
    });

    setState(() {
      _hourlyAverages = hourlyAverages;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Find the maximum value in the data
    double maxValue = _hourlyAverages.values.reduce((a, b) => a > b ? a : b);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: _hourlyAverages.isEmpty
              ? const CircularProgressIndicator()
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Peak Hours',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: BarChart(
                            BarChartData(
                              alignment: BarChartAlignment.spaceAround,
                              barTouchData: BarTouchData(
                                touchTooltipData: BarTouchTooltipData(
                                  tooltipPadding: const EdgeInsets.all(8),
                                  tooltipMargin: 8,
                                  getTooltipItem:
                                      (group, groupIndex, rod, rodIndex) {
                                    return BarTooltipItem(
                                      '${rod.toY.toStringAsFixed(1)}%',
                                      const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    );
                                  },
                                ),
                              ),
                              maxY: 4.0, // Set maxY to 4.0
                              barGroups: (_hourlyAverages.entries
                                  .toList()
                                    ..sort((a, b) => a.key.compareTo(b.key)))
                                  .map((entry) {
                                    return BarChartGroupData(
                                      x: entry.key,
                                      barRods: [
                                        BarChartRodData(
                                          toY: (entry.value / maxValue) * 4.0,
                                          color: Colors.blue,
                                          width: 16,
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                      ],
                                    );
                                  }).toList(),
                              titlesData: FlTitlesData(
                                leftTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: true),
                                ),
                                bottomTitles: AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget:
                                        (double value, TitleMeta meta) {
                                      return Text(value.toInt().toString());
                                    },
                                  ),
                                ),
                                topTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                                rightTitles: const AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                              ),
                              gridData: const FlGridData(
                                show: false,
                              ),
                              borderData: FlBorderData(
                                show: false,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
