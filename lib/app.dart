/*
 * *
 *  * app.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/24/2024, 23:49
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/24/2024, 23:49
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:quranku/bloc/surah/surah_bloc.dart';
import 'package:quranku/common/configs.dart';
import 'package:quranku/common/constants.dart';
import 'package:quranku/common/styles.dart';
import 'package:quranku/model/app/app_version_model.dart';
import 'package:quranku/model/app/scheme_model.dart';
import 'package:quranku/page/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _getInfo();
  }

  void _getInfo() {
    PackageInfo.fromPlatform().then((i) {
      setState(() {
        AppConfig.shared.version = AppVersionModel(
          name: i.version,
          number: int.tryParse(i.buildNumber) ?? 1,
        );
      });
    }).catchError((e) {
      _getInfo();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SurahBloc>(
          create: (BuildContext context) => SurahBloc(SurahInitialState()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Stack(
          children: [
            AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle.light,
              child: MaterialApp(
                localizationsDelegates: AppLocale.shared.delegates,
                supportedLocales: AppLocale.shared.supports,
                debugShowCheckedModeBanner: false,
                title: AppString.appName,
                theme: AppTheme.main(context),
                home: const SplashPage(),
              ),
            ),
            if (AppConfig.shared.scheme == AppScheme.dev)
              IgnorePointer(
                ignoring: true,
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  body: Opacity(
                    opacity: .3,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(width: double.infinity),
                        Text(
                          "DEV\n${AppConfig.shared.version.toString()}",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 32.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
