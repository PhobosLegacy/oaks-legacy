import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oaks_legacy/constants.dart';

class PkmLevelPicker extends StatelessWidget {
  const PkmLevelPicker({
    super.key,
    required this.textController,
    required this.onChange,
    required this.dialogContext,
  });

  final TextEditingController textController;
  final Function() onChange;
  final BuildContext dialogContext;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1D1E33),
      title: const Center(
          child: Text(
        'Level',
        style: TextStyle(
          color: Colors.white,
        ),
      )),
      content: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () {
              if (textController.text != "" && textController.text != "1") {
                textController.text =
                    (int.parse(textController.text) - 1).toString();
              }
            },
          ),
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
              controller: textController,
              autofocus: true,
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(3),
                TextInputFormatter.withFunction((oldValue, newValue) {
                  final int value = int.tryParse(newValue.text) ?? 0;
                  if (value < 1 || value > 100) {
                    return oldValue;
                  }
                  return newValue;
                }),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () {
              if (textController.text != "" && textController.text != "100") {
                textController.text =
                    (int.parse(textController.text) + 1).toString();
              }
            },
          ),
        ],
      ),
      actions: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                child: const Icon(
                  Icons.close,
                  color: Colors.red,
                ),
                onPressed: () {
                  textController.clear();
                  Navigator.pop(dialogContext);
                },
              ),
              TextButton(
                child: const Icon(
                  Icons.question_mark,
                  color: Colors.white,
                ),
                onPressed: () {
                  textController.text = kValueNotFound;
                  onChange();
                  Navigator.pop(dialogContext);
                },
              ),
              TextButton(
                child: const Icon(Icons.check, color: Colors.green),
                onPressed: () {
                  if (textController.text != "") {
                    onChange();
                  }

                  textController.clear();
                  Navigator.pop(dialogContext);
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
