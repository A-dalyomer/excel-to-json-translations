import 'package:excel_json_converter/core/presentation/widget/show_dialog.dart';
import 'package:flutter/material.dart';

class AboutAppButton extends StatelessWidget {
  const AboutAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return IconButton(
      onPressed: () => showAppDialog(
        'Localizations exporter app',
        context,
        optionalWidgetHeight: MediaQuery.of(context).size.height * 0.6,
        optionalWidget: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    'This app was made to make the localizations exporting much easier',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'All you need is an EXCEL file of your app localizations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    'The file must have the following format:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  Text.rich(
                    TextSpan(children: [
                      TextSpan(text: '1 - A Column for each language\n'),
                      TextSpan(
                        text:
                            '2 - The first column is reserved for localization keys\n',
                      ),
                      TextSpan(
                        text:
                            '3 - the first column must have a value called "language_code" and the values on its row must be the corresponding language code ex: en,ar,de,...\n',
                      ),
                    ]),
                    style: TextStyle(
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.start,
                  ),
                  Text(
                    "This application is distributed as is\nWe are not responsible for any data loss or errors\nmade by magenus E.K company\nApp developer ahmad daly omer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      icon: const Icon(Icons.help_outline),
    );
  }
}
