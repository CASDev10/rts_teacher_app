import 'package:flutter/material.dart';

import '../../../../core/di/service_locator.dart';
import '../../kgs_teacher_auth/repo/auth_repository.dart';

class AllInfoDialogue extends StatelessWidget {
  AllInfoDialogue({super.key});
  final AuthRepository _repository = sl<AuthRepository>();
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _detailRow("Full name", _repository.user.fullName),
            Divider(),
            _detailRow("School name", _repository.user.schoolName ?? ""),
            Divider(),
            _detailRow("Job Status", _repository.user.jobStatus ?? ""),
            Divider(),
            _detailRow("Current Salary",
                _repository.user.currentSalary.toString() ?? ""),
            Divider(),
            _detailRow("Mobile #", _repository.user.userMobile ?? ""),
          ],
        ),
      ),
    );
  }

  Widget _detailRow(String key, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            key,
            style: TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 12.0),
          ),
        ),
        SizedBox(width: 8.0), // Space between the key and the value
        Expanded(
          flex: 2,
          child: Text(
            value,
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.normal,
                fontSize: 12.0),
          ),
        ),
      ],
    );
  }
}
