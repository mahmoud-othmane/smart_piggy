import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_piggy/src/helpers/dialog_helper.dart';
import 'package:smart_piggy/src/models/chart_model.dart';
import 'package:smart_piggy/src/models/piggy_model.dart';
import 'package:smart_piggy/src/providers/home_provider.dart';
import 'package:smart_piggy/src/services/ai_api.dart';
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

class _HomeScreenState extends State<HomeScreen> with DialogHelper {
  late final HomeProvider _homeProvider;

  @override
  void initState() {
    super.initState();
    _homeProvider = Provider.of<HomeProvider>(context, listen: false);
  }

  bool _loadingResults = false;

  void _onAddRecord(record) {
    setState(() {
      _loadingResults = true;
    });
    AiAPI().transcribeAudio(record).then((model) async {
      final add = await showConfirmationDialog(
        context: context,
        model: model,
      );
      setState(() {
        _loadingResults = false;
      });
      if (add) {
        _homeProvider.addToPiggy(model).catchError((error) {
          debugPrint(error.toString());
        });
      }
    }).catchError((error) {
      debugPrint(error.toString());
      setState(() {
        _loadingResults = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.getWhiteColor(),
      appBar: AppBar(
        backgroundColor: ColorResources.getWhiteColor(),
        toolbarHeight: 120,
        title: const Padding(
          padding: EdgeInsets.only(left: 16, top: 32, right: 16),
          child: SizedBox(
            height: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Hello,",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  "David",
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsetsDirectional.only(end: 8.0),
            child: IconButton(
              onPressed: () {
                if (!_loadingResults) {
                  _homeProvider.clearPiggies();
                }
              },
              icon: const Icon(Icons.delete_outline_rounded),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: [
            CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Consumer<HomeProvider>(
                    builder: (context, provider, child) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          TrackerWidget(
                            data: [
                              ChartData(
                                type: "Income",
                                total: provider.totalIncome,
                                color: Colors.green,
                              ),
                              ChartData(
                                type: "Expenses",
                                total: provider.totalExpenses,
                                color: Colors.red,
                              ),
                            ],
                          ),
                          FutureBuilder<List<PiggyModel>>(
                            key: UniqueKey(),
                            future: provider.getAllData(),
                            builder: (context, snapshot) {
                              if (!snapshot.hasData) {
                                return const CircularProgressIndicator();
                              }
                              return ListViewWidget(
                                models: snapshot.data!,
                              );
                            },
                          )
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
            if (_loadingResults)
              const Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        shape: const CircleBorder(),
        backgroundColor: ColorResources.getLightColor(),
        onPressed: () {},
        child: IgnorePointer(
          ignoring: _loadingResults,
          child: RecordingWidget(
            onRecordDone: _onAddRecord,
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
