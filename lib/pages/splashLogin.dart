
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:mobile_version_bloc/pages/guest-pages/layoutGuest.dart';
import 'package:mobile_version_bloc/utility/appColor.dart';


class SplashLogin extends StatelessWidget {
  const SplashLogin({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      backgroundColor: AppColors.backgroundColor,
      splash: Column(
        
        children: [
          Center(
            child: Container(
              // width: 200,
              height: 82,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo1.png'),
                ),
              ),
              child: Container(
                
              ),
            ),
          )
        ],
      ),
      nextScreen: const LayoutGuest(),
        
      
    );
  }
}
