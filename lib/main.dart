import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:smart_piggy/src/models/chart_model.dart';
import 'package:smart_piggy/src/widgets/tracker_widget.dart';

import 'util/color_resources.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0075b0),
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Smart Piggy',
      theme: ThemeData(
          fontFamily: 'Rubik',
          primaryColor: ColorResources.getPrimaryColor(),
          // canvasColor: ColorResources.getFlameColor(),
          bottomSheetTheme: BottomSheetThemeData(
              backgroundColor: ColorResources.getPrimaryColor())),
      home: TrackerWidget(data: [
        ChartData('spent', 3631, ColorResources.getFlameColor()),
        ChartData('income', 8490, ColorResources.getAsparagusColor()),
      ]),
    );
  }
}
