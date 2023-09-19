import 'dart:typed_data';

class SelectedFile {
  SelectedFile({required this.name, required this.fileBytes});
  final String name;
  final Uint8List? fileBytes;
}
