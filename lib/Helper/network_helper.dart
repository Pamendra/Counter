import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:counter/Bloc/NetworkBloc/network_bloc.dart';
import 'package:counter/Bloc/NetworkBloc/network_event.dart';



class NetworkHelper {
  static void observeNetwork() {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        NetworkBloc().add(NetworkNotify());
      } else {
        NetworkBloc().add(NetworkNotify(isConnected: true));
      }
    });
  }
}
