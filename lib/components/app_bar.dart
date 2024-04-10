import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_login.dart';

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
      title: SizedBox(
        width: 200,
        child: Stack(
          children: [
            title,
            if (!isUserLogged)
              Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (dialogContext) => AlertDialog(
                        backgroundColor: const Color(0xFF1D1E33),
                        title: const Text(
                          'You are not logged in.',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.amber),
                        ),
                        content: const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'Your changes will be saved locally and you can\'t access them on other devices.',
                              style: TextStyle(color: Colors.white),
                            ),
                            Text(
                              '(Your browser might also erase them at any given time.)',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                        actions: [
                          Center(
                            child: TextButton(
                              child:
                                  const Icon(Icons.check, color: Colors.green),
                              onPressed: () {
                                Navigator.pop(dialogContext);
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.warning,
                    color: Colors.yellow,
                  ),
                ),
              )
          ],
        ),
      ),
      backgroundColor: color,
    );
  }
}
