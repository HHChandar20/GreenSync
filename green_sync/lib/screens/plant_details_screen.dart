import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:green_sync/models/plant.dart';
import 'package:green_sync/screens/my_garden_screen.dart';
import 'package:green_sync/services/watering_services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';

class PlantInfoScreen extends StatefulWidget {
  const PlantInfoScreen({Key? key, required this.index}) : super(key: key);
  final int index;

  @override
  State<PlantInfoScreen> createState() => _PlantInfoScreenState();
}

class _PlantInfoScreenState extends State<PlantInfoScreen> {
  late String createdDate;
  late Timer _timer;
  late Plant plant = plants[widget.index];

  @override
  void initState() {
    _loadData();
    super.initState();
    createdDate = DateFormat('d MMMM, y').format(plant.plantedDate);
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final plantsBox = await Hive.openBox<Plant>('plantsBox');

    setState(() {
      plant = plantsBox.getAt(widget.index)!;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green[50],
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.green),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                plant.name,
                                style: const TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontFamily: 'Quicksand'
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                createdDate,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.grey,
                                  fontFamily: 'Quicksand'
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 20),
                        Image.asset(
                          'lib/assets/images/${plant.type.toLowerCase()}.png',
                          width: MediaQuery.of(context).size.width * 0.3,
                          height: MediaQuery.of(context).size.width * 0.3,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 5,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildInfoRow(
                          Icons.water,
                          '${plant.wateringFrequencyInHours} hours to water',
                        ),
                        _buildInfoRow(
                          Icons.sunny,
                          plant.sunlightRequirements,
                        ),
                        _buildInfoRow(
                          Icons.timelapse,
                          'Spring, Summer',
                        ),
                        _buildInfoRow(
                          Icons.grass,
                          'Loamy soil',
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20, right: 30, left: 10, bottom: 50),
                          child: AspectRatio(
                            aspectRatio: 2,
                            child: LineChart(
                              LineChartData(
                                backgroundColor: Colors.white,
                                clipData: const FlClipData(
                                    left: true,
                                    right: true,
                                    bottom: true,
                                    top: true),
                                gridData:
                                    const FlGridData(drawVerticalLine: false),
                                titlesData: FlTitlesData(
                                  rightTitles: const AxisTitles(), // Hide left axis
                                  topTitles: const AxisTitles(), // Hide bottom axis
                                  bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                    showTitles: true,
                                    interval: 1,
                                    getTitlesWidget: (value, meta) {
                                      Widget text;

                                      switch (value.toInt()) {
                                        case 1:
                                          text = const Text("Mon");
                                          break;
                                        case 2:
                                          text = const Text("Tue");
                                          break;
                                        case 3:
                                          text = const Text("Wed");
                                          break;
                                        case 4:
                                          text = const Text("Thu");
                                          break;
                                        case 5:
                                          text = const Text("Fri");
                                          break;
                                        case 6:
                                          text = const Text("Sat");
                                          break;
                                        case 7:
                                          text = const Text("Sun");
                                          break;
                                        default:
                                          text = const Text("");
                                      }
                                      return SideTitleWidget(
                                        axisSide: meta.axisSide,
                                        space: 5,
                                        child: text,
                                      );
                                    },
                                  )),
                                  leftTitles: const AxisTitles(
                                      sideTitles: SideTitles(
                                          showTitles: true, interval: 1)),
                                ),
                                lineBarsData: [
                                  LineChartBarData(
                                    spots: plant.weeklyWatering!
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int index = entry.key + 1;
                                      bool value = entry.value;

                                      return FlSpot(
                                          index.toDouble(), value ? 1 : 0);
                                    }).toList(),
                                    isCurved: true,
                                    color: Colors.blue[200],
                                    shadow: const Shadow(color: Colors.black),
                                    barWidth: 6,
                                    preventCurveOverShooting: true,
                                    dotData: FlDotData(
                                      show: true,
                                      getDotPainter:
                                          (spot, percent, barData, index) {
                                        return FlDotCirclePainter(
                                          radius: 8,
                                          color: Colors
                                              .blueAccent, // Set the color of the data point
                                          strokeWidth: 2,
                                          strokeColor: Colors.white,
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              setState(() {
                                WateringServices.waterPlant(widget.index);
                              });
                            },
                            child: const Text("Water the plant", style: TextStyle(fontFamily: 'Quicksand')))
                      ],
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

  Widget _buildInfoRow(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(icon, size: 30, color: Colors.black),
          const SizedBox(width: 20),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 24, fontFamily: 'Quicksand'),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
