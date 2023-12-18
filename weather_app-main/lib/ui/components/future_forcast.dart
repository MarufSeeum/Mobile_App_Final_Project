import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../model/weathermodel.dart';

class ForcstList extends StatelessWidget {
  final Forecastday? forcastday;

  const ForcstList({super.key, this.forcastday});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white70,
        borderRadius: BorderRadius.circular(20),
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      margin: const EdgeInsets.all(8),
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.network("https:${forcastday?.day?.condition?.icon ?? ""}"),
          Expanded(
            child: Text(
              DateFormat.MMMEd().format(
                DateTime.parse(forcastday?.date.toString() ?? ""),
              ),
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              forcastday?.day?.condition?.text.toString() ?? "",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Expanded(
            child: Text(
              "^${forcastday?.day?.maxtempC?.round()}/${forcastday?.day?.mintempC?.round()} °C",
              style: const TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
