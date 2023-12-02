import 'package:hive/hive.dart';

part 'plant.g.dart';

@HiveType(typeId: 0)
class Plant extends HiveObject {
  
  @HiveField(0)
  String name;

  @HiveField(1)
  String type;

  @HiveField(2)
  String description;

  @HiveField(3)
  int count;

  @HiveField(4)
  DateTime plantedDate;

  @HiveField(5)
  DateTime expectedDate;
  
  @HiveField(6)
  double progress;

  @HiveField(7)
  int wateringFrequencyInHours;

  @HiveField(8)
  String sunlightRequirements;

  @HiveField(9)
  List<bool>? weeklyWatering;

  Plant({
    required this.name,
    required this.type,
    required this.description,
    required this.count,
    required this.plantedDate,
    required this.expectedDate,
    required this.progress,
    required this.wateringFrequencyInHours,
    required this.sunlightRequirements,
    required this.weeklyWatering,
  });

  Duration get wateringFrequency => Duration(hours: wateringFrequencyInHours);
}
