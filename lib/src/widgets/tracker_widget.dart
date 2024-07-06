import 'package:flutter/material.dart';
import 'package:smart_piggy/src/models/chart_model.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TrackerWidget extends StatelessWidget {
  const TrackerWidget({super.key, required this.data});

  final List<ChartData> data;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.sizeOf(context).width;
    final double height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16 * 2),
      decoration: BoxDecoration(
        color: const Color(0xffF8F8FA),
        borderRadius: BorderRadius.circular(25),
      ),
      width: width,
      height: height * 0.25,
      child: //Money type section
          Row(
        children: [
          Expanded(
            child: _buildTrackerLeftSide(),
          ),
          Expanded(child: _buildTrackerRightSide(data)),
        ],
      ),
    );
  }

  SfCircularChart _buildTrackerRightSide(List<ChartData> data) {
    return SfCircularChart(
      margin: EdgeInsets.zero,
      series: [
        DoughnutSeries<ChartData, String>(
          explodeIndex: 0,
          dataSource: data,
          xValueMapper: (ChartData data, _) => data.type,
          yValueMapper: (ChartData data, _) => data.total,
          pointColorMapper: (ChartData data, _) => data.color,
          name: 'Tracker',
          radius: '100%',
        )
      ],
    );
  }

  Column _buildTrackerLeftSide() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _moneySection(
          color: data[0].color,
          label: data[0].type,
          value: data[0].total,
        ),
        _moneySection(
          color: data[1].color,
          label: data[1].type,
          value: data[1].total,
        ),
      ],
    );
  }

  Column _moneySection({
    Color color = Colors.green,
    String label = 'Income',
    double value = 0.0,
  }) {
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
                color: color,
                borderRadius: BorderRadius.circular(2),
              ),
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
            '\$${value.toStringAsFixed(2)}',
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w400, fontSize: 26),
          ),
        ),
      ],
    );
  }
}
