import 'package:flutter/material.dart';

class AboutAppButton extends StatelessWidget {
  const AboutAppButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => showAboutDialog(
        context: context,
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
        ],
      ),
      icon: const Icon(Icons.help_outline),
    );
  }
}
