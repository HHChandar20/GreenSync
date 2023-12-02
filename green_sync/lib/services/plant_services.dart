import 'package:hive/hive.dart';
import 'package:green_sync/models/plant.dart';

class PlantServices {
  static List<Plant> plantsList = [];

  static void addPlant(Plant plant, int count, int plantIndex) {
    final plantsBox = Hive.box<Plant>("plantsBox");

    final newPlant = Plant(
        name: plant.name,
        type: plant.type,
        description: plant.description,
        count: count,
        plantedDate: DateTime.now(),
        expectedDate: DateTime.now().add(Duration( minutes: (plantIndex == 0 ? 5 : plantIndex == 1 ? 2 : 3))),
        progress: plant.progress,
        wateringFrequencyInHours: plant.wateringFrequencyInHours,
        sunlightRequirements: plant.sunlightRequirements,
        weeklyWatering: List<bool>.filled(7, false));

    plantsBox.add(newPlant);
  }

  static bool deletePlant(int index) {
    final plantsBox = Hive.box<Plant>("plantsBox");

    if (index >= 0 && index < plantsBox.length) {
      plantsBox.deleteAt(index);
      return true; // Deletion successful
    }

    return false; // Deletion unsuccessful
  }

  static void updatePlantsProgress() {
  final plantsBox = Hive.box<Plant>("plantsBox");

  final now = DateTime.now();

  for (int i = 0; i < plantsBox.length; i++)
  {
    Plant? plant = plantsBox.getAt(i);

    if (plant!.progress >= 100)
    {
      plant.progress = 100;
    }
    else
    {
      int timeDifferenceinMinutes = now.difference(plant.plantedDate).inMinutes;
      int totalTimeinMinutes = plant.expectedDate.difference(plant.plantedDate).inMinutes;

      double progress = (timeDifferenceinMinutes / totalTimeinMinutes) * 100;

      // Ensure progress doesn't exceed 100
      plant.progress = progress.clamp(0, 100).toDouble();
    }

    plantsBox.putAt(i, plant);
  }
}

}
