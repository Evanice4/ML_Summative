import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(const BusWaitTimeApp());
}

class BusWaitTimeApp extends StatelessWidget {
  const BusWaitTimeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Super Fast',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const PredictionScreen(),
    );
  }
}

// Function that generates a feature vector based on the selected station.
List<double> stationToFeature(String? station) {
  int stationIndex;
  switch (station) {
    case 'Downtown':
      stationIndex = 0;
      break;
    case 'Remera':
      stationIndex = 1;
      break;
    case 'Nyabugogo':
      stationIndex = 2;
      break;
    case 'Kimironko':
      stationIndex = 3;
      break;
    default:
      stationIndex = 0;
  }

  // Generate 32 random features
  List<double> features = List.generate(32, (_) => Random().nextDouble());

  // Set the station feature to 1.0 for the selected station, and 0.0 for others
  for (int i = 0; i < 4; i++) {
    features[i] = (i == stationIndex) ? 1.0 : 0.0;
  }

  return features;
}

class PredictionScreen extends StatefulWidget {
  const PredictionScreen({super.key});

  @override
  State<PredictionScreen> createState() => _PredictionScreenState();
}

class _PredictionScreenState extends State<PredictionScreen> {
  String? selectedStation;
  String? selectedWeather;
  String? predictedTime;
  bool isLoading = false;

  final List<String> stations = ['Downtown', 'Remera', 'Nyabugogo', 'Kimironko'];
  final List<String> weatherOptions = ['Sunny', 'Rainy', 'Cloudy', 'Windy'];

  Future<void> predict() async {
    setState(() {
      isLoading = true;
      predictedTime = null;
    });

    try {
      final url = Uri.parse('https://bus-wait-time-api.onrender.com/predict'); //API endpoint URL
      final body = jsonEncode({
        "features": stationToFeature(selectedStation),
      });

      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final data = jsonDecode(response.body);

      setState(() {
        predictedTime = data['predicted_wait_time_minutes'] != null
            ? '${data['predicted_wait_time_minutes']} minutes'
            : 'Error occurred';
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        predictedTime = 'Prediction failed';
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    const orange = Color(0xFFF88E21);
    const blue = Color(0xFF0057FF);

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              color: orange,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/logo.png', height: 400), 
                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          
          Expanded(
            flex: 3,
            child: Container(
              width: double.infinity,
              color: blue,
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedStation,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Select Station ID',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: stations.map((station) {
                      return DropdownMenuItem(
                        value: station,
                        child: Text(station),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedStation = value),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<String>(
                    value: selectedWeather,
                    dropdownColor: Colors.white,
                    decoration: InputDecoration(
                      labelText: 'Select Weather',
                      labelStyle: const TextStyle(color: Colors.white),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.2),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    items: weatherOptions.map((weather) {
                      return DropdownMenuItem(
                        value: weather,
                        child: Text(weather),
                      );
                    }).toList(),
                    onChanged: (value) => setState(() => selectedWeather = value),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: isLoading ? null : predict,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: orange,
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: isLoading
                        ? const CircularProgressIndicator(color: Colors.white)
                        : const Text(
                      'Predict Wait Time',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),
                  if (predictedTime != null)
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        'Predicted Wait Time: $predictedTime',
                        style: const TextStyle(
                          fontSize: 18,
                          color: blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
