import 'dart:convert';

class NodeModel {
  String? id;
  String? title;
  String? subtitle;

  NodeModel({this.id, this.title, this.subtitle});

  factory NodeModel.fromMap(Map<String, dynamic> json) => NodeModel(
        id: json["id"],
        title: json["title"],
        subtitle: json["subtitle"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "subtitle": subtitle,
      };
}
