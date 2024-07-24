/*
 * *
 *  * surah_bloc.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:22
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:18
 *  
 */

import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/bloc/surah/surah_event.dart';
import 'package:quranku/bloc/surah/surah_state.dart';
import 'package:quranku/common/constants.dart';
import 'package:quranku/data/request.dart';
import 'package:quranku/model/app/singleton_model.dart';
import 'package:quranku/model/interpretation_model.dart';
import 'package:quranku/model/surah_detail_model.dart';
import 'package:quranku/model/surah_model.dart';
import 'package:quranku/tool/helper.dart';

export 'package:quranku/bloc/surah/surah_event.dart';
export 'package:quranku/bloc/surah/surah_state.dart';

class SurahBloc extends Bloc<SurahEvent, SurahState> {
  final Helper _helper = Helper();

  SurahBloc(SurahInitialState super.initialState) {
    on<SurahDataEvent>(_data);
    on<SurahDetailEvent>(_detail);
    on<SurahInterpretationEvent>(_interpretation);
  }

  void _data(SurahDataEvent event, Emitter<SurahState> state) async {
    state(SurahInitialState());
    try {
      Response res = await Request().surah.data();
      List<SurahModel> data = List<SurahModel>.from(
          res.data["data"].map((x) => SurahModel.fromJson(x)));
      SingletonModel.shared.surah.data = data;
      AppLog.print(jsonEncode(data));
      state(const SurahDataSuccessState());
    } catch (e) {
      state(
        SurahDataFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _detail(SurahDetailEvent event, Emitter<SurahState> state) async {
    state(SurahInitialState());
    try {
      Response res = await Request().surah.detail(event.number);
      SurahDetailModel data = SurahDetailModel.fromJson(res.data["data"]);

      int? localIndex = SingletonModel.shared.surah.detail
          .indexWhereOrNull((e) => e.number == data.number);
      if (localIndex != null) {
        SingletonModel.shared.surah.detail[localIndex] = data;
      } else {
        SingletonModel.shared.surah.detail.add(data);
      }

      AppLog.print(jsonEncode(data));
      state(const SurahDetailSuccessState());
    } catch (e) {
      state(
        SurahDetailFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }

  void _interpretation(
      SurahInterpretationEvent event, Emitter<SurahState> state) async {
    state(SurahInitialState());
    try {
      Response res = await Request().surah.interpretation(event.number);
      InterpretationModel data = InterpretationModel.fromJson(res.data["data"]);

      int? localIndex = SingletonModel.shared.surah.interpretation
          .indexWhereOrNull((e) => e.number == data.number);
      if (localIndex != null) {
        SingletonModel.shared.surah.interpretation[localIndex] = data;
      } else {
        SingletonModel.shared.surah.interpretation.add(data);
      }

      AppLog.print(jsonEncode(data));
      state(const SurahInterpretationSuccessState());
    } catch (e) {
      state(
        SurahInterpretationFailedState(_helper.dioErrorHandler(e)),
      );
    }
  }
}
