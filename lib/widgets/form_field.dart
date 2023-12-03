
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:weather/models/dynamic_form_model.dart';
import 'package:weather/repo/post_form_data.dart';
import 'package:weather/utility/image_upload.dart';

Widget buildFormField(
  Field field,
  PostDyanamicFormData state,
  int fieldIndex,
) {
  Widget formField;

  switch (field.componentType) {
    case "EditText":
      formField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            style: TextStyle(color: Colors.red),
            decoration: InputDecoration(
              labelText: field.metaInfo.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              labelStyle: TextStyle(color: Colors.white),
            ),
            keyboardType: field.metaInfo.componentInputType == "INTEGER" ? TextInputType.number : TextInputType.text,
            onChanged: (value) {
              // state.updateEditText(value, fieldIndex);
              state.formData![fieldIndex] = {'${field.metaInfo.label}': value};
              if (value.isEmpty) {
                state.formData![fieldIndex].remove('${field.metaInfo.label}');
              }
            },
          ),
          SizedBox(height: 8),
          if (field.metaInfo.mandatory == "yes" && !state.formData![fieldIndex].containsKey('${field.metaInfo.label}'))
            Text(
              'This field is mandatory',
              style: TextStyle(fontSize: 10, color: Colors.red),
            )
        ],
      );
      break;

    case "CheckBoxes":
      formField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.metaInfo.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          for (var index = 0; index < field.metaInfo.options!.length; index++)
            CheckboxListTile(
              title: Text(
                field.metaInfo.options![index],
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              value: state.formData == null ? false : (state.formData![fieldIndex].isEmpty ? false : state.formData![fieldIndex]['${field.metaInfo.label}'].toString() == field.metaInfo.options![index]),
              onChanged: (value) {
                // state.onSelected(value!, field.metaInfo.options![index], fieldIndex);
                state.formData![fieldIndex] = {'${field.metaInfo.label}': field.metaInfo.options![index]};
                state.updateFormData();
              },
            ),
          if (field.metaInfo.mandatory == "yes" && !state.formData![fieldIndex].containsKey('${field.metaInfo.label}'))
            Text(
              'At least one option is mandatory',
              style: TextStyle(fontSize: 10, color: Colors.red),
            )
        ],
      );
      break;

    case "DropDown":
      formField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
            dropdownColor: Colors.red,
            items: field.metaInfo.options!.map((option) {
              return DropdownMenuItem(
                value: option,
                child: Text(
                  option,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }).toList(),
            onChanged: (value) {
              state.formData![fieldIndex] = {'${field.metaInfo.label}': value};
              // state.updateDropDownValue(value.toString(), fieldIndex);
            },
            decoration: InputDecoration(
              labelText: field.metaInfo.label,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red, width: 2.0),
              ),
              contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
              labelStyle: TextStyle(color: Colors.white),
            ),
          ),
          SizedBox(height: 8),
          if (field.metaInfo.mandatory == "yes" && !state.formData![fieldIndex].containsKey('${field.metaInfo.label}'))
            Text(
              'This field is mandatory',
              style: TextStyle(fontSize: 10, color: Colors.red),
            )
        ],
      );
      break;

    case "RadioGroup":
      formField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            field.metaInfo.label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 8),
          for (var index = 0; index < field.metaInfo.options!.length; index++)
            RadioListTile<String>(
              title: Text(
                field.metaInfo.options![index],
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
              value: state.formData![fieldIndex][index] ?? field.metaInfo.options![index],
              groupValue: state.formData == null ? null : (state.formData![fieldIndex].isEmpty ? null : state.formData![fieldIndex]['${field.metaInfo.label}']),
              onChanged: (value) {
                state.formData![fieldIndex] = {'${field.metaInfo.label}': field.metaInfo.options![index]};
                state.updateFormData();
                print(state.formData.toString());
                // state.updateRadioButton(value as int, fieldIndex);
              },
            ),
          if (field.metaInfo.mandatory == "yes" && !state.formData![fieldIndex].containsKey('${field.metaInfo.label}'))
            Text(
              'Please select an option',
              style: TextStyle(fontSize: 10, color: Colors.red),
            )
        ],
      );
      break;

    case "CaptureImages":
      formField = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
            onPressed: () async {
              var res = await ImageUpload().uploadImage(field);
              state.formData![fieldIndex] = {'${field.metaInfo.label}': res};
              print(state.formData.toString());
              state.updateFormData();
            },
            child: Text(
              field.metaInfo.label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          if (field.metaInfo.mandatory == "yes")
            Text(
              'Image capture is mandatory',
              style: TextStyle(fontSize: 10, color: Colors.red),
            )
        ],
      );
      break;

    default:
      formField = SizedBox.shrink();
  }

  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: FormField(
      builder: (FormFieldState state) {
        return formField;
      },
      validator: (value) {
        return null;
      },
    ),
  );
}
