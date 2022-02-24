import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fooddeliveryapp/Google%20Sheet%20Api/GSheetApi.dart';
import 'package:fooddeliveryapp/Pages/AboutUs.dart';
import 'package:fooddeliveryapp/Pages/CartPage.dart';
import 'package:fooddeliveryapp/Pages/NewLogin.dart';
import 'package:fooddeliveryapp/Pages/SearchPage.dart';
import 'package:fooddeliveryapp/Pages/SignInPage.dart';
import 'package:fooddeliveryapp/Pages/signIn.dart';
import 'package:fooddeliveryapp/Provider/CartItem.dart';
import 'package:fooddeliveryapp/Provider/ModalHudProgress.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'Pages/AddFoodPage.dart';
import 'Pages/Edit.dart';
import 'Pages/MainPage.dart';
import 'Pages/OnBoardingScreens.dart';
import 'Pages/OrderTodays.dart';
import 'Pages/PinCode.dart';
import 'Pages/SignUpPage.dart';
import 'Pages/UpdateFoodPage.dart';
import 'Pages/UserEdit.dart';
import 'Theme/Theme.dart';

// remember me sign in
bool rememberMe = false;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  GSheetApi().init();

  SharedPreferences preferences = await SharedPreferences.getInstance();
  rememberMe = preferences.getBool("rememberMe");

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<CartItems>(
        create: (context) => CartItems(),
      ),
      ChangeNotifierProvider<ModalHudProgress>(
        create: (context) => ModalHudProgress(),
      ),
    ],
    child: ChangeNotifierProvider(
        create: (context) =>
            ThemeProvider(isDarkMode: preferences.getBool("isDarkTheme")),
        child: MyApp()),
  ));
}

class MyApp extends StatelessWidget {
  Future<DocumentSnapshot> checkUser() async {
    final usershopName = await FirebaseFirestore.instance
        .collection('newUser')
        .doc(FirebaseAuth.instance.currentUser.uid)
        .get();
    // print("qwertyuiop" + usershopName['UserName']);
    return usershopName;
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

    return Consumer<ThemeProvider>(builder: (context, themProvider, child) {
      return MaterialApp(
          theme: themProvider.getTheme,
          debugShowCheckedModeBanner: false,
          // OnBoarding open one time
          // initialRoute: FirebaseAuth.instance.currentUser != null
          //     ? checkUser()
          //         ? MainPage.id
          //         : NewLoginPage.id
          //     : SignInScreen.id,
          routes: {
            OnBoardingScreens.id: (context) => OnBoardingScreens(),
            CartPage.id: (context) => CartPage(),
            AboutUs.id: (context) => AboutUs(),
            //       SignInPage.id: (context) => SignInPage(),
            MainPage.id: (context) => MainPage(),
            SignInScreen.id: (context) => const SignInScreen(),
            UserEditPage.id: (context) => UserEditPage(),
            Edit.id: (context) => Edit(),
            AddFoodPage.id: (context) => AddFoodPage(),
            OrderTodays.id: (context) => OrderTodays(),
            UpdateFoodPage.id: (context) => UpdateFoodPage(),
            SearchPage.id: (context) => SearchPage(),
            NewLoginPage.id: (context) => NewLoginPage(),
            PinCodePage.id: (context) => PinCodePage(),
          },
          home: FirebaseAuth.instance.currentUser != null
              ? FutureBuilder(
                  future: checkUser(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else {
                      if (snapshot.data.exists) {
                        try {
                          if (snapshot.data['UserName'].isEmpty ||
                              snapshot.data['UserName'] == null) {
                            return NewLoginPage();
                          } else {
                            return MainPage();
                          }
                        } catch (e) {
                          return NewLoginPage();
                        }
                      } else {
                        return NewLoginPage();
                      }
                    }
                  })
              : const SignInScreen());
    });
  }
}
