import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:smart_piggy/src/providers/home_provider.dart';
import 'package:smart_piggy/src/screens/home_screen.dart';

import 'di_container.dart' as di;
import 'util/color_resources.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Color(0xFF0075b0),
    ),
  );
  await di.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => di.sl<HomeProvider>(),
        ),
      ],
      child: const MyApp(), // Make sure to add your main app widget here
    ),
  );
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
          backgroundColor: ColorResources.getPrimaryColor(),
        ),
      ),
      home: const HomeScreen(title: 'Home Screen'),
    );
  }
}
