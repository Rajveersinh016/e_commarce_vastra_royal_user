import 'package:e_commarce_kk/Controller/User_Controller.dart';
import 'package:e_commarce_kk/ui/auth_checker/auth_checker.dart';
import 'package:e_commarce_kk/ui/onboarding_screens/onboarding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final usercontroller = Get.put(UserController());

  late double width = MediaQuery.of(context).size.width;
  late double height = MediaQuery.of(context).size.height;

  @override
  void initState() {
    super.initState();
    goToHome();
  }


  void goToHome(){
    Future.delayed(const Duration(seconds: 3), (){
      Get.offAll(const AuthChecker());

    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
       body:
        Container(
          height: double.infinity,
          width: double.infinity,
          child: 
          Image(image:AssetImage('lib/assets/images/splash_screen.png'),fit: BoxFit.fill,),
        )
        
    

    );
  }
}
