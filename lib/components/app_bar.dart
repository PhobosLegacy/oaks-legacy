import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_login.dart';
import 'package:oaks_legacy/components/pkm_warning_icon.dart';

class AppBarBase extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(56);

  const AppBarBase({
    required this.title,
    required this.actions,
    this.color,
    super.key,
  });

  final Widget title;
  final List<Widget>? actions;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      actions: actions,
      centerTitle: true,
      iconTheme: const IconThemeData(
        color: Colors.white, //change your color here
      ),
      title: SizedBox(
        width: 200,
        child: Row(
          children: [
            if (!isUserLogged) const PkmWarningIcon(),
            title,
          ],
        ),
      ),
      backgroundColor: color,
    );
  }
}
