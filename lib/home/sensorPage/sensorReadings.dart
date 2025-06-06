import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async'; // Import for Timer

class SenorReadings extends StatefulWidget {
  const SenorReadings({super.key});

  @override
  State<SenorReadings> createState() => _SenorReadingsState();
}

class _SenorReadingsState extends State<SenorReadings> {
  Map<String, dynamic>? sensorData;
  String errorMessage = '';
  final String nodeMcuIP = 'http://10.10.173.113'; // Replace with your NodeMCU IP
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchSensorData(); // Initial fetch
    _timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      fetchSensorData(); // Fetch every 0.5 seconds
    });
  }

  @override
  void dispose() {
    _timer?.cancel(); // Stop the timer when widget is disposed
    super.dispose();
  }

  Future<void> fetchSensorData() async {
    try {
      final response = await http.get(Uri.parse(nodeMcuIP));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          sensorData = data;
          errorMessage = '';
        });
      } else {
        setState(() {
          errorMessage = 'Failed to get data: ${response.statusCode}';
          sensorData = null;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error fetching data: $e';
        sensorData = null;
      });
    }
  }

  Widget _buildSensorValue(String label, dynamic value, [String unit = '']) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Text(
        '$label: $value $unit',
        style: const TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFFCA),
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
                  height: 350,
                  decoration: BoxDecoration(
                    color: const Color(0xFF84AE92),
                    borderRadius: const BorderRadius.all(Radius.circular(20)),
                  ),
                  child: Center(
                    child: Container(
                      height: 300,
                      width: 250,
                      color: Colors.pink,
                      padding: const EdgeInsets.all(16),
                      child: errorMessage.isNotEmpty
                          ? Text(
                        errorMessage,
                        style: const TextStyle(
                            color: Colors.white, fontSize: 18),
                      )
                          : sensorData == null
                          ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                          : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildSensorValue('Soil Moisture',
                              sensorData!['soil_moisture']),
                          _buildSensorValue('Temperature',
                              sensorData!['temperature'], '°C'),
                          _buildSensorValue(
                              'Humidity', sensorData!['humidity'], '%'),
                          _buildSensorValue('Heat Index',
                              sensorData!['heat_index'], '°C'),
                          _buildSensorValue('Air Quality Index',
                              sensorData!['air_quality_index']),
                          const SizedBox(height: 20),
                          // ElevatedButton.icon(
                          //   onPressed: fetchSensorData,
                          //   icon: const Icon(Icons.refresh),
                          //   label: const Text('Refresh'),
                          //   style: ElevatedButton.styleFrom(
                          //     backgroundColor: Colors.white,
                          //     foregroundColor: Colors.pink,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
