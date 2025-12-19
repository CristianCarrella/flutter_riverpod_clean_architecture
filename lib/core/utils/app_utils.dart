import 'package:connectivity_plus/connectivity_plus.dart';

class AppUtils {
  AppUtils._();

  static Future<bool> hasNetworkConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }
}
