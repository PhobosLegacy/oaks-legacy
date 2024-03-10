import 'package:flutter/material.dart';

class PkmNamePicker extends StatelessWidget {
  const PkmNamePicker({
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
        'Add your OT',
        style: TextStyle(
          color: Colors.white,
        ),
      )),
      content: Row(
        children: [
          Expanded(
            child: TextField(
              style: const TextStyle(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
              controller: textController,
              autofocus: true,
              // keyboardType: TextInputType.number,
              // inputFormatters: <TextInputFormatter>[
              //   FilteringTextInputFormatter.digitsOnly
              // ],
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
