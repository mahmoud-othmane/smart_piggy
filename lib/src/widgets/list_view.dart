import 'package:flutter/material.dart';
import 'package:smart_piggy/util/color_resources.dart';

class ListViewWidget extends StatefulWidget {
  const ListViewWidget({
    super.key,
  });

  @override
  State<ListViewWidget> createState() => _ListViewWidgetState();
}

class _ListViewWidgetState extends State<ListViewWidget> {
  @override
  void initState() {
    super.initState();
  }

  final List<dynamic> entries = [
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Food',
      'subtitle': 'Pizza',
      'cost': '-\$12',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Coffee',
      'cost': '-\$5',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Fresh Orange',
      'cost': '-\$8',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Food',
      'subtitle': 'Pizza',
      'cost': '-\$12',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Coffee',
      'cost': '-\$5',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Fresh Orange',
      'cost': '-\$8',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Food',
      'subtitle': 'Pizza',
      'cost': '-\$12',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Coffee',
      'cost': '-\$5',
      'date': 'Mar 07, 2023'
    },
    {
      'leadingIcon': Icons.arrow_outward,
      'title': 'Drink',
      'subtitle': 'Fresh Orange',
      'cost': '-\$8',
      'date': 'Mar 07, 2023'
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<Widget> children = entries
        .map((entry) => ListTile(
              leading: Icon(
                entry['leadingIcon'],
              ),
              title: Text(entry['title']),
              subtitle: Text(entry['subtitle']),
              tileColor: ColorResources.getWhiteColor(),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(entry['cost']),
                  Text(entry['date']),
                ],
              ),
              onTap: () {},
            ))
        .expand((element) => [element, const Divider()])
        .toList()
      ..removeLast();
    return Column(
      children: children,
    );
  }
}
