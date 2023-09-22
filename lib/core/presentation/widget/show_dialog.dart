import 'package:flutter/material.dart';

/// general themed messages dialog used in the app
showAppDialog(
  String message,
  BuildContext context, {
  bool canBePopped = true,
  Function? acceptFunction,
  Widget? optionalWidget,
  String? acceptMessage,
  String? image,
  String? title,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return WillPopScope(
        onWillPop: () async {
          return canBePopped;
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Column(
                    children: [
                      if (title != null)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          child: Text(
                            title,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      if (message.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 20,
                          ),
                          child: Text(
                            message,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(context).size.height * 0.4),
                        child: optionalWidget ?? Container(height: 0),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButton(
                              onPressed: () {
                                if (acceptFunction == null) {
                                  if (canBePopped) {
                                    Navigator.pop(context);
                                  }
                                } else {
                                  acceptFunction();
                                }
                              },
                              child: const Text('accept'),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
    barrierDismissible: canBePopped,
  );
}
