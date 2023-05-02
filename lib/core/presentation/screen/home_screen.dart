import 'package:flutter/material.dart';

import '../../application/service/export_localization_files.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localizations Exporter'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () => exportLocalizationFiles(context),
          child: const Padding(
            padding: EdgeInsets.all(18.0),
            child: Text('Select File'),
          ),
        ),
      ),
    );
  }
}
