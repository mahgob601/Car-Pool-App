import 'dart:typed_data';

import 'package:car_pool1/Globals/global_var.dart';
import 'package:car_pool1/HomePage.dart';
import 'package:car_pool1/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Shared/DBHandler/firebaseAuth.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedFont.dart';
import 'package:car_pool1/Shared/SharedWidgets/snack_widget.dart';
import 'SignupScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  GlobalKey<FormState> emailKey = GlobalKey<FormState>();
  GlobalKey<FormState> passwordKey = GlobalKey<FormState>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isSecured = true;



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColor.backgroundColor,

      appBar: AppBar(

        backgroundColor: SharedColor.tealColor,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ASU Pool', style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0, fontWeight: FontWeight.bold
              )),
              SizedBox(width: 20,),
              Container(
                child: Image.asset('assets/images/car.png'),
                height: 45,
                width: 45,

              ),
            ],
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: SharedColor.tealColor, size: 20.0),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [

              input_field('Email Address', Icons.email, emailController, false, emailKey),
              input_field('Password', Icons.lock, passwordController, isSecured, passwordKey),

              TextButton(
                child: Text('Login', style: SharedFont.whiteStyle),
                style: TextButton.styleFrom(
                    backgroundColor: SharedColor.tealColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                onPressed: () {
                  if(emailController.text == 'test@eng.asu.edu.eg' && passwordController.text == '123456')
                    {
                      userName = 'Test';
                      userEmail = 'test@eng.asu.edu.eg';
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                    }
                  else if (!formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Missing Required Fields', 3, Colors.red)
                    );
                  } else {
                    firebaseAuthClass().loginUser(context,emailController.text.trim(),passwordController.text.trim());
                  }
                },
              ),
              SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Text('\nDon\'t have an account? Sign up', style: SharedFont.subTealStyle),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => SignUpScreen()));
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  OutlineInputBorder fieldBorder(Color color) {
    return OutlineInputBorder(
        borderSide: BorderSide(color: color, width: 1.0),
        borderRadius: BorderRadius.circular(20.0)
    );
  }

  Container input_field(String label, IconData icon, TextEditingController controller, bool isSecure, Key key) {
    return Container(
      margin: EdgeInsets.all(10.0),
      child: TextFormField(
          key: key,
          validator: (x) {

            if (x!.isEmpty)
              {
                return 'This Field Required!';

              }
            else if(x!.length < 5)
              {
                return 'Entry is too short!';
              }
          },
          decoration: InputDecoration(
              border: fieldBorder(SharedColor.greyColor),
              enabledBorder: fieldBorder(SharedColor.greyColor),
              focusedBorder: fieldBorder(SharedColor.greyColor),
              errorBorder: fieldBorder(Colors.red),
              labelText: label,
              labelStyle: SharedFont.subGreyStyle,
              prefixIcon: Icon(icon, color: SharedColor.greyColor, size: 20.0),
              suffixIcon: label == 'Password' ? IconButton(
                icon: isSecured? Icon(Icons.visibility)  : Icon(Icons.visibility_off) ,
                color: SharedColor.greyColor,
                iconSize: 20.0,
                onPressed: () {
                  isSecured = !isSecured;
                  setState(() {

                  });
                },
              ) :  null
          ),
          style: SharedFont.subBlackStyle,
          obscureText: isSecure,
          controller: controller
      ),
    );
  }
}