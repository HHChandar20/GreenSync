import 'package:flutter/material.dart';

class GardenElement extends StatefulWidget {
  const GardenElement(
      {super.key,
      required this.plantImagePath,
      required this.count,
      required this.humidity,
      required this.growth});

  final String plantImagePath;
  final int count;
  final String humidity;
  final String growth;

  @override
  State<GardenElement> createState() => _GardenElementState();
}

class _GardenElementState extends State<GardenElement> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Align(
                        alignment: Alignment.topRight,
                        child: Text("x${widget.count}",
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 20)))),
                  Padding(
                      padding: const EdgeInsets.only(top: 73),
                      child: Image.asset("lib/assets/images/soil.png")),
                  Image.asset(
                    widget.plantImagePath,
                    width: 180,
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.only(left: 5, right: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        const Icon(Icons.opacity, size: 25),
                        Text("${widget.humidity}h",
                            style: const TextStyle(fontSize: 18))
                      ]),
                  Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text("${widget.growth}%",
                            style: const TextStyle(fontSize: 18)),
                        const Icon(Icons.trending_up, size: 27),
                      ])
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
