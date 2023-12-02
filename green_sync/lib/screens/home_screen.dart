import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:green_sync/models/tutorial.dart';
import 'package:green_sync/screens/add_plant_screen.dart';
import 'package:green_sync/screens/tutorial_screen.dart';
import 'package:green_sync/services/screen_size.dart';
import 'package:green_sync/services/user_services.dart';
import 'package:green_sync/services/weather.dart';
import 'package:intl/intl.dart';

List<List<String>> titles = [
  ["What is a tomato?", "General Info", "How to plant?"],
  ["What is a potato?", "General Info", "How to plant?"],
  ["What is a rose?", "General Info", "How to propagate?"]
];

List<List<String>> descriptions = [
  [
    "Botanically speaking, a tomato is a fruit. It develops from the ovary of a flower and contains seeds, which are characteristics of fruits. However, in culinary terms, tomatoes are often considered vegetables due to their savory taste and common use in savory dishes.",
    "Loamy soil\n\nWater it once or twice a week\n\nSpring and Summer\n\nGrowth Period - 60-85 days",
    "Tomato Title 3"
  ],
  [
    "Potatoes are starchy, underground tubers that belong to the Solanaceae family, which also includes tomatoes, eggplants, and peppers. They are one of the world's most widely consumed vegetables and a staple food in many cuisines.",
    "Loamy/Sandy soil\n\nWater it once or twice a week\n\nEarly Spring\n\nGrowth Period - 70-120 days",
    "Potato Title 3"
  ],
  [
    "Roses are woody perennial flowering plants belonging to the genus Rosa in the family Rosaceae. They are known for their beautiful, fragrant flowers and are one of the most beloved and widely cultivated ornamental plants globally.",
    "Loamy soil\n\nWater it once or twice a week\n\nSpring and Summer\n\nGrowth Period - 30-45 days",
    "Rose Title 3"
  ]
];

List<List<String>> videoPaths = [
  ["Tomato Video 1", "Tomato Video 2", "https://www.youtube.com/shorts/fgex8AkYy_g"],
  ["Potato Video 1", "Potato Video 2", "https://www.youtube.com/shorts/P24KxiKELjY"],
  ["Rose Video 1", "Rose Video 2", "https://www.youtube.com/shorts/GtTQZ5Iy0Aw"]
];

List<Tutorial> tutorials = [
  Tutorial(
      titles: titles[0],
      descriptions: descriptions[0],
      videoPaths: videoPaths[0]),
  Tutorial(
      titles: titles[1],
      descriptions: descriptions[1],
      videoPaths: videoPaths[1]),
  Tutorial(
      titles: titles[2],
      descriptions: descriptions[2],
      videoPaths: videoPaths[2])
];

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _cityInputController = TextEditingController();
  String weatherStatus = Weather.weatherStatus;
  String temperature = Weather.temperature.toStringAsFixed(0);

  @override
  void initState() {
    super.initState();
    Weather.getWeather(UserServices.getArea());
    _cityInputController.text = UserServices.getArea();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    Orientation orientation = MediaQuery.of(context).orientation;
    String formattedDate = DateFormat('MMMM d, y').format(DateTime.now());

    bool isLandscape = orientation.name == "landscape";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          height: deviceHeight / 3,
          width: ScreenSize.screenWidth,
          decoration: BoxDecoration(color: Colors.green[700]),
          child: isLandscape ? 
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth * 0.14, right: 10),
                              child: const Icon(Icons.home, color: Colors.white)),
                          Expanded(
                            child: TextField(
                              controller: _cityInputController,
                              onSubmitted: (value) {
                                setState(() {
                                  UserServices.setArea(value);
                                  Weather.getWeather(value);
                                  weatherStatus = Weather.weatherStatus;
                                  temperature = Weather.temperature.toStringAsFixed(0);
                                });
                              },
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Quicksand'
                              ),
                              decoration: InputDecoration(
                                hintText: "Your Area",
                                hintStyle: TextStyle(
                                  color: Colors.white.withOpacity(0.5),
                                  fontSize: 20,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        "$weatherStatus   $temperature°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Quicksand'
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: Text(
                          "Green Sync.",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 35,
                            fontFamily: 'Ethnocentric',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          )
          : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  formattedDate,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Quicksand'
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Green Sync.",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Ethnocentric',
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: TextField(
                          controller: _cityInputController,
                          onSubmitted: (value) async {
                              UserServices.setArea(value);
                              await Weather.getWeather(value);
                            setState(() {
                              weatherStatus = Weather.weatherStatus;
                              temperature =
                                  Weather.temperature.toStringAsFixed(0);
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Quicksand'
                          ),
                          decoration: InputDecoration(
                            hintText: "Your Area",
                            icon: const Icon(Icons.house, color: Colors.white),
                            hintStyle: TextStyle(
                              color: Colors.white.withOpacity(0.5),
                              fontSize: 20,
                              fontFamily: 'Quicksand'
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Text(
                        "$weatherStatus   $temperature°",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Quicksand',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: plantTypes.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  width: (orientation == Orientation.landscape)
                      ? deviceWidth * 0.4
                      : deviceWidth * 0.8,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GardeningTutorialScreen(
                              titles: tutorials[index].titles,
                              tutorials: tutorials[index].descriptions,
                              videoPaths: tutorials[index].videoPaths,
                            ),
                          ),
                        );
                      },
                      child: Card(
                        elevation: 7,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Text(
                                plantTypes[index].name,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 21,
                                  fontFamily: 'Quicksand'
                                ),
                              ),
                            ),
                            Expanded(
                              child: SvgPicture.asset(
                                'lib/assets/images/${plantTypes[index].name.toLowerCase()}_tutorial.svg',
                                semanticsLabel: 'Gardening SVG',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
