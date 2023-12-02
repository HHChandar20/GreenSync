import 'package:flutter/material.dart';
import 'package:green_sync/services/screen_size.dart';
import 'dart:math';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class GardeningTutorialScreen extends StatefulWidget {
  const GardeningTutorialScreen({
    Key? key,
    required this.titles,
    required this.tutorials,
    required this.videoPaths,
  }) : super(key: key);

  final List<String> titles;
  final List<String> tutorials;
  final List<String> videoPaths;

  @override
  State<GardeningTutorialScreen> createState() =>
      _GardeningTutorialScreenState();
}

class _GardeningTutorialScreenState extends State<GardeningTutorialScreen> {
  PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _tutorialCards = [];

  void setTutorialCards() {
    for (int i = 0; i < 3; i++) {
      _tutorialCards.add(_buildTutorialCard(
        widget.titles[i],
        widget.tutorials[i],
        widget.videoPaths[i],
        i
      ));
    }
  }

  Widget _buildTutorialCard(String title, String description, String videoPath, int index) {
  return Card(
    elevation: 4,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20),
    ),
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              fontFamily: 'Quicksand'
            ),
          ),
          const SizedBox(height: 30),
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: index == 2 ? YoutubePlayer(
              controller: YoutubePlayerController(initialVideoId: YoutubePlayer.convertUrlToId(videoPath) ?? '', flags: const YoutubePlayerFlags(autoPlay: false, enableCaption: false, hideThumbnail: true)),
              aspectRatio: 3 / 4,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              progressColors: const ProgressBarColors(
                playedColor: Colors.red,
                handleColor: Colors.red,
              ),
            )
            : Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                color: Colors.white,
                child: Container(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        description,
                        style: TextStyle(
                          fontSize: ScreenSize.screenWidth * 0.05,
                          fontFamily: 'Quicksand'
                        )
                      ),
                    ]
                  )
                )
            ),
          ),
        ],
      ),
    ),
  );
}
  @override
  void initState() {
    super.initState();
    setTutorialCards();
    _pageController = PageController(initialPage: _currentPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Colors.green[50],
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: screenWidth * 0.11),
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
                SizedBox(height: screenWidth * 0.11),
                SizedBox(
                  height: screenWidth * 1.5,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _tutorialCards.length,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      double scale =
                          max(0.9, 1 - (index - _currentPage).abs() * 0.3);
                      return Center(
                        child: Transform.scale(
                          scale: scale,
                          child: Padding(padding: const EdgeInsets.only(bottom: 30), child: _tutorialCards[index]),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SmoothPageIndicator(
                controller: _pageController,
                count: _tutorialCards.length,
                effect: const WormEffect(
                  activeDotColor: Colors.green,
                  dotColor: Colors.grey,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
