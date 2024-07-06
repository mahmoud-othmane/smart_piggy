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
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: entries.length,
      itemBuilder: (BuildContext context, int index) {
        return ListTile(
          leading: Icon(
            entries[index]['leadingIcon'],
          ),
          title: Text(entries[index]['title']),
          subtitle: Text(entries[index]['subtitle']),
          tileColor: ColorResources.getWhiteColor(),
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(entries[index]['cost']),
              Text(entries[index]['date']),
            ],
          ),
          onTap: () {},
        );
      },
      separatorBuilder: (BuildContext context, int index) => const Divider(),
    );
  }
}
