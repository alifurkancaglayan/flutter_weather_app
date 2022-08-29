import 'package:flutter/material.dart';
import 'package:flutter_weather_app/data/dateset.dart';
import 'package:flutter_weather_app/screens/details/components/tomorrow_weather.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key, this.tomorrowTemp, this.sevenDay})
      : super(key: key);

  final Weather? tomorrowTemp;
  final List<Weather>? sevenDay;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: Column(
        children: [
          TomorrowWeather(
            tomorrowTemp: tomorrowTemp,
          ),
          SevenDays(
            sevenDay: sevenDay,
          ),
        ],
      ),
    );
  }
}

class SevenDays extends StatelessWidget {
  const SevenDays({Key? key, required this.sevenDay}) : super(key: key);

  final List<Weather>? sevenDay;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: sevenDay!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 25,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  sevenDay![index].day!,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                Container(
                  width: 135,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image(
                        image: AssetImage(sevenDay![index].image!),
                        width: 40,
                      ),
                      SizedBox(width: 15),
                      Text(
                        sevenDay![index].name!,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "+" + sevenDay![index].max.toString() + "\u00B0",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "+" + sevenDay![index].min.toString() + "\u00B0",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
