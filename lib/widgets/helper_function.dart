import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:rts/module/kgs_teacher_module/kgs_teacher_auth/repo/auth_repository.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rts/utils/display/display_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import '../core/di/service_locator.dart';

AuthRepository _authRepository = sl<AuthRepository>();

returnSchoolId() {
  return _authRepository.user.schoolId;
}

Future<void> checkCameraPermission() async {
  var status = await Permission.camera.status;
  if (!status.isGranted) {
    await Permission.camera.request();
  }
}

Future<void> saveBase64ToFile2(
  BuildContext context, {

  required String base64String,
  required String fileName,
}) async {
  try {
    if (Platform.isAndroid) {
      var status = await Permission.manageExternalStorage.status;
      if (!status.isGranted) {
        status = await Permission.manageExternalStorage.request();
        if (!status.isGranted) {
          DisplayUtils.showToast(
            context,
            'Storage permission is required to save files.',
          );
          return;
        }
      }
    }

    // Decode Base64 to bytes
    List<int> bytes = base64Decode(base64String);

    // Get Downloads directory
    Directory? downloadsDir = await getDownloadsDirectory();
    if (downloadsDir == null) {
      print('Downloads directory not available.');
      return;
    }

    // Construct full file path
    String filePath = '${downloadsDir.path}/$fileName';
    File file = File(filePath);

    // Save file
    await file.writeAsBytes(bytes);
    print('✅ File saved at: $filePath');

    openPdfFile(filePath);
  } catch (e) {
    print('❌ Error saving Base64 to file: $e');
  }
}

enum ResultType { done, fileNotFound, noAppToOpen, permissionDenied, error }

Future<void> openUrlInBrowser(String url) async {
  final Uri uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> openPdfFile(String filePath) async {
  // Check for storage permission before proceeding
  PermissionStatus permissionStatus = await Permission.storage.request();

  // If permission is not granted, show an alert or handle it accordingly
  if (permissionStatus.isGranted) {
    // Permission is granted, now attempt to open the file
    final result = await OpenFile.open(filePath);

    // Optionally handle the result, such as showing a message if the file can't be opened
    if (result.type == ResultType.error) {
      print('Error opening file: ${result.message}');
    } else {
      print('File opened successfully');
    }
  } else {
    // If permission is denied, show a message or prompt user to allow permission
    print(
      'Storage permission denied. Please grant permission to access the file.',
    );
  }
}
