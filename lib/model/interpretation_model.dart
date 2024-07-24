/*
 * *
 *  * interpretation_model.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:08
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:08
 *
 */

import 'package:quranku/model/surah_model.dart';

class InterpretationModel {
  final int? number;
  final String? name;
  final String? latinName;
  final int? ayatCount;
  final String? place;
  final String? meaning;
  final String? description;
  final Map<String, String>? audioFull;
  final List<InterpretationDataModel>? data;
  final SurahModel? nextSurah;
  final SurahModel? prevSurah;

  InterpretationModel({
    this.number,
    this.name,
    this.latinName,
    this.ayatCount,
    this.place,
    this.meaning,
    this.description,
    this.audioFull,
    this.data,
    this.nextSurah,
    this.prevSurah,
  });

  factory InterpretationModel.fromJson(Map<String, dynamic> json) =>
      InterpretationModel(
        number: json["nomor"],
        name: json["nama"],
        latinName: json["namaLatin"],
        ayatCount: json["jumlahAyat"],
        place: json["tempatTurun"],
        meaning: json["arti"],
        description: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        data: json["tafsir"] == null
            ? []
            : List<InterpretationDataModel>.from(json["tafsir"]!
                .map((x) => InterpretationDataModel.fromJson(x))),
        nextSurah: json["suratSelanjutnya"] == null
            ? null
            : SurahModel.fromJson(json["suratSelanjutnya"]),
        prevSurah: json["suratSebelumnya"] == null
            ? null
            : SurahModel.fromJson(json["suratSebelumnya"]),
      );

  Map<String, dynamic> toJson() => {
        "nomor": number,
        "nama": name,
        "namaLatin": latinName,
        "jumlahAyat": ayatCount,
        "tempatTurun": place,
        "arti": meaning,
        "deskripsi": description,
        "audioFull":
            Map.from(audioFull!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tafsir": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "suratSelanjutnya": nextSurah?.toJson(),
        "suratSebelumnya": prevSurah?.toJson(),
      };
}

class InterpretationDataModel {
  final int? ayat;
  final String? text;

  InterpretationDataModel({
    this.ayat,
    this.text,
  });

  factory InterpretationDataModel.fromJson(Map<String, dynamic> json) =>
      InterpretationDataModel(
        ayat: json["ayat"],
        text: json["teks"],
      );

  Map<String, dynamic> toJson() => {
        "ayat": ayat,
        "teks": text,
      };
}
