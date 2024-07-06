import 'package:flutter/material.dart';
import 'package:smart_piggy/src/services/ai_api.dart';
import 'package:smart_piggy/src/widgets/list_view.dart';
import 'package:smart_piggy/util/color_resources.dart';

import '../widgets/recording_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorResources.getPrimaryColor(),
        title: Text(widget.title),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[Expanded(child: ListViewWidget())],
        ),
      ),
    );
  }
}
