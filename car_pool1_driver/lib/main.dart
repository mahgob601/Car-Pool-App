import 'package:car_pool1_driver/models/global_var.dart';
import 'package:car_pool1_driver/HomePage.dart';
import 'package:car_pool1_driver/LoginScreen.dart';
import 'package:car_pool1_driver/ProfilePage.dart';
import 'package:car_pool1_driver/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1_driver/firebase_options.dart';
import 'package:car_pool1_driver/Shared/DBHandler/firebaseAuth.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform,);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: StreamBuilder<User?>(builder: (context,snapshot)
        {
          if(snapshot.hasData)
          {
            firebaseAuthClass().getProfileData(context);
            return HomePage();
          }
          if(snapshot.hasError)
          {
            return Scaffold(
              body: Center(
                child: Text(
                    snapshot.error.toString()
                ),
              ),
            );

          }
          return LoginScreen();
        },stream: FirebaseAuth.instance.authStateChanges(),) ,
        routes: {

          '/login' : (context) => LoginScreen(),
          '/signup' : (context) => SignUpScreen(),
        }
    );
  }
}

