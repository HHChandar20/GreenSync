import 'dart:async';

import 'package:flutter/material.dart';
import 'package:green_sync/models/plant.dart';
import 'package:green_sync/screens/plant_details_screen.dart';
import 'package:green_sync/services/plant_services.dart';
import 'package:green_sync/services/user_services.dart';
import 'package:green_sync/services/weather.dart';
import 'package:green_sync/widgets/garden_element_widget.dart';
import 'package:hive_flutter/adapters.dart';

List<Plant> plants = [];

class MyGarden extends StatefulWidget {
  const MyGarden({Key? key}) : super(key: key);

  @override
  State<MyGarden> createState() => _MyGardenState();
}

class _MyGardenState extends State<MyGarden> {
  bool isLoading = true;
  late Timer _timer;

  @override
  void initState() {
    _loadData();
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      PlantServices.updatePlantsProgress();
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final plantsBox = await Hive.openBox<Plant>('plantsBox');

    setState(() {
      plants = plantsBox.values.toList();
      isLoading = false;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 30.0),
          child: Text(
            'My Garden',
            style: TextStyle(
              fontSize: 28.0,
              fontFamily: 'Quicksand',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: FutureBuilder(
              future: Weather.getWeather(UserServices.getArea()),
              builder: (context, snapshot) {
                return LayoutBuilder(
                  builder: (context, constraints) {
                    final crossAxisCount = constraints.maxWidth > 600 ? 4 : 2;

                    return GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        crossAxisSpacing: 0.0,
                        mainAxisSpacing: 8.0,
                      ),
                      itemCount: plants.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onDoubleTap: () {
                            bool deletionResult =
                                PlantServices.deletePlant(index);
                            setState(() {
                              _loadData();
                              _showDeleteSnackBar(deletionResult);
                            });
                          },
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => PlantInfoScreen(
                                  index: index,
                                ),
                              ),
                            );
                          },
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: GardenElement(
                              plantImagePath:
                                  "lib/assets/images/${plants[index].type.toLowerCase()}.png",
                              count: plants[index].count,
                              humidity: plants[index]
                                  .wateringFrequencyInHours
                                  .toString(),
                              growth: plants[index].progress.toStringAsFixed(0),
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              }),
        ),
      ],
    );
  }

  void _showDeleteSnackBar(bool success) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(milliseconds: 100),
        content: Text(success ? 'The plant was deleted' : 'Deletion failed',
            style: const TextStyle(fontFamily: 'Quicksand')),
      ),
    );
  }
}
