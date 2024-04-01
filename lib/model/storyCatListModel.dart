// To parse this JSON data, do
//
//     final storyCatListModel = storyCatListModelFromJson(jsonString);

import 'dart:convert';

StoryCatListModel storyCatListModelFromJson(String str) => StoryCatListModel.fromJson(json.decode(str));

String storyCatListModelToJson(StoryCatListModel data) => json.encode(data.toJson());

class StoryCatListModel {
  bool? status;
  String? message;
  List<DataList>? data;

  StoryCatListModel({
    this.status,
    this.message,
    this.data,
  });

  factory StoryCatListModel.fromJson(Map<String, dynamic> json) => StoryCatListModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? [] : List<DataList>.from(json["data"]!.map((x) => DataList.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
  };
}

class DataList {
  int? id;
  String? storyTitle;
  String? story;
  dynamic storyNote;
  Category? category;
  int? viewCount;
  int? averageRating;
  String? featuredImage;

  DataList({
    this.id,
    this.storyTitle,
    this.story,
    this.storyNote,
    this.category,
    this.viewCount,
    this.averageRating,
    this.featuredImage,
  });

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
    id: json["id"],
    storyTitle: json["story_title"],
    story: json["story"],
    storyNote: json["story_note"],
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
    viewCount: json["view_count"],
    averageRating: json["average_rating"],
    featuredImage: json["featured_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "story_title": storyTitle,
    "story": story,
    "story_note": storyNote,
    "category": category?.toJson(),
    "view_count": viewCount,
    "average_rating": averageRating,
    "featured_image": featuredImage,
  };
}

class Category {
  int? id;
  String? title;
  String? imageUrl;

  Category({
    this.id,
    this.title,
    this.imageUrl,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    title: json["title"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image_url": imageUrl,
  };
}
