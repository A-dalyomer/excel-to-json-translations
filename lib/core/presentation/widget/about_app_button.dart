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
        optionalWidgetHeight: MediaQuery.of(context).size.height * 0.7,
        optionalWidget: Scrollbar(
          controller: scrollController,
          thumbVisibility: true,
          child: SingleChildScrollView(
            controller: scrollController,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
              child: Column(
                children: [
                  const Text(
                    'This app was made to make the localizations exporting much easier.\n\nAll you need is an EXCEL file of your app localizations.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse(
                          'https://docs.google.com/spreadsheets/d/1H0lU0J41BWH0inYkea5jFvVGdDE4GwmyxT1UuoLtQsE/edit?usp=sharing'),
                    ),
                    icon: const Icon(Icons.description),
                    label: const Text('Example file'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'File Format Requirements',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 16),
                        _RequirementItem('1. A Column for each language'),
                        _RequirementItem(
                            '2. First column reserved for localization keys'),
                        _RequirementItem(
                            '3. First column must have a value called "language_code" and the values on its row must be the corresponding language code (ex: en, ar, de...)'),
                        _RequirementItem(
                            '4. For proper dart code generation, stylize your keys with snake_case'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "This application is distributed as is.\nWe are not responsible for any data loss or errors.",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "App developer: Ahmad Daly Omer",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 24),
                  const Divider(),
                  const SizedBox(height: 16),
                  const Text(
                    "This app is open source.\nYou can find the source code and contribute to it.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.blueGrey, height: 1.5),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => launchUrl(
                      Uri.parse(
                        'https://github.com/A-dalyomer/excel-to-json-translations.git',
                      ),
                    ),
                    icon: const Icon(Icons.code),
                    label: const Text('Github Repo'),
                  ),
                  const SizedBox(height: 16),
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

class _RequirementItem extends StatelessWidget {
  const _RequirementItem(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6.0),
            child: Icon(Icons.circle, size: 8, color: Colors.blue),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontSize: 15, height: 1.4, color: Colors.black87),
            ),
          ),
        ],
      ),
    );
  }
}
