import 'package:flutter/material.dart';
import 'package:healthbook/screens/patient_prescription/widgets/patient_prescription.dart';
import 'package:healthbook/screens/register_user_data/register_user_data.dart';
import 'package:healthbook/screens/sing_In_and_Up/sign_in_and_up_screen.dart';
import 'package:healthbook/screens/specific_search/map.dart';

import 'package:provider/provider.dart';

import './screens/main_screen.dart';
import './providers/auth_controller.dart';
import './screens/chat_screen.dart';
import 'screens/forget_password/forget_password.dart';
import 'screens/forget_password/send_sms_screen.dart';
import 'screens/user_profile/patient_health_record.dart';
import 'screens/user_profile/user_profile.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: Auth()),
      ],
      child: Consumer<Auth>(
        builder: (ctx, auth, child) => MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Health Book',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            accentColor: Colors.white,
            cardTheme: CardTheme(
              color: Colors.white,
              margin: EdgeInsets.symmetric(horizontal: 20),
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: const BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
            ),
            appBarTheme: AppBarTheme(
              textTheme: TextTheme(
                  title: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 19)),
              color: Colors.black.withOpacity(0.1),
              iconTheme: IconThemeData(
                color: Colors.blue,
              ),
            ),
            textTheme: ThemeData.light().textTheme.copyWith(
                display1: TextStyle(
                    fontSize: 19,
                    color: Colors.black87,
                    fontWeight: FontWeight.bold),
                display2: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
                display3: TextStyle(
                    fontSize: 18,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
                body2: TextStyle(
                    fontSize: 19,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold),
                body1: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                title: TextStyle(
                    fontSize: 20,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold)),
          ),
          routes: {
//            ChatScreen.routeName: (ctx) => ChatScreen(),
            Login.routeName: (ctx) => Login(),
            HomeScreen.routeName: (ctx) => HomeScreen(),
            SendSms.routeName: (ctx) => SendSms(),
            ForgetPassword.routeName: (ctx) => ForgetPassword(),
            PatientHealthRecord.routeName: (ctx) => PatientHealthRecord(),
            UserProfile.routeName: (ctx) => UserProfile(),
            GetUserLocation.routeName:(ctx) =>GetUserLocation(),
            RegisterUserData.routeName:(ctx) =>RegisterUserData(),
            PatientPrescription.routeName:(ctx) =>PatientPrescription()

          },
          home: Login(),
         // UserSignUp()
          //HomeScreen(),
//          home: auth.isAuth
//              ? HomeScreen()
//              : FutureBuilder(
//                  future: auth.tryToLogin(),
//                  builder: (ctx, authResultSnapshot) {
//                    if (authResultSnapshot.connectionState ==
//                        ConnectionState.done && auth.isAuth) {
//                      return HomeScreen();
//                    } else if (authResultSnapshot.connectionState ==
//                        ConnectionState.waiting ||
//                        authResultSnapshot.connectionState ==
//                            ConnectionState.active && !auth.isAuth) {
//                      return Splash();
//                    } else{
//                      return Login();
//                    }
//                  }
//                  ),
        ),
      ),
    );
  }
}
