import 'package:flutter/material.dart';
import 'package:green_sync/models/plant.dart';
import 'package:green_sync/services/plant_services.dart';

class AddPlantScreen extends StatefulWidget {
  const AddPlantScreen({super.key, required this.onPressed});
  final Function(bool) onPressed;

  @override
  State<AddPlantScreen> createState() => _AddPlantScreenState();
}

int plantIndex = 0;
int count = 1;

List<Plant> plantTypes = [
  Plant(
      name: "Tomato",
      type: "Tomato",
      description:
          "Rich source of essential nutrients, including vitamins C and K, and contains beneficial antioxidants",
      count: 0,
      plantedDate: DateTime.now(),
      expectedDate: DateTime.now().add(const Duration(minutes: 5)),
      progress: 0,
      wateringFrequencyInHours: 44,
      sunlightRequirements: "Full Sun",
      
      weeklyWatering: List.filled(7, false)),
  Plant(
      name: "Potato",
      type: "Potato",
      description:
          "Rich source of carbohydrates, offering a wide range of nutrients like vitamin C, potassium, and fiber",
      count: 0,
      plantedDate: DateTime.now(),
      expectedDate: DateTime.now().add(const Duration(minutes: 2)),
      progress: 0,
      wateringFrequencyInHours: 48,
      sunlightRequirements: "Full Sun",
      weeklyWatering: List.filled(7, false)),
  Plant(
      name: "Rose",
      type: "Rose",
      description:
          "Classic flowering shrubs prized for their exquisite beauty and fragrance. Thrive in sunny locations, requiring well-drained soil. They symbolize love, beauty, and elegance.",
      count: 0,
      plantedDate: DateTime.now(),
      expectedDate: DateTime.now().add(const Duration(minutes: 3)),
      progress: 0,
      wateringFrequencyInHours: 24,
      sunlightRequirements: "Full Sun",
      weeklyWatering: List.filled(7, false))
];

class _AddPlantScreenState extends State<AddPlantScreen> {
  @override
  void dispose() {
    super.dispose();
    plantIndex = 0;
    count = 1;
  }

  @override
Widget build(BuildContext context) {
  final screenWidth = MediaQuery.of(context).size.width;

  bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
  bool isOrientationLandscape = isLandscape(context);


  return Scaffold(
    body: SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.04), // Responsive padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  alignment: Alignment.center,
                  icon: const Icon(Icons.arrow_back, color: Colors.green, size: 32),
                  onPressed: () {
                    setState(() {
                      widget.onPressed(false);
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 20.0),
                  child: Text(
                    plantTypes[plantIndex].name,
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Quicksand',
                      fontSize: isOrientationLandscape ? screenWidth * 0.05 : screenWidth * 0.09, // Responsive font size
                    ),
                  ),
                ),
              ],
            ),
          ),

          //Landscape

          isOrientationLandscape ? Expanded(
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Images Column
                  Expanded(
                    child: Stack(
                      alignment: Alignment.bottomCenter,
                      children: [
                        Image.asset("lib/assets/images/soil.png", scale: 0.5),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Image.asset(
                            "lib/assets/images/plant_background.png",
                            scale: 0.75,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: screenWidth * 0.03, // Responsive bottom padding
                          ),
                          child: PageView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: plantTypes.length,
                            onPageChanged: (int index) {
                              setState(() {
                                plantIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return Transform.scale(
                              scale: 0.9,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 0),
                                child: Image.asset(
                                  "lib/assets/images/${plantTypes[index].name.toLowerCase()}.png",
                                )
                              ),
                            );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Plant Description Column
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(
                        screenWidth * 0.04, 0, screenWidth * 0.03, screenWidth * 0.01 // Responsive horizontal padding
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0), // Adjust the radius for the rounded edges
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        padding: const EdgeInsets.all(15.0), // Adjust the padding within the container
                        child: Text(
                          plantTypes[plantIndex].description,
                          maxLines: isOrientationLandscape ? 20 : 3,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontSize: isOrientationLandscape
                                ? screenWidth * 0.024
                                : screenWidth * 0.04, // Responsive font size
                          ),
                        ),
                      ),
                      ),
                    ),
                  ),
                  SizedBox(height: screenWidth * 0.02),
                  Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          screenWidth * 0.02, // Responsive padding
                          isOrientationLandscape ? 0 : screenWidth * 0.08, // Responsive padding
                          screenWidth * 0.03, // Responsive padding
                          isOrientationLandscape ? 125 : screenWidth * 0.08, // Responsive padding
                        ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Container(
                          width: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15, // Responsive width
                          height: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15, // Responsive height
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 135, 204, 164),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              setState(() {
                                if (count > 1) count--;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02), // Responsive spacing
                        Text(
                          count.toString(),
                          style: TextStyle(
                            fontFamily: 'Quicksand',
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: screenWidth * 0.07, // Responsive font size
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02), // Responsive spacing
                        Container(
                          width: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15,
                          height: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15,
                          decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 135, 204, 164),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                          ),
                        ),
                        ],
                        ),
                        Padding(
                      padding: EdgeInsets.only(bottom: screenWidth * 0.03), // Responsive padding
                      child: ElevatedButton(
                        style: ButtonStyle(
                          elevation: MaterialStateProperty.all(10),
                          minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                          backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 135, 204, 164)),
                          foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            PlantServices.addPlant(plantTypes[plantIndex], count, plantIndex);
                          });
                        },
                        child: const Text(
                          'Add Plant',
                          style: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                        ),
                      ),
                    ),
                      ],
                    ),
                  ),
                    ]
                  )
                ],
              ),
          )

          //----------------------------------------------------------PORTRAIT
          : Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      Image.asset("lib/assets/images/soil.png", scale: 0.5),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 70),
                        child: Image.asset(
                          "lib/assets/images/plant_background.png",
                          scale: 0.65,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: screenWidth * 0.07,
                        ),
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: plantTypes.length,
                          onPageChanged: (int index) {
                            setState(() {
                              plantIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return Transform.scale(
                              scale: 0.8,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Image.asset(
                                  "lib/assets/images/${plantTypes[index].name.toLowerCase()}.png",
                                )
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: screenWidth * 0.02), // Responsive spacing
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, // Responsive horizontal padding
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Text(
                      plantTypes[plantIndex].description,
                      maxLines: isOrientationLandscape ? 2 : 3,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.black,
                        fontSize: isOrientationLandscape ? screenWidth * 0.024 : screenWidth * 0.04, // Responsive font size
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenWidth * 0.02), // Responsive spacing
                Padding(
                  padding: EdgeInsets.fromLTRB(
                    screenWidth * 0.03, // Responsive padding
                    isOrientationLandscape ? 0 : screenWidth * 0.08, // Responsive padding
                    screenWidth * 0.03, // Responsive padding
                    isOrientationLandscape ? 0 : screenWidth * 0.08, // Responsive padding
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15, // Responsive width
                        height: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15, // Responsive height
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 135, 204, 164),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {
                            setState(() {
                              if (count > 1) count--;
                            });
                          },
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02), // Responsive spacing
                      Text(
                        count.toString(),
                        style: TextStyle(
                          fontFamily: 'Quicksand',
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: screenWidth * 0.15, // Responsive font size
                        ),
                      ),
                      SizedBox(width: screenWidth * 0.02), // Responsive spacing
                      Container(
                        width: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15,
                        height: isOrientationLandscape ? screenWidth * 0.08 : screenWidth * 0.15,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 135, 204, 164),
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            setState(() {
                              count++;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                padding: EdgeInsets.only(bottom: screenWidth * 0.03), // Responsive padding
                child: ElevatedButton(
                  style: ButtonStyle(
                    elevation: MaterialStateProperty.all(10),
                    minimumSize: MaterialStateProperty.all(const Size(250, 50)),
                    backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 135, 204, 164)),
                    foregroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      PlantServices.addPlant(plantTypes[plantIndex], count, plantIndex);
                    });
                  },
                  child: const Text(
                    'Add Plant',
                    style: TextStyle(fontSize: 18, fontFamily: 'Quicksand'),
                  ),
                ),
              ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
}