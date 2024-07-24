/*
 * *
 *  * surah_detail_model.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:55
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/24/2024, 23:55
 *
 */

import 'package:quranku/model/ayat_model.dart';
import 'package:quranku/model/surah_model.dart';

class SurahDetailModel {
  final int? number;
  final String? name;
  final String? latinName;
  final int? ayatCount;
  final String? place;
  final String? meaning;
  final String? description;
  final Map<String, String>? audioFull;
  final List<AyatModel>? ayat;
  final SurahModel? nextSurah;
  final SurahModel? prevSurah;

  SurahDetailModel({
    this.number,
    this.name,
    this.latinName,
    this.ayatCount,
    this.place,
    this.meaning,
    this.description,
    this.audioFull,
    this.ayat,
    this.nextSurah,
    this.prevSurah,
  });

  factory SurahDetailModel.fromJson(Map<String, dynamic> json) =>
      SurahDetailModel(
        number: json["nomor"],
        name: json["nama"],
        latinName: json["namaLatin"],
        ayatCount: json["jumlahAyat"],
        place: json["tempatTurun"],
        meaning: json["arti"],
        description: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
        ayat: json["ayat"] == null
            ? []
            : List<AyatModel>.from(
                json["ayat"]!.map((x) => AyatModel.fromJson(x))),
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
        "ayat": ayat == null
            ? []
            : List<dynamic>.from(ayat!.map((x) => x.toJson())),
        "suratSelanjutnya": nextSurah?.toJson(),
        "suratSebelumnya": prevSurah?.toJson(),
      };
}
