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
    // Decode Base64 to bytes
    final List<int> bytes = base64Decode(base64String);

    // Use app-specific documents directory to avoid external storage permissions
    final Directory appDocsDir = await getApplicationDocumentsDirectory();
    final String filePath = '${appDocsDir.path}/$fileName';
    final File file = File(filePath);

    await file.writeAsBytes(bytes);
    print('✅ File saved at: $filePath');

    openPdfFile(filePath);
  } catch (e) {
    print('❌ Error saving Base64 to file: $e');
    DisplayUtils.showToast(context, 'Failed to save file');
  }
}

Future<void> openUrlInBrowser(String url) async {
  final Uri uri = Uri.parse(url);
  await launchUrl(uri, mode: LaunchMode.externalApplication);
}

Future<void> openPdfFile(String filePath) async {
  // Files in app-specific storage do not require runtime storage permissions
  final result = await OpenFile.open(filePath);
  print('OpenFile result: ${result.type} ${result.message}');
}
