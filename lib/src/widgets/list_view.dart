import 'package:flutter/material.dart';
import 'package:smart_piggy/util/color_resources.dart';

import '../models/piggy_model.dart';

class ListViewWidget extends StatefulWidget {
  final List<PiggyModel> models;

  const ListViewWidget({
    super.key,
    required this.models,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.models.isEmpty) {
      return const SizedBox.shrink();
    }
    List<Widget> children = widget.models
        .map((entry) => ListTile(
              leading: Icon(
                entry.sign == "+" ? Icons.arrow_outward : Icons.arrow_downward,
                color: entry.sign == "+"
                    ? ColorResources.getPrimaryColor()
                    : ColorResources.getFlameColor(),
              ),
              title: Text(entry.item),
              subtitle: Text(entry.sign == "+" ? "Income" : "Expense"),
              tileColor: ColorResources.getWhiteColor(),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("${entry.amount.toStringAsFixed(2)}\$"),
                  Text(
                    "${entry.createdAt.year}/${entry.createdAt.month}/${entry.createdAt.day} - ${entry.createdAt.hour}:${entry.createdAt.minute}",
                  ),
                ],
              ),
              onTap: () {},
            ))
        .expand((element) => [element, const Divider()])
        .toList()
      ..removeLast();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: children.reversed.toList(),
    );
  }
}
