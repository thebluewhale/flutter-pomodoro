import 'dart:async';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const int twentyFiveSeconds = 60 * 25;
  int remainedTime = twentyFiveSeconds;
  bool isRunning = false;
  int totalPomoCount = 0;
  late Timer timer;

  void onSecondTick(Timer timer) {
    if (remainedTime <= 1) {
      timer.cancel();
      setState(() {
        remainedTime = twentyFiveSeconds;
        isRunning = false;
        totalPomoCount++;
      });
    } else {
      setState(() {
        remainedTime--;
      });
    }
  }

  void onStartButtonPressed() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      onSecondTick,
    );
    setState(() {
      isRunning = true;
    });
  }

  void onStopButtonPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void onRefreshButtonPressed() {
    timer.cancel();
    setState(() {
      isRunning = false;
      remainedTime = twentyFiveSeconds;
    });
  }

  String timeFormat(int seconds) {
    var duration = Duration(seconds: seconds);
    return duration.toString().split(".").first.substring(2, 7);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                timeFormat(remainedTime),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 89,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 3,
            child: Center(
              child: isRunning
                  ? IconButton(
                      iconSize: 120,
                      color: Theme.of(context).cardColor,
                      icon: const Icon(Icons.stop_circle_outlined),
                      onPressed: onStopButtonPressed,
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          iconSize: 120,
                          color: Theme.of(context).cardColor,
                          onPressed: onStartButtonPressed,
                          icon: const Icon(Icons.play_circle_outline_outlined),
                        ),
                        IconButton(
                          iconSize: 120,
                          color: Theme.of(context).cardColor,
                          onPressed: onRefreshButtonPressed,
                          icon: const Icon(Icons.refresh_outlined),
                        ),
                      ],
                    ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Pomodoros",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                        Text(
                          "$totalPomoCount",
                          style: TextStyle(
                            fontSize: 58,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).textTheme.headline1?.color,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
