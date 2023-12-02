import 'package:green_sync/main.dart';
import 'package:green_sync/models/plant.dart';
import 'package:green_sync/services/notification_services.dart';
import 'package:green_sync/services/weather.dart';
import 'package:hive_flutter/adapters.dart';

class WateringServices {
  static void waterPlant(int index)  {
    final plantsBox = Hive.box<Plant>("plantsBox");

    if (index >= 0 && index < plantsBox.length) {
      Plant? plant = plantsBox.getAt(index);

      if (plant!.weeklyWatering![weekday - 1]) {
        return;
      }

      plant.weeklyWatering![weekday - 1] = true; // Mark the plant as watered
      plant.wateringFrequencyInHours = 48;

      plantsBox.putAt(index, plant);
      refreshWaterTime(index);
    }
  }

  static void waterPlantsInRain() {
    final plantsBox = Hive.box<Plant>("plantsBox");

    for (int i = 0; i < plantsBox.length; i++) {
      Plant? plant = plantsBox.getAt(i);

      plant?.weeklyWatering![weekday - 1] = true;

      plantsBox.putAt(i, plant!);
      refreshWaterTime(i);
    }

    if (!Weather.isRainingNotificationSent) {
      NotificationService().showNotification(
          title: "Hey gardener,",
          body: "all the plants were watered because it was raining!");

      Weather.isRainingNotificationSent = true;
    }
  }

  static void reduceWateringTime() {
    final plantsBox = Hive.box<Plant>("plantsBox");

    for (Plant plant in plantsBox.values) {
      plant.wateringFrequencyInHours -= 1;
    }

    // Save the updated plants back to the box
    for (Plant updatedPlant in plantsBox.values) {
      plantsBox.put(updatedPlant.key, updatedPlant);
    }

    checkWateringTimes();
  }

  static void checkWateringTimes() {
    final plantsBox = Hive.box<Plant>("plantsBox");

    for (Plant plant in plantsBox.values) {
      if (plant.wateringFrequencyInHours <= 0) {
        NotificationService().showNotification(
            title: "Hey gardener,", body: "you have plants to water!");

        return;
      }
    }
  }

  static void refreshWaterTime(int index)  {
    final plantsBox = Hive.box<Plant>("plantsBox");

    if (index >= 0 && index < plantsBox.length) {
      Plant? plant = plantsBox.getAt(index);
      plant?.wateringFrequencyInHours = 48;

      plantsBox.putAt(index, plant!);
    }
  }
}
