import 'package:get_it/get_it.dart';
import 'package:smart_piggy/src/providers/home_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Provider
  sl.registerFactory(() => HomeProvider());
}
