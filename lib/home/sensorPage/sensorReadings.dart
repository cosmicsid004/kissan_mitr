import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:kissan_mitr/common.dart';
import 'package:lottie/lottie.dart';

class SenorReadings extends StatefulWidget {
  const SenorReadings({super.key});

  @override
  State<SenorReadings> createState() => _SenorReadingsState();
}

class _SenorReadingsState extends State<SenorReadings> {
  String sensorData = "Fetching...";
  Timer? timer;

  Future<void> fetchSensorData() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    final random = Random();
    setState(() {
      sensorData =
          "🌡 Soil Moisture: \n${20 + random.nextInt(10)}°C";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchSensorData(); // first fetch
    timer = Timer.periodic(
      const Duration(seconds: 3),
      (t) => fetchSensorData(),
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  bool isOn = false; // state for toggle
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.backgroundColor(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 50),
              Container(
                width: 250,
                height: 250,
                alignment: Alignment.topCenter,
                child: Lottie.asset('assets/homeIcon/homeicon.json'),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: colors.cardColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/sensorPage/sprinkler.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (child, anim) =>
                                    FadeTransition(opacity: anim, child: child),
                                child: Text(
                                  sensorData,
                                  key: ValueKey(sensorData), // required for AnimatedSwitcher
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    isOn ? "Sprinkler: ON" : "Sprinkler: OFF",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Switch(
                                    value: isOn,
                                    onChanged: (value) {
                                      setState(() {
                                        isOn = value;
                                        // TODO: send command to NodeMCU when real device is ready
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 250,
                  decoration: BoxDecoration(
                    color: colors.cardColor(),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Image.asset(
                            'assets/sensorPage/ph.png',
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(width: 80),
                        Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 500),
                                transitionBuilder: (child, anim) =>
                                    FadeTransition(opacity: anim, child: child),
                                child: Text(
                                  sensorData,
                                  key: ValueKey(sensorData), // required for AnimatedSwitcher
                                  style: const TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    isOn ? "Sprinkler: ON" : "Sprinkler: OFF",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Switch(
                                    value: isOn,
                                    onChanged: (value) {
                                      setState(() {
                                        isOn = value;
                                        // TODO: send command to NodeMCU when real device is ready
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//with sensor
/*

  Future<void> fetchSensorData() async {
    try {
      // Replace with your NodeMCU IP
      final response = await http.get(Uri.parse("http://192.168.1.50/sensor"));

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          sensorData = "🌡 Temp: ${data['temperature']}°C\n💧 Humidity: ${data['humidity']}%";
        });
      } else {
        setState(() {
          sensorData = "Error: ${response.statusCode}";
        });
      }
    } catch (e) {
      setState(() {
        sensorData = "Failed to connect 😞";
      });
    }
  }
 */

/*
sensorData,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
 */
