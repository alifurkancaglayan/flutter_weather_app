import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:flutter_weather_app/data/dateset.dart';
import 'package:flutter_weather_app/screens/home/components/extra_weather.dart';
import 'package:flutter_weather_app/screens/home/components/today_weather.dart';

Weather? currentTemp;
Weather? tomorrowTemp;
List<Weather>? todayWeather;
List<Weather>? sevenDay;
String lat = "37.09516720";
String lon = "31.07937050";
String city = "Antalya";

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  getData() async {
    fetchData(lat, lon, city).then((value) {
      currentTemp = value[0];
      todayWeather = value[1];
      tomorrowTemp = value[2];
      sevenDay = value[3];
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff030317),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: currentTemp == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  CurrentWeather(updateData: getData),
                  TodayWeather(),
                ],
              ),
      ),
    );
  }
}

class CurrentWeather extends StatefulWidget {
  const CurrentWeather({Key? key, required this.updateData}) : super(key: key);
  final Function() updateData;

  @override
  State<CurrentWeather> createState() => _CurrentWeatherState();
}

class _CurrentWeatherState extends State<CurrentWeather> {
  bool serachBar = false;
  bool updating = false;
  var focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (serachBar) {
          setState(() {
            serachBar = false;
          });
        }
      },
      child: GlowContainer(
        height: MediaQuery.of(context).size.height,
        margin: EdgeInsets.all(2),
        padding: EdgeInsets.only(top: 50, left: 30, right: 30),
        glowColor: Color(0xff00A1FF).withOpacity(0.5),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(60), bottomRight: Radius.circular(60)),
        color: Color(0xff00A1FF),
        spreadRadius: 5,
        child: Column(
          children: [
            Container(
              child: serachBar
                  ? TextField(
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        fillColor: Color(0xff030317),
                        filled: true,
                        hintText: "Enter a City Name",
                      ),
                      textInputAction: TextInputAction.search,
                      onSubmitted: (value) async {
                        CityModel temp = await fetchCity(value);
                        if (temp.name == "hata") {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Color(0xff030317),
                                title: Text("City not found"),
                                content: Text("Please check the city name"),
                                actions: [
                                  TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text("Ok"))
                                ],
                              );
                            },
                          );
                          serachBar = false;
                          return;
                        }
                        city = temp.name;
                        lat = temp.lat;
                        lon = temp.lon;
                        updating = true;
                        setState(() {});
                        widget.updateData();
                        serachBar = false;
                        updating = false;
                        setState(() {});
                      },
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          CupertinoIcons.square_grid_2x2,
                          color: Colors.white,
                        ),
                        Row(
                          children: [
                            Icon(CupertinoIcons.map_fill, color: Colors.white),
                            GestureDetector(
                              onTap: () {
                                serachBar = true;
                                setState(() {});
                                focusNode.requestFocus();
                              },
                              child: Text(
                                " " + city,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 30),
                              ),
                            ),
                          ],
                        ),
                        Icon(Icons.more_vert, color: Colors.white)
                      ],
                    ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 0.2, color: Colors.white),
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                updating ? "Updating" : "Updated",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              height: 420,
              child: Stack(
                children: [
                  Image(
                    image: AssetImage(currentTemp!.image!),
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    left: 0,
                    child: Center(
                      child: Column(
                        children: [
                          GlowText(
                            currentTemp!.current.toString(),
                            style: TextStyle(
                                height: 0.1,
                                fontSize: 150,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(currentTemp!.name!,
                              style: TextStyle(
                                fontSize: 25,
                              )),
                          Text(currentTemp!.day!,
                              style: TextStyle(
                                fontSize: 18,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            ExtraWeather(currentTemp!)
          ],
        ),
      ),
    );
  }
}
