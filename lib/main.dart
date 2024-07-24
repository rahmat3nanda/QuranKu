/*
 * *
 *  * main.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:40
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/24/2024, 23:20
 *
 */

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quranku/app.dart';
import 'package:quranku/common/configs.dart';
import 'package:quranku/common/constants.dart';
import 'package:quranku/model/app/app_version_model.dart';
import 'package:quranku/model/app/scheme_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.onError = (errorDetails) {
    AppLog.print(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    AppLog.print(error);
    return true;
  };
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  AppLog.debugMode = false;
  AppConfig.shared.initialize(
    scheme: AppScheme.prod,
    baseUrlApi: "https://equran.id/api/v2/",
    version: AppVersionModel.empty(),
  );
  runApp(const App());
}
