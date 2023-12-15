import 'package:car_pool1/Globals/global_var.dart';
import 'package:car_pool1/HomePage.dart';
import 'package:car_pool1/LoginScreen.dart';
import 'package:car_pool1/ProfilePage.dart';
import 'package:car_pool1/SignupScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:car_pool1/firebase_options.dart';
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
        if(snapshot.hasData || userEmail == 'test@eng.asu.edu.eg')
          {
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

