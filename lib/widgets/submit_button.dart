import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather/main.dart';
import 'package:weather/repo/get_dynamic_form_data.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/shared_preference.dart';
import 'package:workmanager/workmanager.dart';

class submitButton extends StatelessWidget {
  const submitButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<GetDyanamicFormData>(builder: (context, state, child) {
      return ElevatedButton(
        onPressed: () async {
          List<String> fieldLabels = state.data!.fields.where((field) => field.metaInfo.mandatory != "no").map((field) => field.metaInfo.label).toList();
          if (fieldLabels.any((label) => !context.read<PostDyanamicFormData>().formData!.any((data) => data.keys.contains(label)))) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Please fill all mandatory fields!'),
              ),
            );
            return;
          }
          final hasConnection = await InternetConnectionChecker().hasConnection;
          if (hasConnection) {
            await context.read<PostDyanamicFormData>().postDyanamicFormDataData();
          } else {
          SharedPreferences sp = await SharedPreferences.getInstance();
            await sp.setBool("should_call_api",true);
            await LocalStorage().saveApiData(context.read<PostDyanamicFormData>().formData!);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Text(
          'Submit',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      );
    });
  }
}
