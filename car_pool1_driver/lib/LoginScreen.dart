import 'dart:typed_data';

import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/HomePage.dart';
import 'package:car_pool1_driver/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'Shared/DBHandler/firebaseAuth.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1_driver/Shared/SharedTheme/SharedFont.dart';
import 'package:car_pool1_driver/Shared/SharedWidgets/snack_widget.dart';
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

  bool isLoading = false;




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColor.backgroundColor,

      appBar: AppBar(

        backgroundColor: Colors.blueGrey,
        elevation: 0.0,

        title: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('ASU Pool Driver', style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0, fontWeight: FontWeight.bold
              )),
              SizedBox(width: 20,),
              Container(
                child: Image.asset('assets/images/driver.png'),
                height: 45,
                width: 45,

              ),
            ],
          ),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.blueGrey, size: 20.0),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            children: [

              input_field('Email Address', Icons.email, emailController, false, emailKey),
              input_field('Password', Icons.lock, passwordController, isSecured, passwordKey),

              ElevatedButton(
                child: Text('Login', style: SharedFont.whiteStyle),
                style: TextButton.styleFrom(
                    backgroundColor: Colors.blueGrey,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                onPressed: () async {
                  if(emailController.text == 'testdriver@eng.asu.edu.eg' && passwordController.text == '123456')
                  {
                    userName = 'Test Driver';
                    userEmail = 'testdriver@eng.asu.edu.eg';
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomePage()));
                  }
                  else if (!formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Missing Required Fields', 3, Colors.red)
                    );
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                    await Future.delayed(Duration(seconds: 3));
                    firebaseAuthClass().loginDriver(context, emailController.text, passwordController.text);
                    setState(() {
                      isLoading = false;
                    });
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
              ),
              SizedBox(height: 35,),
              (isLoading)? CircularProgressIndicator():SizedBox(height: 0,),
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