import 'dart:convert';
import 'package:hive/hive.dart';

part 'dynamic_form_model.g.dart';

DynamicForm dynamicFormFromJson(String str) =>
    DynamicForm.fromJson(json.decode(str));

String dynamicFormToJson(DynamicForm data) => json.encode(data.toJson());

@HiveType(typeId: 0)
class DynamicForm extends HiveObject {
  @HiveField(0)
  String formName;
  @HiveField(1)
  List<Field> fields;

  DynamicForm({
    required this.formName,
    required this.fields,
  });

  factory DynamicForm.fromJson(Map<String, dynamic> json) => DynamicForm(
        formName: json["form_name"],
        fields: List<Field>.from(json["fields"].map((x) => Field.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "form_name": formName,
        "fields": List<dynamic>.from(fields.map((x) => x.toJson())),
      };
}

@HiveType(typeId: 1)
class Field {
  @HiveField(0)
  MetaInfo metaInfo;
  @HiveField(1)
  String componentType;

  Field({
    required this.metaInfo,
    required this.componentType,
  });

  factory Field.fromJson(Map<String, dynamic> json) => Field(
        metaInfo: MetaInfo.fromJson(json["meta_info"]),
        componentType: json["component_type"],
      );

  Map<String, dynamic> toJson() => {
        "meta_info": metaInfo.toJson(),
        "component_type": componentType,
      };
}

@HiveType(typeId: 2)
class MetaInfo {
  @HiveField(0)
  String label;
  @HiveField(1)
  String? componentInputType;
  @HiveField(2)
  String mandatory;
  @HiveField(3)
  List<String>? options;
  @HiveField(4)
  int? noOfImagesToCapture;
  @HiveField(5)
  String? savingFolder;

  MetaInfo({
    required this.label,
    this.componentInputType,
    required this.mandatory,
    this.options,
    this.noOfImagesToCapture,
    this.savingFolder,
  });

  factory MetaInfo.fromJson(Map<String, dynamic> json) => MetaInfo(
        label: json["label"],
        componentInputType: json["component_input_type"],
        mandatory: json["mandatory"],
        options: json["options"] == null
            ? []
            : List<String>.from(json["options"]!.map((x) => x)),
        noOfImagesToCapture: json["no_of_images_to_capture"],
        savingFolder: json["saving_folder"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "component_input_type": componentInputType,
        "mandatory": mandatory,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x)),
        "no_of_images_to_capture": noOfImagesToCapture,
        "saving_folder": savingFolder,
      };
}

