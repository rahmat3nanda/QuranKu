/*
 * *
 *  * splash_page.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:38
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:38
 *
 */

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:quranku/common/constants.dart';
import 'package:quranku/data/quran_ku_channel.dart';
import 'package:quranku/model/app/singleton_model.dart';
import 'package:quranku/page/home_page.dart';
import 'package:quranku/tool/helper.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  late SingletonModel _model;
  late Helper _helper;

  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _helper = Helper();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _setup();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _setup() async {
    await _controller.forward();
    bool avail = await QuranKuChannel.shared.biometric.isFingerprintAvailable();
    if(avail) {
      bool authed = await QuranKuChannel.shared.biometric.authFingerprint();
      if(!authed) {
        return;
      }
    }
    _helper.moveToPage(_model.context!, page: const HomePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadeTransition(
        opacity: CurvedAnimation(
          parent: _controller,
          curve: Curves.easeOut,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              AppIcon.quranku,
              width: 152,
            ),
            const SizedBox(height: 24, width: double.infinity),
            Text(
              "QuranKu",
              style: GoogleFonts.montserrat(
                fontSize: 32,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
