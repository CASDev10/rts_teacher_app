import '../../../../../core/failures/base_failures/base_failure.dart';
import '../../models/student_diary_list_response.dart';

enum AddDiaryStatus {
  none,
  loading,
  success,
  failure,
}

class AddDiaryState {
  final AddDiaryStatus addDiaryStatus;
  final BaseFailure failure;
  final List<DiaryStudentModel> studentList;

  AddDiaryState({
    required this.addDiaryStatus,
    required this.failure,
    required this.studentList,
  });

  factory AddDiaryState.initial() {
    return AddDiaryState(
      addDiaryStatus: AddDiaryStatus.none,
      failure: const BaseFailure(),
      studentList: [],
    );
  }

  AddDiaryState copyWith({
    AddDiaryStatus? addDiaryStatus,
    BaseFailure? failure,
    List<DiaryStudentModel>? studentList,
  }) {
    return AddDiaryState(
      addDiaryStatus: addDiaryStatus ?? this.addDiaryStatus,
      failure: failure ?? this.failure,
      studentList: studentList ?? this.studentList,
    );
  }
}
