import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';
class LocalAuthApi {
  static final _auth = LocalAuthentication();
  static Future<bool> hasBiometrics() async {
    try {
      return await _auth.canCheckBiometrics;
    } on PlatformException catch (e) {
       return false;
    }
  }
  static Future<List<BiometricType>> getBiometrics() async {
    try {
      return await _auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      return <BiometricType>[];
    }
  }
  static Future<bool> authenticate() async {
      final isAvailable = await hasBiometrics();
      if (!isAvailable) return false;
    try{
      return await _auth.authenticate(
        localizedReason: 'Scan Fingerprint to Authenticate',
        biometricOnly: true,
        useErrorDialogs: true,//when give here false it not show the error message that "No Biometrics enrolled on this device"
        stickyAuth: true,//when we give here false it not show finger scan pop when we open app from background.
      );
    } on PlatformException catch (e) {
      print(e);
      return false;
    }
  }
}