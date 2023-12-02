import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_sync/models/plant.dart';
import 'package:green_sync/models/user.dart';
import 'package:green_sync/screens/add_plant_screen.dart';
import 'package:green_sync/screens/home_screen.dart';
import 'package:green_sync/screens/my_garden_screen.dart';
import 'package:green_sync/services/screen_size.dart';
import 'package:green_sync/services/notification_services.dart';
import 'package:green_sync/services/user_services.dart';
import 'package:green_sync/services/watering_services.dart';
import 'package:green_sync/services/weather.dart';
import 'package:green_sync/widgets/navigation_widget.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:timezone/data/latest.dart' as tz;

late dynamic usersBox;
late dynamic plantsBox;
int weekday = 1;
int hours = 1;

  void main() async {
    WidgetsFlutterBinding.ensureInitialized(); // Ensure the Flutter framework is properly initialized
  NotificationService().initNotification(); // Initialize Notifications Service
  tz.initializeTimeZones(); // Initialize TimeZones
  await Hive.initFlutter(); // Initialize HIVE database

  Hive.registerAdapter(PlantAdapter());
  Hive.registerAdapter(UserAdapter());

  plantsBox = await Hive.openBox<Plant>("plantsBox");
  usersBox = await Hive.openBox<User>("usersBox");

  await Weather.getWeather(UserServices.getArea());

  runApp(const MyApp());
}

List<Widget> screens = const [Home(), MyGarden()];

bool addScreen = false;
int currentIndex = 0;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Timer weatherUpdateTimer;

  @override
  void initState() {
    super.initState();
    _initWeatherUpdateTimer();
  }

  void _initWeatherUpdateTimer() {

    // Start timer for updating the weather every hour
    weatherUpdateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      Weather.getWeather(UserServices.getArea());
      WateringServices.reduceWateringTime();
      
      if(hours != 24)
        {
          hours++;
        }
        else
        {
          hours = 1;
        }
      if (kDebugMode) {
        print(hours);
      }

      if (hours % 24 == 0) {
        if (kDebugMode) {
          print("New Day!\n");
        }
        
        Weather.isRainingNotificationSent = false;

        if(weekday != 7)
        {
          weekday++;
        }
        else
        {
          weekday = 1;
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenSize.init(context); // Initialize screen size

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.green[50],
          body: addScreen
              ? AddPlantScreen(
                  onPressed: (isPressed) {
                    setState(() {
                      addScreen = isPressed;
                    });
                  },
                )
              : screens[currentIndex],
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: addScreen
              ? null
              : FloatingActionButton(
                  hoverColor: Colors.green[700],
                  backgroundColor: Colors.green[900],
                  child: const Icon(Icons.add),
                  onPressed: () {
                    setState(() {
                      addScreen = !addScreen;
                    });
                  },
                ),
          bottomNavigationBar: addScreen
              ? null
              : Navigation(
                  currentIndex: currentIndex,
                  onIndexChanged: (index) {
                    setState(() {
                      currentIndex = index;
                    });
                  },
                ),
        ),
      ),
    );
  }
}
