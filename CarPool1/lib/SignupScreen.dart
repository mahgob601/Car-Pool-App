import 'dart:typed_data';

import 'package:car_pool1/Globals/global_var.dart';
import 'package:car_pool1/LoginScreen.dart';
import 'package:car_pool1/Shared/DBHandler/firebase_storage.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1/main.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedColor.dart';
import 'package:car_pool1/Shared/SharedTheme/SharedFont.dart';
import 'package:car_pool1/Shared/SharedWidgets/snack_widget.dart';
import 'package:flutter/services.dart';
import 'SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  TextEditingController usernameController = TextEditingController();
  TextEditingController phonenumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isSecuredSignup = true;
  bool isChecked = false;
  DateTime selectedDate = DateTime(1970);


  registerUser() async
  {
    final User? userFirebase = (
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim()).catchError((errorMsg){
      ScaffoldMessenger.of(context).showSnackBar(snack(errorMsg.toString(), 3, Colors.red));
    })
    ).user;

    final ByteData bytes = await rootBundle.load('assets/images/defaultProfile.png');
    final Uint8List imagelist = bytes.buffer.asUint8List();
    profileImageURL = await StoreData().uploadImage("users/ProfileImage/${userFirebase!.uid}/myImage", imagelist);


    DatabaseReference usersRef = FirebaseDatabase.instance.ref().child("users").child(userFirebase!.uid);
    Map userDataMap =
        {
          "ProfileImage": profileImageURL,
          "name": usernameController.text.trim(),
          "email": emailController.text.trim(),
          "phone":phonenumberController.text.trim(),
          "id": userFirebase.uid,
          "isDriver": "No",
          "blockStatus":"no",


        };
    usersRef.set(userDataMap);

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SharedColor.backgroundColor,
      resizeToAvoidBottomInset: false,

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
        reverse: true,
        child: Padding(
          padding: const EdgeInsets.only(top: 0),
          child: Column(
            children: [

              input_field('Username', Icons.person, usernameController, false),
              input_field('Email Address', Icons.email, emailController, false),
              input_field('Phone number', Icons.phone, phonenumberController, false),
              input_field('Password', Icons.lock, passwordController, isSecuredSignup),


              TextButton(
                child: Text('Signup', style: SharedFont.whiteStyle),
                style: TextButton.styleFrom(
                    backgroundColor: SharedColor.tealColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
                    maximumSize: Size(200.0, 50.0),
                    minimumSize: Size(200.0, 50.0)
                ),
                onPressed: () {
                  if (emailController.text.isEmpty || passwordController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        snack('Some Fields Required', 3, Colors.red)
                    );
                  }
                  else if(!emailController.text.endsWith("eng.asu.edu.eg"))
                    {
                      ScaffoldMessenger.of(context).showSnackBar(
                          snack('Invalid Email address', 3, Colors.red)
                      );
                    }
                  else {
                    registerUser();
                  }
                },
              ),

              SizedBox(
                height: 10,
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: InkWell(
                  child: Text('\nAlready have an account? Login', style: SharedFont.subTealStyle),
                  onTap: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) {return LoginScreen();}));
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

  Container input_field(String label, IconData icon, TextEditingController controller, bool isSecure) {
    return Container(
      margin: EdgeInsets.all(8),
      child: TextField(
          decoration: InputDecoration(
              border: fieldBorder(SharedColor.greyColor),
              enabledBorder: fieldBorder(SharedColor.greyColor),
              focusedBorder: fieldBorder(SharedColor.greyColor),
              errorBorder: fieldBorder(Colors.red),
              labelText: label,
              labelStyle: SharedFont.subGreyStyle,
              prefixIcon: Icon(icon, color: SharedColor.greyColor, size: 20.0),
              suffixIcon: label == 'Password' ? IconButton(
                icon: isSecuredSignup? Icon(Icons.visibility)  : Icon(Icons.visibility_off) ,
                color: SharedColor.greyColor,
                iconSize: 20.0,
                onPressed: () {
                  isSecuredSignup = !isSecuredSignup;
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



