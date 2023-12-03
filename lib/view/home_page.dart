import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
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

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      await context.read<GetDyanamicFormData>().getDyanamicFormDataData().then((val) {
        context.read<PostDyanamicFormData>().formData = List.filled(context.read<GetDyanamicFormData>().data!.fields.length, {});
      });
    });
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


