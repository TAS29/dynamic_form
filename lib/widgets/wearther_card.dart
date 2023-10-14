
  import 'package:flutter/material.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/repo/get_weather.dart';
import 'package:weather/utils/utilities.dart';

Padding weatherWidget(Size size, GetWether state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
          // height: 240,
          width: size.width,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Container(
              height: 180,
              margin: const EdgeInsets.only(bottom: 0),
              width: size.width,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.purple,
                        Colors.purpleAccent,
                        Colors.purpleAccent,
                      ])),
            ),
            Positioned(
              bottom: 10,
              left: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        state.data!.current.temperature2M.toString() +
                            state.data!.currentUnits.temperature2M,
                        style: const TextStyle(
                            height: 0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 23),
                      ),
                      // Text(
                      // " "+  state.data!.daily.temperature2MMin.toString() +state.data!.dailyUnits.temperature2MMin,
                      //   style: const TextStyle(
                      //       height: 0,
                      //       color: Colors.white,
                      //       fontWeight: FontWeight.bold,
                      //       fontSize: 20),
                      // ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    currentTime(),
                    style: TextStyle(
                        height: 0,
                        color: Colors.white.withOpacity(.8),
                        fontWeight: FontWeight.bold,
                        fontSize: 15),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 30,
              // right: 50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShaderMask(
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Colors.white, Colors.white.withOpacity(.5)],
                          // Adjust the stops to control the gradient area
                        ).createShader(bounds);
                      },
                      child: Text(
                        "Today's: Forecast " +   weather_codes[state.data!.daily.weathercode[0]],
                        style: const TextStyle(
                          fontSize: 22,
                          height: 0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Initial color of the text
                        ),
                      )),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 40,
              child: ShaderMask(
                shaderCallback: (Rect bounds) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.white, Colors.white],
                    // Adjust the stops to control the gradient area
                  ).createShader(bounds);
                },
                child: Text(
                  weatherIconMapping[state.data!.daily.weathercode[0]]!,
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
          ])),
    );
  }