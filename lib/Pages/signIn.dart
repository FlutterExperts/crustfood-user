import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Icons_illustrations/Icons_illustrations.dart';
import 'otp_page.dart';

class SignInScreen extends StatefulWidget {
  static String id = "newsignin";
  const SignInScreen({Key key}) : super(key: key);

  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final FocusNode _focusNode = FocusNode();
  final TextEditingController textEditingController = TextEditingController();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30),
                 Center(
                   child: Container(
                      height: 260,
                      width: 260,
                      child: SvgPicture.asset(phone_number)),
                 ),
                SizedBox(height: 70),
                const Text(
                  "Enter your \nphone number",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: "Poppins",
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  cursorColor: const Color(0xffaeaeae),
                  controller: textEditingController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  maxLength: 10,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontFamily: "Poppins",
                  ),
                  decoration: const InputDecoration(
                    icon: Icon(
                      CupertinoIcons.phone,
                      color: Color(0xffaeaeae),
                    ),
                    counter: Offstage(),
                    hintText: "Mobile Number",
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffaeaeae),
                      ),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                        color: Color(0xffaeaeae),
                      ),
                    ),
                    hintStyle: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xffaeaeae),
                      fontSize: 20,
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length == 10) {
                      _focusNode.unfocus();
                    }
                  },
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => OtpScreen(
                                phoneNumber: "+91${textEditingController.text}",
                              ))),
                  child: Center(
                    child: Container(
                      width: double.maxFinite,
                      height: 60,
                      margin: EdgeInsets.only(top: 50, bottom: 50),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color(0xff1bca8b),
                      ),
                      child: const Center(
                        child: Text(
                          "Continue",
                          style: TextStyle(
                            fontFamily: "Poppins",
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const Center(
                  child: Text(
                    "After login you will redirected to\n A search screen if you have approved",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      color: Color(0xffaeaeae),
                      fontSize: 14,
                      letterSpacing: 0.14,
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
