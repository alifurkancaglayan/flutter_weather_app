import 'package:flutter/material.dart';
import 'package:flutter_weather_app/screens/details/detail_screen.dart';
import 'package:flutter_weather_app/screens/home/components/weather_widget.dart';
import 'package:flutter_weather_app/screens/home/home_screen.dart';

class TodayWeather extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 30, right: 30, top: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Today",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) => DetailScreen(
                        tomorrowTemp: tomorrowTemp,
                        sevenDay: sevenDay,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    Text(
                      "7 days",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    Icon(
                      color: Colors.grey,
                      Icons.arrow_forward_outlined,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            margin: EdgeInsets.only(
              bottom: 30,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                WeatherWidget(
                  weather: todayWeather![0],
                ),
                WeatherWidget(
                  weather: todayWeather![1],
                ),
                WeatherWidget(
                  weather: todayWeather![2],
                ),
                WeatherWidget(
                  weather: todayWeather![3],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
