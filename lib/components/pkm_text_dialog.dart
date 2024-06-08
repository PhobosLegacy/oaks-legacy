import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PkmTextEditDialog extends StatelessWidget {
  const PkmTextEditDialog({
    super.key,
    required this.title,
    required this.textController,
    required this.onChange,
  });

  final String title;
  final TextEditingController textController;
  final Function() onChange;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1D1E33),
      title: Center(
          child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
        ),
      )),
      content: Row(
        children: [
          Expanded(
            child: TextField(
                style: const TextStyle(color: Colors.white, fontSize: 20),
                textAlign: TextAlign.center,
                controller: textController,
                autofocus: true,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(50),
                ]),
          ),
        ],
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  if (textController.text != "") {
                    onChange();
                  }

                  textController.clear();
                  Navigator.pop(context);
                },
              ),
              TextButton(
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  textController.clear();
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class PkmTextDialog extends StatelessWidget {
  const PkmTextDialog({
    super.key,
    required this.title,
    required this.content,
    required this.onConfirm,
    this.isWarning = false,
  });

  final String title;
  final String content;
  final Function() onConfirm;
  final bool isWarning;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1D1E33),
      title: Center(
        child: Text(title,
            style: const TextStyle(
              color: Colors.amber,
            )),
      ),
      content: Row(
        children: [
          Expanded(
            child: Text(
              content,
              style: const TextStyle(color: Colors.white, fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  onConfirm();

                  Navigator.pop(context);
                },
              ),
              if (!isWarning)
                TextButton(
                  child: const Icon(
                    Icons.close,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
