
import 'package:flutter/material.dart';
import 'package:rts/utils/display/dialogs/widgets/success_dialog.dart';

sealed class Dialogs {
  Dialogs_();

  static void showCongratulationsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => CongratulationsDialog(
        title: "Submission Successful",
        message: "Your details have been submitted successfully. The admin will review your account, which may take some time. You’ll be able to log in once approved",
      ),
    );
  }
}