import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/action_button.dart';
import 'package:oaks_legacy/components/pkm_drop_down.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/data/data_manager.dart';
import 'package:oaks_legacy/data/database_manager.dart';
import 'package:oaks_legacy/models/message.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:oaks_legacy/utils/extensions.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class PkmContactIcon extends StatefulWidget {
  final String? resetCode;

  const PkmContactIcon({
    super.key,
    this.resetCode,
  });

  @override
  State<PkmContactIcon> createState() => _PkmContactIconState();
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

class _PkmContactIconState extends State<PkmContactIcon>
    with TickerProviderStateMixin {
  bool isHovered = false;
  String selectedValue = '';
  String message = '';

  void onEntered(isHovering) {
    setState(() {
      isHovered = isHovering;
    });
  }

  Future<bool> sendEmail(String title, String message) async {
    List<Message> messages = await DatabaseManager.getMessages();

    final String today = DateTime.now().toString().formatDateTime();

    var count = messages.where((element) => element.date == today).toList();

    if (count.length < kMaxNumberOfMessagesDaily) {
      Message msg = Message(
        type: title,
        content: message,
        date: DateTime.now().toString(),
      );
      await DatabaseManager.saveMessage(msg);
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = PkmGrid.getCardsPerRow(context) == 1;
    double iconSize = (isMobile) ? 25 : 40;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ZoomTapAnimation(
        child: GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return StatefulBuilder(
                  builder: (context, setState) {
                    return Stack(
                      children: [
                        Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Material(
                              color: Colors.transparent,
                              child: Container(
                                decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      color: cCardShadowColor,
                                      blurRadius: 5,
                                      spreadRadius: 0.5,
                                      offset: const Offset(3, 3),
                                    ),
                                  ],
                                  color: cCardMainColor,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(10),
                                  ),
                                ),
                                width: isMobile ? 300 : 400,
                                height: isMobile ? 350 : 375,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Contact',
                                        style: TextStyle(
                                          color: cTitleColor,
                                          fontSize: 20,
                                        ),
                                      ),
                                    ),
                                    PkmDropDown2(
                                      value: selectedValue,
                                      hintText: 'Select',
                                      onTap: (value) {
                                        setState(() {
                                          selectedValue = value;
                                        });
                                      },
                                      items: [
                                        'Bug',
                                        'Suggestion',
                                        'Question',
                                        'Other'
                                      ]
                                          .map((item) => DropdownMenuItem(
                                                value: item,
                                                child: AutoSizeText(
                                                  item,
                                                  style: TextStyle(
                                                    fontSize:
                                                        isMobile ? 12 : 15,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: TextField(
                                        minLines: 6,
                                        maxLines: 6,
                                        onChanged: (value) {
                                          message = value;
                                        },
                                        decoration: InputDecoration(
                                          fillColor: Colors.black26,
                                          filled: true,
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                              color: Colors.amber,
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(10),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    ActionButton(
                                      onPress: () async {
                                        bool isMessageSent = await sendEmail(
                                            selectedValue, message);
                                        String retMsg = (isMessageSent)
                                            ? 'Message sent successfully!'
                                            : 'Daily limit reached';

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(content: Text(retMsg)),
                                          );
                                          Navigator.pop(context);
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.send,
                                        color: Colors.green,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: ZoomTapAnimation(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                  size: iconSize,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                );
              },
            );
          },
          child: MouseRegion(
            onEnter: (event) => onEntered(true),
            onExit: (event) => onEntered(false),
            child: Transform.scale(
              scale: isHovered ? 1.2 : 1.0,
              child: Icon(
                Icons.contact_support_rounded,
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
