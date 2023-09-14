import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginapp/firebase_options.dart';
import 'package:loginapp/pages/login_page.dart';
import 'package:loginapp/pages/main_page.dart';
import 'package:loginapp/pages/signup_page.dart';
import 'package:loginapp/utils/routes.dart';
import 'package:provider/provider.dart';
import 'Screens/homeScreen.dart';
import 'provider/weatherProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MaterialApp(
    //   title: 'Login App',
    //   debugShowCheckedModeBanner: false,
    //   theme: ThemeData(
    //     primarySwatch: Colors.deepPurple,
    //   ),
    //   initialRoute: MyRoutes.mainRoute,
    //   routes: {
    //     "/": (context) => const MainPage(),
    //     MyRoutes.loginRoute: (context) => const LoginPage(),
    //     MyRoutes.signupRoute: (context) => const SignUpPage(),
    //     MyRoutes.mainRoute: (context) => const MainPage(),
    //     MyRoutes.homeRoute: (context) => const HomeScreen(),
    //   },
    // );
    return ChangeNotifierProvider(
      create: (context) => WeatherProvider(),
      child: MaterialApp(
        title: 'AirWise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            iconTheme: IconThemeData(
              color: Colors.blue,
            ),
            elevation: 0,
          ),
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          colorScheme:
              ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
        ),
        initialRoute: MyRoutes.mainRoute,
        routes: {
          "/": (context) => const MainPage(),
          MyRoutes.loginRoute: (context) => const LoginPage(),
          MyRoutes.signupRoute: (context) => const SignUpPage(),
          MyRoutes.mainRoute: (context) => const MainPage(),
          MyRoutes.homeRoute: (context) => HomeScreen(),
        },
      ),
    );
  }
}
