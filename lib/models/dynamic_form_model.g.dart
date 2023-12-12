// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dynamic_form_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DynamicFormAdapter extends TypeAdapter<DynamicForm> {
  @override
  final int typeId = 0;

  @override
  DynamicForm read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DynamicForm(
      formName: fields[0] as String,
      fields: (fields[1] as List).cast<Field>(),
    );
  }

  @override
  void write(BinaryWriter writer, DynamicForm obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.formName)
      ..writeByte(1)
      ..write(obj.fields);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DynamicFormAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FieldAdapter extends TypeAdapter<Field> {
  @override
  final int typeId = 1;

  @override
  Field read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Field(
      metaInfo: fields[0] as MetaInfo,
      componentType: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Field obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.metaInfo)
      ..writeByte(1)
      ..write(obj.componentType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FieldAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class MetaInfoAdapter extends TypeAdapter<MetaInfo> {
  @override
  final int typeId = 2;

  @override
  MetaInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MetaInfo(
      label: fields[0] as String,
      componentInputType: fields[1] as String?,
      mandatory: fields[2] as String,
      options: (fields[3] as List?)?.cast<String>(),
      noOfImagesToCapture: fields[4] as int?,
      savingFolder: fields[5] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, MetaInfo obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.label)
      ..writeByte(1)
      ..write(obj.componentInputType)
      ..writeByte(2)
      ..write(obj.mandatory)
      ..writeByte(3)
      ..write(obj.options)
      ..writeByte(4)
      ..write(obj.noOfImagesToCapture)
      ..writeByte(5)
      ..write(obj.savingFolder);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MetaInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
