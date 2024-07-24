/*
 * *
 *  * observer.dart - quran_ku
 *  * Created by Rahmat Trinanda (rahmat3nanda@gmail.com) on 07/25/2024, 00:15
 *  * Copyright (c) 2024 . All rights reserved.
 *  * Last modified 07/25/2024, 00:15
 *
 */

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quranku/common/constants.dart';

class Observer extends BlocObserver {
  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    AppLog.print("$bloc $event");
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    AppLog.print(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    AppLog.print("$bloc $error");
    AppLog.print(stackTrace.toString());
    super.onError(bloc, error, stackTrace);
  }
}
