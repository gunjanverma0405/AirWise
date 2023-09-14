import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:loginapp/services/firebase_auth_methods.dart';
import 'package:loginapp/utils/routes.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(height: 70.0),
            Image.asset(
              "assets/images/main_image.png",
              fit: BoxFit.cover,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 55.0),
                Container(
                  width: 300.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.deepPurple[50],
                      ),
                      onPressed: () async {
                        await FirebaseAuthMethods.signInWithGoogle(
                            context: context);
                        // await showDialog<String>(
                        //   context: context,
                        //   builder: (BuildContext context) => AlertDialog(
                        //     title: const Text('Google sign in'),
                        //     content: const Text('Signed in successfully'),
                        //     actions: <Widget>[
                        //       TextButton(
                        //         onPressed: () =>
                        //             Navigator.pop(context, 'Cancel'),
                        //         child: const Text('Cancel'),
                        //       ),
                        //       TextButton(
                        //         onPressed: () => Navigator.pop(context, 'OK'),
                        //         child: const Text('OK'),
                        //       ),
                        //     ],
                        //   ),
                        // );
                        Navigator.pushNamed(context, MyRoutes.homeRoute);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            FontAwesomeIcons.google,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(width: 30.0),
                          Text(
                            'Sign in with Google',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25.0),
                Container(
                  width: 300.0,
                  child: Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: Colors.deepPurple[50],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: const <Widget>[
                          Icon(
                            FontAwesomeIcons.rightToBracket,
                            color: Colors.deepPurpleAccent,
                          ),
                          SizedBox(width: 30.0),
                          Text(
                            'Login with Email',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
