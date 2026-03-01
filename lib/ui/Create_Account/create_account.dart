import 'package:e_commarce_kk/Colors/colors.dart';
import 'package:e_commarce_kk/ui/Home/Bottom_navigation/bottom_navogation.dart';
import 'package:e_commarce_kk/ui/Login/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Controller/auth_controller.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {

  final controller = Get.put(AuthController());

  bool passwordtext = false;
  bool re_passwordtext = false;
  bool agree = false;

  final namecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final phonecontroller = TextEditingController();
  final passwordcontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(onPressed: (){
              Get.to(
                      () => Login(),
                       transition: Transition.leftToRight,
                       duration: Duration(seconds: 1)
              );
          }, icon: Icon(Icons.arrow_back_ios)),
          title:Padding(
            padding: const EdgeInsets.only(left: 45.0),
            child: Text('Create Account',style: TextStyle(fontSize:20,color: Colors.grey ),),
          ),
          
          actions: [
            TextButton(onPressed: (){}, child: Text('Help',style: TextStyle(color: Colors.blue),))
          ],
        ),

      body: ListView(
        children: [

          Column(
            children: [

              SizedBox(height: 10,),

              Container(
                height: Get.height*0.07,
                width: Get.width*0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Appcolor.logo_bg
                ),
                child: Center(child: Text('VR',style: TextStyle(color: Appcolor.logo_text,fontSize: 20,fontWeight: FontWeight.bold),)),
              ),

              SizedBox(height: 10,),
              Text('Join Vastra Royale',style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
              Text('Unlock exclusive fashion collection and premium rewards',textAlign: TextAlign.center,style: TextStyle(color: Colors.grey),),

              SizedBox(height: 20,),

              SizedBox(
                width: Get.width*0.85,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('FULL NAME',style: TextStyle(color: Appcolor.text_main),),
                    SizedBox(height: 0,),
                    TextField(
                      controller: namecontroller,
                        decoration: InputDecoration(
                          border:OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Icon(Icons.person_2_outlined,color: Appcolor.hint_text,),
                          hintText: 'Full Name',
                          hintStyle: TextStyle(color: Appcolor.hint_text,
                          ),
                        )
                    ),
                  ],
                )
              ),

              SizedBox(height: 20,),

              SizedBox(
                  width: Get.width*0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('EMAIL ADDRESS',style: TextStyle(color: Appcolor.text_main),),
                      SizedBox(height: 0,),
                      TextField(
                        controller: emailcontroller,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email_outlined,color: Appcolor.hint_text,),
                            hintText: 'example@gmail.com',
                            hintStyle: TextStyle(color: Appcolor.hint_text,
                            ),
                          )
                      ),
                    ],
                  )
              ),

              SizedBox(
                  width: Get.width*0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Password',style: TextStyle(color: Appcolor.text_main),),
                      SizedBox(height: 0,),
                      TextField(
                        controller: passwordcontroller,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.email_outlined,color: Appcolor.hint_text,),
                            hintText: 'Enter your password',
                            hintStyle: TextStyle(color: Appcolor.hint_text,
                            ),
                          )
                      ),
                    ],
                  )
              ),

              SizedBox(height: 20,),

              SizedBox(
                  width: Get.width*0.85,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('PHONE NUMBER',style: TextStyle(color: Appcolor.text_main),),
                      SizedBox(height: 0,),
                      TextField(
                        controller: phonecontroller,
                          decoration: InputDecoration(
                            border:OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            prefixIcon: Icon(Icons.phone_android_outlined,color: Appcolor.hint_text,),
                            hintText: '+91 9773227689',
                            hintStyle: TextStyle(color: Appcolor.hint_text,
                            ),
                          )
                      ),
                    ],
                  )
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Checkbox(
                      value: agree,
                      onChanged: (value){
                        setState(() {
                          agree = value!;
                        });
                      },
                    ),
                    
                    Text('I agree to the',style: TextStyle()),
                    TextButton(onPressed: (){},
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.only(left: 5),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          minimumSize: Size.zero,
                        ),
                        child: Text('Terms & Conditions',style: TextStyle(color: Colors.blue),))


                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                width: Get.width*0.85,
                child: ElevatedButton(onPressed: (){
                  if (!agree) {
                    Get.snackbar("Error", "Please accept Terms & Conditions");
                    return;
                  }

                  if (namecontroller.text.isEmpty ||
                      emailcontroller.text.isEmpty ||
                      passwordcontroller.text.isEmpty ||
                      phonecontroller.text.isEmpty) {
                    Get.snackbar("Error", "All fields required");
                    return;
                  }

                  controller.signup(
                    emailcontroller.text.trim(),
                    passwordcontroller.text.trim(),
                    phonecontroller.text.trim(),
                    namecontroller.text.trim(),
                  );

                  },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: Colors.blue
                    ),
                    child:Text('Create Account',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),)),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: Row(
                  children: [

                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Text(
                      "Or continue with",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: Divider(
                        color: Colors.grey,
                        thickness: 1,
                      ),
                    ),

                  ],
                ),
              ),
              

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Alreasy have an account?'),
                  TextButton(onPressed: (){
                    Get.to(
                        () => Login(),
                        transition: Transition.leftToRight,
                        duration: Duration(seconds: 1)
                    );
                  },
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.only(left: 5),
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        minimumSize: Size.zero,
                      ),
                      child: Text('Login',style: TextStyle(color: Colors.blue),))
                ],
              ),

              SizedBox(height: 30,),
              



            ],
          )

        ],
      ),



        

    );
  }
}
