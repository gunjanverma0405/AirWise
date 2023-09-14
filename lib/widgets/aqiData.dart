// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class PollutantsData extends StatelessWidget {
  final String pollutantName;
  num? level;
  Color? aqiColor;

  PollutantsData({
    Key? key,
    required this.pollutantName,
    this.level,
    this.aqiColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              //color: Colors.black,
              //shape: BoxShape.rectangle,
              border: Border.all(
                width: 3,
                color: Colors.white,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(8))),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Text('$level',
                style: const TextStyle(
                  fontSize: 14.0,
                  color: Color.fromARGB(255, 97, 12, 235),
                )),
          ),
        ),
        Text(pollutantName,
            style: const TextStyle(
              fontSize: 15.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ],
    );
  }
}
