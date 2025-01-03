import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:manifast_app/Bindings/AppBindings.dart';

import 'flavors.dart';
import 'pages/my_home_page.dart';
import 'routes.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const Color darkPrimaryColor = Color(0xFF1E1E1E);
    const Color darkAccentColor = Color(0xFF007ACC);
    const Color darkBackgroundColor = Color(0xFF121212);
    const Color darkButtonColor = Color(0xFF007ACC);
    const Color darkTextColor = Colors.white;
    return GetMaterialApp(
      initialBinding: AppBindings(),
      title: F.title,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        primaryColor: Colors.white,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepPurple,
        ),
        cardColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
            foregroundColor: Colors.white,
          ),
        ),
        buttonTheme: ButtonThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.deepPurple,
          ),
          buttonColor: Colors.deepPurple,
          textTheme: ButtonTextTheme.primary,
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Color.fromARGB(255, 241, 241, 241),
          labelStyle: const TextStyle(color: Colors.black),
          hintStyle: const TextStyle(color: Colors.black54),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.black),
          ),
        ),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1E1E1E), // VS Code background color
        scaffoldBackgroundColor:
            const Color(0xFF1E1E1E), // VS Code background color
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF252526), // VS Code app bar color
        ),
        cardColor: const Color(0xFF2D2D2D), // VS Code card color
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF007ACC), // VS Code accent color
            foregroundColor: Colors.white,
          ),
        ),

        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF3C3C3C), // VS Code input field color
          labelStyle: const TextStyle(color: Colors.white),
          hintStyle: const TextStyle(color: Colors.white70),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: const BorderSide(color: Colors.white),
          ),
        ),
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: darkButtonColor,
          textTheme: ButtonTextTheme.primary,
          colorScheme: ColorScheme.dark(
            primary: darkPrimaryColor,
            secondary: darkAccentColor,
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color(0xFF007ACC), // VS Code FAB color
        ),
      ),
      getPages: Pages.pages,
      initialRoute: Routes.splash,
      themeMode: ThemeMode.light,
      // home: _flavorBanner(
      //   child: MyHomePage(),
      //   show: kDebugMode,
      // ),
    );
  }

  Widget _flavorBanner({
    required Widget child,
    bool show = true,
  }) =>
      show
          ? Banner(
              child: child,
              location: BannerLocation.topStart,
              message: F.name,
              color: Colors.green.withOpacity(0.6),
              textStyle: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 12.0,
                  letterSpacing: 1.0),
              textDirection: TextDirection.ltr,
            )
          : Container(
              child: child,
            );
}
