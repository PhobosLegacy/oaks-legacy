import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:oaks_legacy/constants.dart';
import 'package:oaks_legacy/screens/start_screen.dart';
import 'package:oaks_legacy/utils/functions.dart';
import 'package:supabase_auth_ui/supabase_auth_ui.dart';

class PkmAccountIcon extends StatefulWidget {
  final String? resetCode;

  const PkmAccountIcon({
    super.key,
    this.resetCode,
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
  }
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
    return Align(
      alignment: Alignment.topCenter,
      child: Card(
        color: const Color(0xFF1D1E33),
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
                      ? const Icon(
                          Icons.close,
                          size: 40,
                          color: Colors.amber,
                        )
                      : (isUserLogged)
                          ? const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.amber,
                            )
                          : const Icon(
                              Icons.person,
                              size: 40,
                              color: Colors.white,
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
                    inputDecorationTheme: const InputDecorationTheme(
                        labelStyle: TextStyle(
                            color: Colors.amber), // TextField title text color
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .amber), // TextField border color when focused
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors
                                  .grey), // TextField border color when enabled
                        ),
                        prefixIconColor: Colors.white),

                    // Define the theme for text fields
                    textTheme: Theme.of(context).textTheme.copyWith(
                          bodyLarge: const TextStyle(color: Colors.white),
                        ),
                    // // Define the theme for icons
                    iconTheme:
                        const IconThemeData(color: Colors.amber), // Icon color
                    // // Define the theme for buttons
                    buttonTheme: const ButtonThemeData(
                      buttonColor: Colors.amber, // Button background color
                      textTheme: ButtonTextTheme.primary,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: ButtonStyle(
                        foregroundColor: MaterialStateProperty.all<Color>(
                            Colors.white70), // Text color
                      ),
                    ),
                    elevatedButtonTheme: ElevatedButtonThemeData(
                        style: ButtonStyle(
                      foregroundColor:
                          MaterialStateProperty.all<Color>(Colors.black),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.green),
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
    );
  }

  refresh() {
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

  login() {
    return SizedBox(
      width: 300,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: SupaEmailAuth(
          redirectTo: kIsWeb ? null : 'http://localhost:54160/',
          onError: (error) {
            showSnackbar(context, error.toString());
          },
          onPasswordResetEmailSent: () => {
            setState(() {
              isUserLogged = false;
              isLoginBoxVisible = false;
              loggedUserId = '';
            }),
          },
          onSignInComplete: (response) {
            setState(() {
              isUserLogged = true;
              isLoginBoxVisible = false;
              loggedUserId = response.user!.id;
            });
          },
          onSignUpComplete: (response) {
            setState(() {
              isUserLogged = true;
              isLoginBoxVisible = false;
              loggedUserId = response.user!.id;
            });
          },
        ),
      ),
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
              isUserLogged = false;
              isLoginBoxVisible = false;
              loggedUserId = '';
            });
            refresh();
          },
          onError: (error) {
            showSnackbar(context, error.toString());
          },
        ),
      ),
    );
  }

  logout() {
    return SizedBox(
      width: 150,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              ElevatedButton(
                onPressed: () async {
                  await Supabase.instance.client.auth.signOut();
                  setState(() {
                    isUserLogged = false;
                    isLoginBoxVisible = false;
                    loggedUserId = '';
                  });
                },
                child: const Text("Logout"),
              ),
            ],
          )),
    );
  }
}



// onPressed: () async {
//   showDialog(
//     barrierColor: Colors.black87,
//     context: context,
//     builder: (BuildContext context) {
//       return MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             // // Define the theme for input decoration
//             inputDecorationTheme: const InputDecorationTheme(
//                 labelStyle: TextStyle(
//                     color:
//                         Colors.amber), // TextField title text color
//                 focusedBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Colors
//                           .amber), // TextField border color when focused
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                   borderSide: BorderSide(
//                       color: Colors
//                           .grey), // TextField border color when enabled
//                 ),
//                 prefixIconColor: Colors.white),

//             // Define the theme for text fields
//             textTheme: Theme.of(context).textTheme.copyWith(
//                   bodyLarge: const TextStyle(color: Colors.white),
//                 ),
//             // // Define the theme for icons
//             iconTheme: const IconThemeData(
//                 color: Colors.amber), // Icon color
//             // // Define the theme for buttons
//             buttonTheme: const ButtonThemeData(
//               buttonColor: Colors.amber, // Button background color
//               textTheme: ButtonTextTheme.primary,
//             ),
//             textButtonTheme: TextButtonThemeData(
//               style: ButtonStyle(
//                 foregroundColor: MaterialStateProperty.all<Color>(
//                     Colors.white70), // Text color
//               ),
//             ),
//             elevatedButtonTheme: ElevatedButtonThemeData(
//                 style: ButtonStyle(
//               foregroundColor:
//                   MaterialStateProperty.all<Color>(Colors.black),
//               backgroundColor:
//                   MaterialStateProperty.all<Color>(Colors.green),
//             ))),
//         home: AlertDialog(
//           backgroundColor: const Color(0xFF1D1E33),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               SupaEmailAuth(
//                 redirectTo:
//                     kIsWeb ? null : 'http://localhost:54160/',
//                 onSignInComplete: (response) {
//                   isUserLogged = true;
//                   Navigator.pop(context);
//                   // do something, for example: navigate('home');
//                 },
//                 onSignUpComplete: (response) {
//                   isUserLogged = true;
//                   Navigator.pop(context);
//                   // do something, for example: navigate("wait_for_email");
//                 },
//                 // metadataFields: [
//                 //   MetaDataField(
//                 //     prefixIcon: const Icon(
//                 //       Icons.person,
//                 //       color: Colors.white,
//                 //     ),
//                 //     label: 'Username',
//                 //     key: 'username',
//                 //     validator: (val) {
//                 //       if (val == null || val.isEmpty) {
//                 //         return 'Please enter something';
//                 //       }
//                 //       return null;
//                 //     },
//                 //   ),
//                 // ],
//               ),
//               Align(
//                 alignment: Alignment.center,
//                 child: IconButton(
//                   onPressed: () => Navigator.pop(context),
//                   icon: const Icon(
//                     Icons.close,
//                     color: Colors.white,
//                     size: 20,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
//   setState(() {});
// },



// // child: Container(
// //   color: const Color(0xFF1D1E33),
// //   width: 600,
// //   height: 300,
// //   child: SupaEmailAuth(
// //     redirectTo: kIsWeb ? null : 'http://localhost:54160/',
// //     onSignInComplete: (response) {
// //       isUserLogged = true;
// //       Navigator.pop(context);
// //       // do something, for example: navigate('home');
// //     },
// //     onSignUpComplete: (response) {
// //       isUserLogged = true;
// //       Navigator.of(context).pop();
// //       // do something, for example: navigate("wait_for_email");
// //     },
// //   ),
// // ),
// // child: MaterialApp(
// //   debugShowCheckedModeBanner: false,
// //   theme: ThemeData(
// //       // // Define the theme for input decoration
// //       inputDecorationTheme: const InputDecorationTheme(
// //           labelStyle: TextStyle(
// //               color: Colors.amber), // TextField title text color
// //           focusedBorder: OutlineInputBorder(
// //             borderSide: BorderSide(
// //                 color: Colors
// //                     .amber), // TextField border color when focused
// //           ),
// //           enabledBorder: OutlineInputBorder(
// //             borderSide: BorderSide(
// //                 color: Colors
// //                     .grey), // TextField border color when enabled
// //           ),
// //           prefixIconColor: Colors.white),

// //       // Define the theme for text fields
// //       textTheme: Theme.of(context).textTheme.copyWith(
// //             bodyLarge: const TextStyle(color: Colors.white),
// //           ),
// //       // // Define the theme for icons
// //       iconTheme:
// //           const IconThemeData(color: Colors.amber), // Icon color
// //       // // Define the theme for buttons
// //       buttonTheme: const ButtonThemeData(
// //         buttonColor: Colors.amber, // Button background color
// //         textTheme: ButtonTextTheme.primary,
// //       ),
// //       textButtonTheme: TextButtonThemeData(
// //         style: ButtonStyle(
// //           foregroundColor: MaterialStateProperty.all<Color>(
// //               Colors.white70), // Text color
// //         ),
// //       ),
// //       elevatedButtonTheme: ElevatedButtonThemeData(
// //           style: ButtonStyle(
// //         foregroundColor:
// //             MaterialStateProperty.all<Color>(Colors.black),
// //         backgroundColor:
// //             MaterialStateProperty.all<Color>(Colors.green),
// //       ))),
// //   home: AlertDialog(
// //     backgroundColor: const Color(0xFF1D1E33),
// //     content: Column(
// //       mainAxisSize: MainAxisSize.min,
// //       mainAxisAlignment: MainAxisAlignment.center,
// //       children: [
// //         SupaEmailAuth(
// //           redirectTo: kIsWeb ? null : 'http://localhost:54160/',
// //           onSignInComplete: (response) {
// //             isUserLogged = true;
// //             Navigator.pop(context);
// //             // do something, for example: navigate('home');
// //           },
// //           onSignUpComplete: (response) {
// //             isUserLogged = true;
// //             Navigator.pop(context);
// //             // do something, for example: navigate("wait_for_email");
// //           },
// //         ),
// //         Align(
// //           alignment: Alignment.center,
// //           child: IconButton(
// //             onPressed: () => Navigator.pop(context),
// //             icon: const Icon(
// //               Icons.close,
// //               color: Colors.white,
// //               size: 20,
// //             ),
// //           ),
// //         ),
// //       ],
// //     ),
// //   ),