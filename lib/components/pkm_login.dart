import 'package:flutter/material.dart';
import 'package:oaks_legacy/components/pkm_grid.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/data/data_manager.dart';
import 'package:oaks_legacy/screens/start_screen.dart';
import 'package:oaks_legacy/utils/colors.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class PkmAccountIcon extends StatefulWidget {
  final String? resetCode;
  final Function()? callBack;

  const PkmAccountIcon({
    super.key,
    this.resetCode,
    this.callBack,
  });

  @override
  State<PkmAccountIcon> createState() => _PkmAccountIconState();
}

bool isUserLogged = false;
bool isLoginBoxVisible = false;
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

class _PkmAccountIconState extends State<PkmAccountIcon>
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

    return Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Card(
          color: cCardMainColor,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => setState(() {
                  isLoginBoxVisible = !isLoginBoxVisible;
                }),
                icon: MouseRegion(
                  onEnter: (event) => onEntered(true),
                  onExit: (event) => onEntered(false),
                  child: Transform.scale(
                    scale: isHovered ? 1.2 : 1.0,
                    child: (isLoginBoxVisible)
                        ? Icon(
                            Icons.close,
                            size: iconSize,
                            color: cIconMainColor,
                          )
                        : (isUserLogged)
                            ? Icon(
                                Icons.person,
                                size: iconSize,
                                color: cIconMainColor,
                              )
                            : Icon(
                                Icons.person,
                                size: iconSize,
                                color: cIconAltColor,
                              ),
                  ),
                ),
              ),
              Visibility(
                visible: isLoginBoxVisible,
                child: MaterialApp(
                  debugShowCheckedModeBanner: false,
                  theme: ThemeData(
                      // // Define the theme for input decoration
                      inputDecorationTheme: InputDecorationTheme(
                          labelStyle: TextStyle(
                              color:
                                  cTextFieldPlaceholderTextColor), // TextField title text color
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    cTextFieldBorderColor), // TextField border color when focused
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    cTextFieldBorderColor), // TextField border color when enabled
                          ),
                          errorStyle: TextStyle(color: cErrorTextColor),
                          errorBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: cTextFieldErrorBorderColor,
                            ), // TextField border color when enabled
                          ),
                          prefixIconColor: cIconAltColor),

                      // Define the theme for text fields
                      textTheme: Theme.of(context).textTheme.copyWith(
                            bodyLarge: TextStyle(color: cTextFieldTextColor),
                          ),
                      textButtonTheme: TextButtonThemeData(
                        style: ButtonStyle(
                          foregroundColor: WidgetStateProperty.all<Color>(
                              cTextButtonTextColor), // Text color
                        ),
                      ),
                      elevatedButtonTheme: ElevatedButtonThemeData(
                          style: ButtonStyle(
                        foregroundColor: WidgetStateProperty.all<Color>(
                            cButtonConfirmTextColor),
                        backgroundColor:
                            WidgetStateProperty.all<Color>(cButtonConfirmColor),
                      ))),
                  home: (widget.resetCode != null)
                      ? resetPassword(widget.resetCode)
                      : (isUserLogged)
                          ? logout()
                          : login(),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

//https://gfoeebribnlwseyepwlx.supabase.co/auth/v1/verify?token=pkce_9aaa35c2a47249b43fdcbb3a9b252557ab6a1b0598832f4aa419e49f&type=signup&redirect_to=https://oaks-legacy.vercel.app
  login() {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SupaEmailAuth(
          // redirectTo: 'https://oaks-legacy.vercel.app/?signup=complete',
          onError: (error) {
            showSnackbar(context, error.toString());
          },
          onPasswordResetEmailSent: () {
            setState(() {
              logUser(null);
              isLoginBoxVisible = false;
            });
            showSnackbar(context, 'Reset Password Email sent!');
            widget.callBack!();
          },
          onSignInComplete: (response) {
            setState(() {
              logUser(response.user!.id);
              isLoginBoxVisible = false;
            });
            widget.callBack!();
          },
          onSignUpComplete: (response) {
            setState(() {
              logUser(null);
              isLoginBoxVisible = false;
            });
            showSnackbar(context, 'Confirmation Email sent!');
            widget.callBack!();
          },
          // metadataFields: [
          //   MetaDataField(
          //     prefixIcon: const Icon(Icons.person),
          //     label: 'Username',
          //     key: 'username',
          //     validator: (val) {
          //       if (val == null || val.isEmpty) {
          //         return 'Please enter something';
          //       }
          //       return null;
          //     },
          //   ),
          // ],
        ),
      ),
    );
  }

  logout() {
    return SizedBox(
      width: 200,
      height: 100,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultTextStyle(
                style: TextStyle(
                  color: cTextFieldTextColor,
                  fontSize: 15,
                ),
                child: Text(
                  '(${Supabase.instance.client.auth.currentUser!.email.toString()})',
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  setState(() {
                    logUser(null);
                    isLoginBoxVisible = false;
                  });
                  widget.callBack!();
                },
                child: const Text("Logout"),
              ),
            ],
          )),
    );
  }

  resetPassword(resetCode) {
    isLoginBoxVisible = true;

    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SupaResetPassword(
          accessToken: resetCode,
          onSuccess: (UserResponse response) {
            setState(() {
              logUser(response.user!.id);
              isLoginBoxVisible = false;
            });
            navigate();
          },
          onError: (error) {
            showSnackbar(context, error.toString());
          },
        ),
      ),
    );
  }

  navigate() {
    Navigator.pop(context);
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const StartScreen();
        },
      ),
    );
  }
}
