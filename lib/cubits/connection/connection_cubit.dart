// import 'dart:async';
// import 'dart:core';
// import 'dart:developer' as developer;

// import 'package:connectivity_plus/connectivity_plus.dart';
// import 'package:equatable/equatable.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// part 'connection_state.dart';

// class ConnectionCubit extends Cubit<ConnectionCubitState> {
//   final Connectivity _connectivity = Connectivity();

//   ConnectionCubit() : super(const ConnectionCubitState()) {
//     initConnectivity();

//     _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
//   }

//   // Platform messages are asynchronous, so we initialize in an async method.
//   Future<void> initConnectivity() async {
//     late List<ConnectivityResult> result;
//     // Platform messages may fail, so we use a try/catch PlatformException.
//     try {
//       result = await _connectivity.checkConnectivity();
//     } on PlatformException catch (e) {
//       developer.log('Couldn\'t check connectivity status', error: e);
//       return;
//     }

//     // If the widget was removed from the tree while the asynchronous platform
//     // message was in flight, we want to discard the reply rather than calling
//     // setState to update our non-existent appearance.
//     // if (!mounted) {
//     //   return Future.value(null);
//     // }

//     return _updateConnectionStatus(result);
//   }

//   Future<void> _updateConnectionStatus(List<ConnectivityResult> result) async {
//     emit(ConnectionCubitState(connectionStatus: result));
//     print(result);
//   }
// }
