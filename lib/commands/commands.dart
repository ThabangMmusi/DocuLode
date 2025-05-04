import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../core/data/models/src/app_model.dart';
import '../services/firebase/firebase_service.dart';

BuildContext? _mainContext;
BuildContext get mainContext => _mainContext!;
bool get hasContext => _mainContext != null;

/// Someone needs to call this so our Commands can access models and services.
void setContext(BuildContext c) {
  _mainContext = c;
}

class BaseAppCommand {
  /// Provide quick lookups for the main Models and Services in the App.
  T getProvided<T>() {
    assert(_mainContext != null,
        "You must call `setContext(BuildContext)` method before calling Commands.");
    return _mainContext!.read<T>();
  }

  AppModel get appModel => _mainContext!.read<AppModel>();
  FirebaseService get firebase => _mainContext!.read<FirebaseService>();
  // CloudStorageService get cloudStorage =>
  //     _mainContext!.read<CloudStorageService>();
}
