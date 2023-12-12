import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/main.dart';
import 'package:weather/models/dynamic_form_model.dart';
import 'package:weather/repo/get_dynamic_form_data.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/connectivity.dart';
import 'package:weather/utility/shared_preference.dart';
import 'package:weather/widgets/form_field.dart';
import 'package:weather/widgets/submit_button.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {
  @override
  void initState() {
    init();
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  final box = Hive.box<DynamicForm>('box');

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      var formData = box.get('form');
      if (formData == null) {
        await context.read<GetDyanamicFormData>().getDyanamicFormDataData().then((val) {
          context.read<PostDyanamicFormData>().formData = List.filled(context.read<GetDyanamicFormData>().data!.fields.length, {});
        });
      } else {
        context.read<GetDyanamicFormData>().getDataFromDb(formData);
         context.read<PostDyanamicFormData>().formData = List.filled(context.read<GetDyanamicFormData>().data!.fields.length, {});
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        await BackgroundTask().startBackgroundTask();
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 10,
        title: Text(
          "Polaris",
          style: TextStyle(color: Colors.red), // Netflix red color
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await init();
            },
            icon: const Icon(Icons.refresh, color: Colors.white),
          )
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Consumer<GetDyanamicFormData>(
          builder: (context, state, child) {
            return state.loading
                ? Container(
                    height: size.height,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        Form(
                            child: ListView.builder(
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.data!.fields.length,
                                shrinkWrap: true,
                                itemBuilder: (context, i) {
                                  return buildFormField(state.data!.fields[i], context.watch<PostDyanamicFormData>(), i);
                                })),
                        SizedBox(
                          height: 10,
                        ),
                        submitButton(),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
