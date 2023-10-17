// To parse this JSON data, do
//
//     final arabaModel = arabaModelFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

ArabaModel arabaModelFromJson(String str) =>
    ArabaModel.fromJson(json.decode(str));

String arabaModelToJson(ArabaModel data) => json.encode(data.toJson());

class ArabaModel {
  ArabaModel({
    required this.arabam,
    required this.lke,
    required this.kurulusYil,
    required this.model,
  });

  final String arabam;
  final String lke;
  final int kurulusYil;
  final List<Model> model;

  factory ArabaModel.fromJson(Map<String, dynamic> json) => ArabaModel(
        arabam: json["arabam"],
        lke: json["ülke"],
        kurulusYil: json["kurulus_yil"],
        model: List<Model>.from(json["model"].map((x) => Model.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "arabam": arabam,
        "ülke": lke,
        "kurulus_yil": kurulusYil,
        "model": List<dynamic>.from(model.map((x) => x.toJson())),
      };
}

class Model {
  Model({
    required this.modelAdi,
    required this.fiyat,
    required this.benzinli,
  });

  final String modelAdi;
  final int fiyat;
  final bool benzinli;

  factory Model.fromJson(Map<String, dynamic> json) => Model(
        modelAdi: json["model_adi"],
        fiyat: json["fiyat"],
        benzinli: json["benzinli"],
      );

  Map<String, dynamic> toJson() => {
        "model_adi": modelAdi,
        "fiyat": fiyat,
        "benzinli": benzinli,
      };
}
