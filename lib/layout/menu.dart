import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:manifast_app/flavors.dart';

AppBar appBarLayout() {
  // final themeModeController = Get.find<ThemeModeController>();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      // statusBarColor: Colors.teal,
      // statusBarIconBrightness: Brightness.light,
      ));
  return AppBar(
    // iconTheme: const IconThemeData(color: Color.fromARGB(255, 233, 233, 233)),
    leading: Builder(
      builder: (context) => IconButton(
        icon: const Icon(
          Icons.menu,
        ),
        // splashRadius: 1,

        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
    ),
    actions: [
      const Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: CircleAvatar(
          backgroundImage: AssetImage(
              'assets/images/profile.jpg'), // Ensure the path is correct
        ),
      ),
    ],
    centerTitle: true,
    // backgroundColor: Colors.teal,
    elevation: 5,
    // shadowColor: Colors.black,
    title: Text(
      F.title.toUpperCase(),
      style: GoogleFonts.fredoka(
        textStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.5,
          fontSize: 20,
        ),
      ),
      // style: const TextStyle(
      //     color: Colors.white, fontWeight: FontWeight.bold, letterSpacing: 0.1,),
    ),
    // actions: <Widget>[
    //   //on off switch
    //   Obx(
    //     () => IconButton(
    //         onPressed: () {
    //           themeModeController.changeThemeMode();
    //         },
    //         icon: !themeModeController.isDarkMode.value
    //             ? const Icon(
    //                 Icons.light_mode,
    //                 color: Colors.yellow,
    //               )
    //             : const Icon(Icons.dark_mode)),
    //   ),
    //   SizedBox(
    //     width: 10,
    //   ),
    // ],
  );
}
