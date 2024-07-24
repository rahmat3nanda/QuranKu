/*
 * *
 *  * surah_event.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:20
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/13/2024, 19:37
 *  
 */

import 'package:equatable/equatable.dart';

abstract class SurahEvent extends Equatable {
  const SurahEvent();

  @override
  List<Object> get props => [];
}

class SurahDataEvent extends SurahEvent {
  const SurahDataEvent();

  @override
  String toString() {
    return "SurahDataEvent{}";
  }
}

class SurahDetailEvent extends SurahEvent {
  final int number;

  const SurahDetailEvent(this.number);

  @override
  String toString() {
    return 'SurahDetailEvent{number: $number}';
  }
}

class SurahInterpretationEvent extends SurahEvent {
  final int number;

  const SurahInterpretationEvent(this.number);

  @override
  String toString() {
    return 'SurahInterpretationEvent{number: $number}';
  }
}
