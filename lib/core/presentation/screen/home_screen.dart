import 'package:excel_json_converter/core/application/service/pick_localization_file.dart';
import 'package:flutter/material.dart';

import '../widget/drop_file_container.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Localizations Exporter'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'Drag your files here',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const DropFileContainer(),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'OR',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: () => pickLocalizationsFile(context),
              child: const Padding(
                padding: EdgeInsets.all(18.0),
                child: Text('Select a file'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
