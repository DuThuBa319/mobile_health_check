part of 'network_info.dart';

@Injectable(
  as: NetworkInfo,
)
class NetworkInfoImpl extends NetworkInfo {
  final Connectivity _connectivity = injector<Connectivity>();
  NetworkInfoImpl();
  @override
  Future<bool> get isConnected async {
    final connectResult = await _connectivity.checkConnectivity();

    if (connectResult == ConnectivityResult.mobile ||
        connectResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }
}
