import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:excel_json_converter/core/dto/selected_file.dart';
import 'package:flutter/material.dart';
import 'package:desktop_drop/desktop_drop.dart';

import '../../application/service/export_dropped_files.dart';

class DropFileContainer extends StatefulWidget {
  const DropFileContainer({super.key});

  @override
  State<DropFileContainer> createState() => _DropFileContainerState();
}

class _DropFileContainerState extends State<DropFileContainer> {
  final List<SelectedFile> droppedFiles = [];

  bool _dragging = false;
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (detail) async {
        for (var element in detail.files) {
          SelectedFile bytes = SelectedFile(
              name: element.name,
              fileBytes: File(element.path).readAsBytesSync());
          droppedFiles.add(bytes);
        }
        setState(() {
          loading = true;
        });
        // ignore: use_build_context_synchronously
        await exportMultiAppLocalizationFiles(
          context,
          filesList: droppedFiles,
        );

        setState(() {
          loading = false;
        });
        droppedFiles.clear();
      },
      onDragEntered: (detail) {
        setState(() {
          _dragging = true;
        });
      },
      onDragExited: (detail) {
        setState(() {
          _dragging = false;
        });
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        padding: const EdgeInsets.all(6),
        dashPattern: const [6],
        child: Container(
          height: 200,
          width: 200,
          color: _dragging ? Colors.blue.withOpacity(0.4) : Colors.transparent,
          child: !loading
              ? const Center(child: Text("Drop here"))
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }
}
