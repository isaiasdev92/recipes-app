import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityInternetApp {
    static late List<ConnectivityResult> _result;

  static Future<bool> hasConnection() async {
    _result = await Connectivity().checkConnectivity();
    if (_result.contains(ConnectivityResult.mobile)) return true;
    if (_result.contains(ConnectivityResult.wifi)) return true;
    if (_result.contains(ConnectivityResult.ethernet)) return true;
    if (_result.contains(ConnectivityResult.other)) return true;
    if (_result.contains(ConnectivityResult.vpn)) return true;

    return false;
  }
}