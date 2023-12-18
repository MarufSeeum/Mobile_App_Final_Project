import 'package:flutter/material.dart';
import 'package:weather_app_1/model/weathermodel.dart';
import 'package:weather_app_1/service/api_service.dart';
import 'package:weather_app_1/ui/components/hourly_weather.dart';
import 'package:weather_app_1/ui/components/todays_weather.dart';
import 'components/future_forcast.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService apiService = ApiService();

  final _textFieldController = TextEditingController();
  String searchText = "auto:ip";

  _showInputDialoge(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("Search Location"),
            content: TextField(
              controller: _textFieldController,
              decoration: InputDecoration(hintText: "Search by City, Zip, Ip"),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_textFieldController.text.isEmpty) {
                    return;
                  }
                  Navigator.pop(context, _textFieldController.text);
                },
                child: Text("OK"),
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[900],
      appBar: AppBar(
        backgroundColor: Colors.teal[900],
        title: const Text(
          'Flutter Weather App',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              onPressed: () async {
                _textFieldController.clear();
                String text = await _showInputDialoge(context);
                setState(() {
                  searchText = text;
                });
              },
              icon: const Icon(Icons.search)),
          IconButton(onPressed: () {
            searchText = "auto:ip";
            setState(() {

            });
          }, icon: const Icon(Icons.my_location)),
        ],
      ),
      body: SafeArea(
        child: FutureBuilder(
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              WeatherModel? weatherModel = snapshot.data;

              return SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    TodaysWeather(
                      weatherModel: weatherModel,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Weather By Hours",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      height: 150,
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Hour? hour = weatherModel
                              ?.forecast?.forecastday?[0].hour?[index];
                          return HourlyWeather(
                            hour: hour,
                          );
                        },
                        itemCount: weatherModel
                            ?.forecast?.forecastday?[0].hour?.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Next 7day Weather",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Expanded(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          Forecastday? forcastday =
                              weatherModel?.forecast?.forecastday?[index];
                          return ForcstList(
                            forcastday: forcastday,
                          );
                        },
                        itemCount: weatherModel?.forecast?.forecastday?.length,
                      ),
                    ),
                  ],
                ),
              );
            }

            if (snapshot.hasError) {
              return const Center(
                child: Text("Error has Acuured"),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
          future: apiService.getWeatherData(searchText),
        ),
      ),
    );
  }
}
