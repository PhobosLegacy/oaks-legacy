import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
                FilteringTextInputFormatter.digitsOnly
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
                child: Icon(Icons.check, color: Colors.green),
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
