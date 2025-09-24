import '../models/parent_files_response.dart';

enum ParentFilesStatus {
  none,
  loading,
  loadMore,
  success,
  failure,
}

class ParentFilesState {
  final ParentFilesStatus status;
  final String message;
  final List<ParentsFileList> parentFiles;

  ParentFilesState({
    required this.status,
    required this.message,
    required this.parentFiles,
  });

  factory ParentFilesState.initial() {
    return ParentFilesState(
        status: ParentFilesStatus.none, message: '', parentFiles: []);
  }

  ParentFilesState copyWith(
      {ParentFilesStatus? status,
      String? message,
      List<ParentsFileList>? parentFiles}) {
    return ParentFilesState(
      status: status ?? this.status,
      message: message ?? this.message,
      parentFiles: parentFiles ?? this.parentFiles,
    );
  }
}
