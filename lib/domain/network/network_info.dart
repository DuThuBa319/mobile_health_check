import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:injectable/injectable.dart';
part 'network_info.impl.dart';
abstract class NetworkInfo {
  Future<bool> get isConnected ;

}

