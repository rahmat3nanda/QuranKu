/*
 * *
 *  * surah_state.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:18
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:17
 *
 */

import 'package:equatable/equatable.dart';
import 'package:quranku/model/response_model.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class SurahInitialState extends SurahState {}

class SurahDataSuccessState extends SurahState {
  const SurahDataSuccessState();
}

class SurahDataFailedState extends SurahState {
  final ResponseModel data;

  const SurahDataFailedState(this.data);
}

class SurahDetailSuccessState extends SurahState {
  const SurahDetailSuccessState();
}

class SurahDetailFailedState extends SurahState {
  final ResponseModel data;

  const SurahDetailFailedState(this.data);
}

class SurahInterpretationSuccessState extends SurahState {
  const SurahInterpretationSuccessState();
}

class SurahInterpretationFailedState extends SurahState {
  final ResponseModel data;

  const SurahInterpretationFailedState(this.data);
}
