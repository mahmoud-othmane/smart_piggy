import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrackerWidget extends StatelessWidget {
  const TrackerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    final data = [
      _ChartData('spent', 3631, Colors.red),
      _ChartData('income', 8490, Colors.green),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.2,
            ),
            Container(
              margin: EdgeInsets.all(16),
              padding: EdgeInsets.all(16 * 2),
              decoration: BoxDecoration(
                color: Color(0xffF8F8FA),
                borderRadius: BorderRadius.circular(25),
              ),
              width: width,
              height: height * 0.25,
              child: //Money type section
                  Row(
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _moneySection(),
                        _moneySection(color: Colors.red, label: 'Spent'),
                      ],
                    ),
                  ),
                  Expanded(
                      child: SfCircularChart(
                    margin: EdgeInsets.zero,
                    series: [
                      DoughnutSeries<_ChartData, String>(
                        explodeIndex: 0,
                        dataSource: data,
                        xValueMapper: (_ChartData data, _) => data.x,
                        yValueMapper: (_ChartData data, _) => data.y,
                        pointColorMapper: (_ChartData data, _) => data.color,
                        name: 'Tracker',
                        radius: '100%',
                      )
                    ],
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column _moneySection(
      {Color color = Colors.green,
      String label = 'Income',
      String value = '0000'}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Label
        Row(
          children: [
            Container(
              width: 5,
              height: 15,
              decoration: BoxDecoration(
                  color: color, borderRadius: BorderRadius.circular(2)),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              label,
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
        //   value
        Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            '\$$value',
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 30),
          ),
        ),
      ],
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
