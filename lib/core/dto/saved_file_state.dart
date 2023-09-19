enum FileState { success, error, none }

class SavedFileState {
  SavedFileState(
      {required this.fileState, this.savedDirectory, this.errorMessage});
  final String? savedDirectory;
  final String? errorMessage;
  final FileState fileState;
}
