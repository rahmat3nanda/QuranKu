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
                home: const MyHomePage(title: "title"),
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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
