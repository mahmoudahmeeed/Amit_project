import 'dart:convert';
import '../../controller/utils/sql_helper/sql_helper.dart';

class DatabaseJobModel {
  int id;
  String name;
  String image;
  String compName;
  String? createdAt;
  DatabaseJobModel({
    required this.id,
    required this.name,
    required this.image,
    required this.compName,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      DatabseJobTableColumnTitles.jobId: id,
      DatabseJobTableColumnTitles.name: name,
      DatabseJobTableColumnTitles.image: image,
      DatabseJobTableColumnTitles.compName: compName,
      SavedJobTableColumnTitles.createdAt: createdAt,
    };
  }

  Map<String, dynamic> toMapApplied() {
    return <String, dynamic>{
      DatabseJobTableColumnTitles.jobId: id,
      DatabseJobTableColumnTitles.name: name,
      DatabseJobTableColumnTitles.image: image,
      DatabseJobTableColumnTitles.compName: compName,
    };
  }

  factory DatabaseJobModel.fromMap(Map<String, dynamic> map) {
    return DatabaseJobModel(
      id: map[DatabseJobTableColumnTitles.jobId] as int,
      name: map[DatabseJobTableColumnTitles.name] as String,
      image: map[DatabseJobTableColumnTitles.image] as String,
      compName: map[DatabseJobTableColumnTitles.compName] as String,
      createdAt: map[SavedJobTableColumnTitles.createdAt] != null
          ? map[SavedJobTableColumnTitles.createdAt] as String
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory DatabaseJobModel.fromJson(String source) =>
      DatabaseJobModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'DatabaseJobModel(id: $id, name: $name, image: $image, compName: $compName, createdAt: $createdAt)';
  }
}
