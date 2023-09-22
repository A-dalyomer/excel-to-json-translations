import 'package:excel_json_converter/core/presentation/widget/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

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
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    'This app was made to make the localizations exporting much easier',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'All you need is an EXCEL file of your app localizations',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    'The file must have the following format:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text.rich(
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
                  const Text(
                    "This application is distributed as is\nWe are not responsible for any data loss or errors\nmade by magenus E.K company\nApp developer ahmad daly omer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Text(
                    "Consider supporting our other apps by rating them on the play store, You can check our android apps",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blueGrey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  TextButton(
                      onPressed: () => launchUrl(
                            Uri.parse(
                                'https://play.google.com/store/apps/developer?id=Win+real+money+by+play+games'),
                          ),
                      child: Text('here')),
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
