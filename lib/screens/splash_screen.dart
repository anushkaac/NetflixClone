import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/main');
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Center( // Ensures the column is centered both vertically and horizontally
        child: Column(
          mainAxisSize: MainAxisSize.min, // Prevents the column from taking up all vertical space
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/splash_image.png', // Add your splash image
              width: 150,
              height: 150,
            ),
            SizedBox(height: 20),
            CircularProgressIndicator(
              color: Colors.red, // Netflix-like red accent
            ),
          ],
        ),
      ),
    );
  }
}
