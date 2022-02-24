import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  static String id = "AboutUs";

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  final String _launchWeb =
      "https://crustfoods.com/"; // change this Url with your site Url
  final String _launchInstagram =
      "https://www.instagram.com/crust_foods/"; // change this Url with your youtube channel link
  final String _launchFacebook =
      "https://www.facebook.com/CrustfoodsKerala/"; // change this Url with your youtube channel link

  // open browser
  Future<void> launchBrowser(String url) async {
    if (await canLaunch(url)) {
      final bool nativeAppLaunchSucceeded = await launch(url,
          forceWebView: false,
          forceSafariVC: false,
          headers: <String, String>{"header_key": "header_value"});

      if (!nativeAppLaunchSucceeded) {
        await launch(url, forceSafariVC: true, forceWebView: true);
      }
    }
  }

  // open youtube app
  Future<void> launchUniversalLink(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: false,
        forceSafariVC: false,
        universalLinksOnly: true,
      );
    } else {
      throw "Could not launch $url";
    }
  }

  // share you app link
  Future<void> shareApp({dynamic link, String title}) async {
    await FlutterShare.share(
        title: title, linkUrl: link, chooserTitle: "where you want to Share");
  }

  // send email
  Future<void> sendEmail(String email) async {
    await launch("mailto: $email");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Color(0xffFFFAEE),
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Who we are?",
                    style: TextStyle(
                        fontSize: 27,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Montserrat"
                        // color: Color(0xff544646),
                        ),
                  ),
                  const Text(
                    "Crust Indian Breads",
                    style:
                        const TextStyle(fontSize: 25, fontFamily: "Montserrat"),
                  ),
                  const Text(
                    "Since 1997 we make people happy with our Service",
                    style: TextStyle(
                        fontSize: 15,
                        color: const Color(0xff707070),
                        fontFamily: "Montserrat"),
                  )
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Text(
              "Information :",
              style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Container(
              child: Row(
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFDB84),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons_FoodApp.resturant,
                        size: 18,
                        color: const Color(0xff544646),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUniversalLink(_launchWeb);
                    },
                    child: const SizedBox(
                      width: 250,
                      child: Text(
                        "www.crustfoods.com",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Row(
              children: [
                Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFDB84),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons_FoodApp.call_us,
                      size: 18,
                      color: const Color(0xff544646),
                    )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () async {
                    const url = "tel:702-541-2595"; // change your phone number
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: const SizedBox(
                    width: 250,
                    child: Text(
                      "702-541-2595",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff707070),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Container(
              child: Row(
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFDB84),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons_FoodApp.email,
                        size: 18,
                        color: const Color(0xff544646),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      sendEmail("crustfoods@gmail.com");
                    },
                    child: const SizedBox(
                      width: 250,
                      child: Text(
                        "crustfoods@gmail.com",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 10, right: 30),
            child: const Text(
              "Social Media :",
              style: const TextStyle(fontSize: 16, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Container(
              child: Row(
                children: [
                  Container(
                      height: 35,
                      width: 35,
                      decoration: BoxDecoration(
                          color: const Color(0xffFFDB84),
                          borderRadius: BorderRadius.circular(30)),
                      child: const Icon(
                        Icons_FoodApp.facebook,
                        size: 18,
                        color: const Color(0xff544646),
                      )),
                  const SizedBox(
                    width: 12,
                  ),
                  GestureDetector(
                    onTap: () {
                      launchUniversalLink(_launchFacebook);
                    },
                    child: const SizedBox(
                      width: 250,
                      child: Text(
                        "facebook/crustfoods",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(0xff707070),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Montserrat"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10, right: 30),
            child: Row(
              children: [
                Container(
                    height: 35,
                    width: 35,
                    decoration: BoxDecoration(
                        color: const Color(0xffFFDB84),
                        borderRadius: BorderRadius.circular(30)),
                    child: const Icon(
                      Icons_FoodApp.instagram,
                      size: 18,
                      color: const Color(0xff544646),
                    )),
                const SizedBox(
                  width: 12,
                ),
                GestureDetector(
                  onTap: () {
                    launchUniversalLink(_launchInstagram);
                  },
                  child: const SizedBox(
                    width: 250,
                    child: Text(
                      "Instagram/crust_foods",
                      style: TextStyle(
                          fontSize: 14,
                          color: Color(0xff707070),
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat"),
                    ),
                  ),
                )
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 20, right: 30),
            child: const Text(
              "We need you to Share About Us, And make us Happy, We appreciate that",
              style: TextStyle(fontSize: 16, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: Container(
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      if (Platform.isAndroid) {
                        shareApp(
                            title: "Crust Indian Breads",
                            link: "         CRUST FOODS\n\n "
                                "Food, from the ancient times to modern age, has always been an important part of human life. Man can not live without it, because it is the basic need of human being. In this modern age, food has become very easy to prepare with the help of technology, and it takes less time to prepare a variety of food than it took in the past. One can easily buy preprocessed food from the market and it saves time. Unfortunately, these canned foods should not replace the healthy food. Healthy food is essential for human being, because it has basic effects on people's life and their behavior."
                                "\n\n     |SPECIALITIES|\n\n"
                                "- 22 Years of Experience. \n\n "
                                "- Imported machineries with Italian technology.\n\n"
                                "- 5 Retail outlets.\n\n"
                                "- Main wholesale in market.\n\n"
                                "- Available all over kerala.\n\n"
                                "- Serve responsibly Sourced Products.\n\n\n"
                                "Website: https://crustfoods.com\n\n" //
                                "Email:  crustfoods@gmail.com\n\n"
                                "Mob: +91 07025412595\n\n"
                                "Crust foods,  Valiyaparamba,\n"
                                "P.O Mampuram\n"
                                "Malapuram Dt.   Kerala,   India." // link your app from playStore
                            );
                      } else if (Platform.isIOS) {
                        shareApp(
                            title: "Crust Indian Breads",
                            link: "         CRUST FOODS\n\n "
                                "Food, from the ancient times to modern age, has always been an important part of human life. Man can not live without it, because it is the basic need of human being. In this modern age, food has become very easy to prepare with the help of technology, and it takes less time to prepare a variety of food than it took in the past. One can easily buy preprocessed food from the market and it saves time. Unfortunately, these canned foods should not replace the healthy food. Healthy food is essential for human being, because it has basic effects on people's life and their behavior."
                                "\n\n     |SPECIALITIES|\n\n"
                                "- 22 Years of Experience. \n\n "
                                "- Imported machineries with Italian technology.\n\n"
                                "- 5 Retail outlets.\n\n"
                                "- Main wholesale in market.\n\n"
                                "- Available all over kerala.\n\n"
                                "- Serve responsibly Sourced Products.\n\n\n"
                                "Website: https://crustfoods.com\n\n" //
                                "Email:  crustfoods@gmail.com\n\n"
                                "Mob: +91 07025412595\n\n"
                                "Crust foods,  Valiyaparamba,\n"
                                "P.O Mampuram\n"
                                "Malapuram Dt.   Kerala,   India." // link your app from AppStore
                            );
                      }
                    },
                    child: Container(
                        height: 45,
                        width: 305,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFDB84),
                            borderRadius: BorderRadius.circular(30)),
                        child: const Icon(
                          Icons_FoodApp.share,
                          size: 19,
                          color: const Color(0xff544646),
                        )),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 30, top: 20, right: 30),
            child: const Text(
              "We Trusted by :",
              style: const TextStyle(fontSize: 16, fontFamily: "Montserrat"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 15, right: 20),
            child: Row(
              children: [
                SizedBox(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset(logo_mcdonalds),
                ),
                const SizedBox(
                  width: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset(logo_kfc),
                ),
                const SizedBox(
                  width: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset(logo_dominosPizza),
                ),
                const SizedBox(
                  width: 25,
                ),
                SizedBox(
                  height: 50,
                  width: 50,
                  child: SvgPicture.asset(logo_pizzaHut),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          )
        ],
      )),
    );
  }
}
