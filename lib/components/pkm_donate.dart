import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/data/data_manager.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PkmDonateIcon extends StatefulWidget {
  final String? resetCode;

  const PkmDonateIcon({
    super.key,
    this.resetCode,
  });

  @override
  State<PkmDonateIcon> createState() => _PkmDonateIconState();
}

bool isUserLogged = false;
bool displayNews = false;
void logUser(id) {
  if (id != null) {
    isUserLogged = true;
    loggedUserId = id;
  } else {
    isUserLogged = false;
    loggedUserId = '';
  }
  DataManager.setUserPreferences();
}

class _PkmDonateIconState extends State<PkmDonateIcon>
    with TickerProviderStateMixin {
  bool isHovered = false;

  void onEntered(isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;
    double iconSize = (isMobile) ? 25 : 40;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ZoomTapAnimation(
        child: GestureDetector(
          onTap: () async {
            final Uri url = Uri.parse(kDonateLink);

            if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
              throw Exception('Could not launch $url');
            }
          },
          child: MouseRegion(
            onEnter: (event) => onEntered(true),
            onExit: (event) => onEntered(false),
            child: Transform.scale(
              scale: isHovered ? 1.2 : 1.0,
              child: Icon(
                Icons.coffee,
                size: iconSize,
                color: cIconAltColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
