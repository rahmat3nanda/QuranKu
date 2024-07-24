/*
 * *
 *  * surah_model.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:53
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/24/2024, 23:53
 *
 */

class SurahModel {
  final int? number;
  final String? name;
  final String? latinName;
  final int? ayatCount;
  final String? place;
  final String? meaning;
  final String? description;
  final Map<String, String>? audioFull;

  SurahModel({
    this.number,
    this.name,
    this.latinName,
    this.ayatCount,
    this.place,
    this.meaning,
    this.description,
    this.audioFull,
  });

  factory SurahModel.fromJson(Map<String, dynamic> json) => SurahModel(
        number: json["nomor"],
        name: json["nama"],
        latinName: json["namaLatin"],
        ayatCount: json["jumlahAyat"],
        place: json["tempatTurun"],
        meaning: json["arti"],
        description: json["deskripsi"],
        audioFull: Map.from(json["audioFull"]!)
            .map((k, v) => MapEntry<String, String>(k, v)),
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
      };
}
