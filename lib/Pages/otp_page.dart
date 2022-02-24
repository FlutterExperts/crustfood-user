import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/Pages/NewLogin.dart';
import 'package:lottie/lottie.dart';

import '../Icons_illustrations/Icons_illustrations.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({Key key, @required this.phoneNumber}) : super(key: key);
  final String phoneNumber;

  @override
  _OtpScreenState createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  bool isloading;
  String verificationCode;
  final List<TextEditingController> controllers = [];
  final List<FocusNode> focusNodes = [];
  FirebaseAuth _firebaseAuth;
  @override
  void initState() {
    isloading = true;
    _firebaseAuth = FirebaseAuth.instance;
    _firebaseAuth.verifyPhoneNumber(
      phoneNumber: widget.phoneNumber,
      verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
        isloading = false;
      },
      verificationFailed: (FirebaseAuthException authException) async {
        debugPrint(authException.message);
        setState(() {
          isloading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Mobile Number Verification Failed"),
          ),
        );
      },
      codeSent: (String verificationID, resendingToken) async {
        setState(() {
          verificationCode = verificationID;
          isloading = false;
        });
      },
      codeAutoRetrievalTimeout: (verificationID) {},
    );
    buildTextBox();

    super.initState();
  }

  void buildTextBox() {
    for (var i = 0; i < 6; i++) {
      controllers.add(
        TextEditingController(),
      );
      focusNodes.add(FocusNode());
    }
  }

  void signInWithCridential(PhoneAuthCredential phoneAuthCredential) async {
    setState(() {
      isloading = true;
    });
    try {
      final UserCredential authCredential =
          await _firebaseAuth.signInWithCredential(phoneAuthCredential);
      if (authCredential.user != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewLoginPage(),
            ));
      }
    } on Exception catch (e) {
      setState(() {
        isloading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Incorrect pin or Login failed"),
        ),
      );

      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            )
          : SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 40),
                      Center(
                        child: Container(
                            height: 280,
                            width: 280,
                            child: SvgPicture.asset(enter_otp)),
                      ),
                      const SizedBox(height: 100),

                      const Text(
                        "Enter code send\nto your phone",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        widget.phoneNumber,
                        style: TextStyle(
                          color: Colors.grey.shade400,
                          fontSize: 16,
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          6,
                          (index) => Container(
                            width: 45,
                            height: 65,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: const Color(0xfff2f2f2),
                            ),
                            child: TextField(
                              maxLength: 1,
                              focusNode: focusNodes[index],
                              controller: controllers[index],
                              textAlignVertical: TextAlignVertical.center,
                              textAlign: TextAlign.center,
                              cursorColor: Colors.black,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontFamily: "Poppins",
                              ),
                              keyboardType: TextInputType.number,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.zero,
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                counter: Offstage(),
                              ),
                              onChanged: (value) {
                                if (index == 5) {
                                  if (value.isEmpty) {
                                    focusNodes[index].previousFocus();
                                  } else {
                                    focusNodes[index].unfocus();
                                    String _pincode = controllers[0].text;
                                    for (var i = 1; i < 6; i++) {
                                      _pincode = _pincode + controllers[i].text;
                                    }
                                    if (_pincode.length == 6) {
                                      final PhoneAuthCredential
                                          phoneAuthCredential =
                                          PhoneAuthProvider.credential(
                                              verificationId: verificationCode,
                                              smsCode: _pincode);
                                      signInWithCridential(phoneAuthCredential);
                                    }
                                    // if (_pincode == '2525') {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //         builder: (context) =>
                                    //             const VerifiedPage(),
                                    //       ));
                                    // }
                                  }
                                } else {
                                  if (value.isNotEmpty) {
                                    focusNodes[index + 1].requestFocus();
                                  } else {
                                    if (index != 0) {
                                      focusNodes[index].previousFocus();
                                    }
                                  }
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 40),
                      RichText(
                        text: const TextSpan(
                          text: "Didn't get code,",
                          style: TextStyle(
                            fontSize: 16,
                            color: Color(0xffb0b0b0),
                            fontFamily: "Poppins",
                          ),
                          children: [
                            TextSpan(
                              text: ' resend',
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 16,
                                color: CupertinoColors.activeBlue,
                              ),
                            ),
                          ],
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
