import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:local_auth/local_auth.dart';

@singleton
class BiometricAuthentication {
  static final _localAuth = LocalAuthentication();

  Future<bool> checkBiometrics() async {
    bool canCheckBiometrics;
    try {
      canCheckBiometrics = await _localAuth.canCheckBiometrics;
    } catch (e) {
      return false;
    }
    if (!canCheckBiometrics) {
      // Biometrics not available on this device
      return false;
    }
    List<BiometricType> availableBiometrics =
        await _localAuth.getAvailableBiometrics();

    debugPrint('Available biometrics: $availableBiometrics');
    return true;
  }

  Future<bool> authenticate() async {
    try {
      bool authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access the app',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: false,
          useErrorDialogs: true,
        ),
      );
      return authenticated;
    } catch (e) {
      return false;
    }
  }
}
