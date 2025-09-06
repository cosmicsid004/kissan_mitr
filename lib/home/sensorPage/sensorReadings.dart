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
  String soilMoisture = "Fetching...";
  String soilPh = "Fetching...";
  Timer? timer;

  Future<void> fetchSensorData() async {
    await Future.delayed(const Duration(milliseconds: 500)); // simulate delay
    final random = Random();

    setState(() {
      soilMoisture = "${30 + random.nextInt(20)}%"; // e.g. 30–50% range
      soilPh = (5 + random.nextDouble() * 3.0).toStringAsFixed(2);// e.g. 5.0–8.0 range
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

  bool pumpIsOn = false; // state for toggle
  bool phManager = false;
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
                padding: const EdgeInsets.all(16.0), // reduced a bit for small screens
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double cardHeight = constraints.maxHeight > 0
                        ? constraints.maxHeight * 0.35
                        : MediaQuery.of(context).size.height * 0.25;

                    final double imageFlex = constraints.maxWidth > 600 ? 3 : 2;
                    final double textSize = MediaQuery.of(context).size.width * 0.045;
                    final double subtitleSize = MediaQuery.of(context).size.width * 0.04;

                    return Container(
                      height: cardHeight.clamp(180, 280), // min 180, max 280
                      decoration: BoxDecoration(
                        color: colors.cardColor(),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: imageFlex.toInt(),
                              child: Image.asset(
                                'assets/sensorPage/sprinkler.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20), // dynamic spacing (reduced from 80)
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, anim) =>
                                        FadeTransition(opacity: anim, child: child),
                                    child: Text(
                                      "🌡 Soil Moisture: $soilMoisture",
                                      key: ValueKey(soilMoisture), // important for AnimatedSwitcher
                                      style: TextStyle(
                                        fontSize: textSize.clamp(18, 24), // scale with screen
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          pumpIsOn ? "Sprinkler: ON" : "Sprinkler: OFF",
                                          style: TextStyle(
                                            fontSize: subtitleSize.clamp(16, 20),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Switch(
                                        value: pumpIsOn,
                                        onChanged: (value) {
                                          setState(() {
                                            pumpIsOn = value;
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
                    );
                  },
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0), // reduced a bit for small screens
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final double cardHeight = constraints.maxHeight > 0
                        ? constraints.maxHeight * 0.35
                        : MediaQuery.of(context).size.height * 0.25;

                    final double imageFlex = constraints.maxWidth > 600 ? 3 : 2;
                    final double textSize = MediaQuery.of(context).size.width * 0.045;
                    final double subtitleSize = MediaQuery.of(context).size.width * 0.04;

                    return Container(
                      height: cardHeight.clamp(180, 280), // min 180, max 280
                      decoration: BoxDecoration(
                        color: colors.cardColor(),
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: imageFlex.toInt(),
                              child: Image.asset(
                                'assets/sensorPage/ph.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                            const SizedBox(width: 20), // dynamic spacing (reduced from 80)
                            Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  AnimatedSwitcher(
                                    duration: const Duration(milliseconds: 500),
                                    transitionBuilder: (child, anim) =>
                                        FadeTransition(opacity: anim, child: child),
                                    child: Text(
                                      "🌡 Soil pH: $soilPh",
                                      key: ValueKey(soilPh), // important for AnimatedSwitcher
                                      style: TextStyle(
                                        fontSize: textSize.clamp(18, 24), // scale with screen
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          phManager ? "pH Manager: ON" : "pH Manager: OFF",
                                          style: TextStyle(
                                            fontSize: subtitleSize.clamp(16, 20),
                                          ),
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Switch(
                                        value: phManager,
                                        onChanged: (value) {
                                          setState(() {
                                            phManager = value;
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
                    );
                  },
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
