import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:weather/constants/constants.dart';
import 'package:weather/repo/get_weather.dart';
import 'package:weather/widgets/wearther_card.dart';
import 'package:weather/widgets/weather_card_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async{
      await context.read<GetWether>().getWeatherData();
    });
  }

  

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        elevation: 10,
        title: Text(
          "Today's Weather",
        ),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () async {
                await init();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          height: size.height,
          child: Consumer<GetWether>(builder: (context, state, child) {
            return state.loading
                ? Container(
                  child: Center(child: CircularProgressIndicator()))
                : Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      weatherWidget(size, state),
                      ListView.builder(
                          itemCount: 3,
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return weatherWidgetList(size, state,i);
                          })
                    ],
                  );
          }),
        ),
      ),
    );
  }


}
