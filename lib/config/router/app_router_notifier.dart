

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/auth/presentation/presentation.dart';
import 'package:todo_app/auth/state/auth_state.dart';

final goRouterNotifierProvider = Provider((ref){

  final authNotifier = ref.read(loginAuthProvider.notifier);
  return GoRouterNotifier(authNotifier);

});

class GoRouterNotifier extends ChangeNotifier {

  AuthStatus _authStatus = AuthStatus.checking;

  final LoginAuthNotifier _authNotifier;

  // Constructor that takes an AuthNotifier instance
  // to notify changes in authentication status
  GoRouterNotifier(this._authNotifier) {
    _authNotifier.addListener((state) {
      authStatus = state.authStatus;
    });
  }

  AuthStatus get authStatus => _authStatus;

  set authStatus (AuthStatus status) {
    _authStatus = status;
    notifyListeners();
  }


}