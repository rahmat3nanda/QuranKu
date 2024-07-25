/*
 * *
 *  * home_page.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:48
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:48
 *  
 */

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:quranku/bloc/surah/surah_bloc.dart';
import 'package:quranku/common/styles.dart';
import 'package:quranku/model/app/error_model.dart';
import 'package:quranku/model/app/singleton_model.dart';
import 'package:quranku/model/surah_model.dart';
import 'package:quranku/tool/helper.dart';
import 'package:quranku/widget/reload_data_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late SingletonModel _model;
  late SurahBloc _surahBloc;
  late Helper _helper;

  late RefreshController _cRefresh;
  ErrorModel? _error;
  late bool _isLoading;

  @override
  void initState() {
    super.initState();
    _model = SingletonModel.withContext(context);
    _surahBloc = BlocProvider.of<SurahBloc>(context);
    _helper = Helper();
    _cRefresh = RefreshController(initialRefresh: false);
    _isLoading = false;
    _onRefresh(fromCache: true);
  }

  void _onRefresh({bool fromCache = false}) {
    _getData(fromCache: fromCache);
    _cRefresh.refreshCompleted();
  }

  void _getData({bool fromCache = false}) {
    _isLoading = true;
    _error = null;

    if (fromCache && _model.surah.data.isNotEmpty) {
      _isLoading = false;
      return;
    }

    _surahBloc.add(const SurahDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SurahBloc, SurahState>(
      bloc: _surahBloc,
      listener: (c, s) {
        if (s is SurahDataSuccessState) {
          _model = SingletonModel.withContext(context);
          _isLoading = false;
        } else if (s is SurahDataFailedState) {
          _isLoading = false;
          if (_model.surah.data.isNotEmpty) {
            _helper.showToast("Gagal memuat data");
          } else {
            _error = ErrorModel(
              event: const SurahDataEvent(),
              error: s.data.message,
            );
          }
        }
      },
      child: BlocBuilder(
        bloc: _surahBloc,
        builder: (c, s) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: AppColor.primary,
              title: Text(
                "QuranKu",
                style: GoogleFonts.montserrat(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            body: SafeArea(
              child: SmartRefresher(
                primary: true,
                physics: const ClampingScrollPhysics(),
                enablePullDown: true,
                enablePullUp: false,
                header: WaterDropMaterialHeader(
                  backgroundColor: AppColor.primary,
                  color: Colors.white,
                ),
                footer: CustomFooter(
                  builder: (context, status) => Container(),
                ),
                controller: _cRefresh,
                onRefresh: _onRefresh,
                child: _stateView(),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _stateView() {
    if (_isLoading) {
      return Center(
        child: SpinKitWaveSpinner(
          color: AppColor.primaryLight,
          trackColor: AppColor.primary,
          waveColor: AppColor.secondary,
          size: 64,
        ),
      );
    }
    if (_error != null) {
      return Center(
        child: ReloadDataWidget(
          error: "Gagal memuat data.",
          onReload: _onRefresh,
        ),
      );
    }

    return _mainView();
  }

  Widget _mainView() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      itemCount: _model.surah.data.length,
      separatorBuilder: (c, i) => const SizedBox(height: 12),
      itemBuilder: (c, i) {
        SurahModel d = _model.surah.data[i];
        return Card(
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            splashColor: AppColor.primary,
            onTap: () {},
            child: ListView(
              shrinkWrap: true,
              primary: false,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  (d.number ?? 0).toArab(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  d.name ?? "-",
                  textAlign: TextAlign.right,
                ),
                const SizedBox(height: 4),
                Text(d.latinName ?? "-"),
                const SizedBox(height: 4),
                Text("Tempat turun: ${d.place ?? "-"}"),
                const SizedBox(height: 4),
                Text("Arti: ${d.meaning ?? "-"}"),
              ],
            ),
          ),
        );
      },
    );
  }
}
