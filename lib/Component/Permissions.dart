import 'package:permission_handler/permission_handler.dart';

class Permissions {
  Future<bool> checkPermission() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied || cameraStatus.isRestricted) {
      // Minta izin pengguna
      var result = await Permission.camera.request();
      if (result.isGranted) {
        return true;
      } else {
        return false;
      }
    } else {
      return true;
    }
  }
}
