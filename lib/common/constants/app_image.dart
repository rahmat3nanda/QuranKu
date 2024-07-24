/*
 * *
 *  * app_image.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:42
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 18:04
 *
 */

const _path = "asset/images/";

class AppImage {
  static String quranku = "quranku.png".withImagePath();
  static String qurankuFill = "quranku_fill.png".withImagePath();
}

extension AppImageString on String {
  String withImagePath({bool withPrefix = true}) {
    return "$_path${withPrefix ? "img_" : ""}$this";
  }
}
