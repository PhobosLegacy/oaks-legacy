import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/base_background.dart';
import 'package:oaks_legacy/components/disclaimer.dart';
import 'package:oaks_legacy/components/pkm_login.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key, this.resetCode});

  final String? resetCode;

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // String? code;

  @override
  Widget build(BuildContext context) {
    // var url = window.location.href;
    // if (url.contains('?code=')) {
    //   code = Uri.parse(url).queryParameters['code'];
    // }

    return Scaffold(
      body: Stack(
        children: [
          const BaseBackground(),
          PkmAccountIcon(
            resetCode: widget.resetCode,
          ),
          const Disclaimer(),
        ],
      ),
    );
  }
}
