import 'package:flutter/material.dart';
import 'package:smart_piggy/src/models/chart_model.dart';
import 'package:smart_piggy/src/widgets/list_view.dart';
import 'package:smart_piggy/src/widgets/tracker_widget.dart';
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
      backgroundColor: ColorResources.getWhiteColor(),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPersistentHeader(delegate: _TitleDelegate()),
            SliverFillRemaining(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TrackerWidget(
                      data: [
                        ChartData(
                          type: "Income",
                          total: 2000,
                          color: Colors.green,
                        ),
                        ChartData(
                          type: "Expenses",
                          total: 1000,
                          color: Colors.red,
                        ),
                      ],
                    ),
                    const ListViewWidget()
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorResources.getLightColor(),
        onPressed: () {},
        child: RecordingWidget(
          onRecordDone: (record) {},
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}

class _TitleDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            "Hello,",
            style: TextStyle(
              fontSize: 30,
            ),
          ),
          Text(
            "David",
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 100;

  @override
  double get minExtent => 100;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      false;
}
