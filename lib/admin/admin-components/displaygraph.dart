import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vendorapp/local_storage/secure_storage.dart';

class DashboardStatistics extends StatefulWidget {
  @override
  State<DashboardStatistics> createState() => _DashboardStatisticsState();
}

class _DashboardStatisticsState extends State<DashboardStatistics> {
  Map<dynamic, dynamic> data = {};
  bool recievedstats = false;
  void getStats() async {
    var secStore = SecureStorage();
    var token = await secStore.readSecureData('token');
    print("token on main page ${token}");
    final Options options = Options(
      headers: {
        "Authorization": "Bearer ${token}",
      },
    );
    Response<Map> response =
        await Dio().get("https://api.semer.dev/api/admin", options: options);
    print(response);
    if (response.data != null && response.data?['status'] == 'success') {
      print(response.data?['data'][0]);
      setState(() {
        data = response.data?['data'] as Map<String, dynamic>;

        recievedstats = true;
      });
    }
  }

  @override
  void initState() {
    getStats();
  }
  // final Map<String, dynamic> data = {
  //   "users": 9,
  //   "categories": 3,
  //   "subcategories": 2,
  //   "products": 34,
  //   "orders": 43,
  //   "transactionVolume": 28152,
  //   "successfulTransaction": 1
  // };

  @override
  Widget build(BuildContext context) {
    final List<BarChartGroupData> barGroups = data.entries.map((entry) {
      final int index = data.keys.toList().indexOf(entry.key);
      // final double y = entry.key == 'transactionVolume'
      //     ? double.parse(entry.value.toString()) / 1000
      //     : entry.value.toDouble();
      final double y;
      if (entry.key == 'transactionVolume') {
        y = double.parse(entry.value.toString()) / 1000;
      } else {
        y = double.tryParse(entry.value.toString()) ??
            0.0; // Safely parse to double
      }

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            y: y,
            colors: [Colors.teal],
            borderRadius: BorderRadius.circular(6),
          ),
        ],
        showingTooltipIndicators: [0],
      );
    }).toList();

    return recievedstats
        ? Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BarChart(
                  BarChartData(
                    maxY: 150,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.blueGrey,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(color: Colors.white),
                          );
                        },
                      ),
                      enabled: true,
                    ),
                    titlesData: FlTitlesData(
                      bottomTitles: SideTitles(
                        showTitles: true,
                        getTextStyles: (context, value) => const TextStyle(
                          fontSize: 12,
                          color: Colors.teal,
                        ),
                        margin: 16,
                        rotateAngle: 45,
                        getTitles: (double value) {
                          return data.keys.elementAt(value.toInt());
                        },
                      ),
                      leftTitles: SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(show: false),
                    barGroups: barGroups,
                    gridData: FlGridData(show: false),
                  ),
                ),
              ),
            ),
          )
        : Container(
            child: Center(
                child: CircularProgressIndicator(
            color: Colors.teal,
          )));
  }
}
