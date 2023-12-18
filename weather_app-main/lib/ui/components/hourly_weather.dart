import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/weathermodel.dart';

class HourlyWeather extends StatelessWidget {
  final Hour? hour;
  const HourlyWeather({super.key, this.hour});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(8),
      width: 120,
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${hour?.tempC?.round().toString() ?? ""} °C",
            style: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ),
          Container(
            height: 50,
            decoration: const BoxDecoration(
                color: Colors.white, shape: BoxShape.circle),
            child: Image.network("https:${hour?.condition?.icon ?? ""}"),
          ),
          Text(
            DateFormat.j().format(
              DateTime.parse(hour?.time?.toString() ?? ""),
            ),
            style: const TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
