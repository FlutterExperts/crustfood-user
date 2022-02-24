import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/Firebase/FBAuth.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:fooddeliveryapp/Provider/ModalHudProgress.dart';
import 'package:fooddeliveryapp/Widgets/DropDownMenu.dart';
import 'package:fooddeliveryapp/model/DropDownMenuModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

import 'MainPage.dart';

class SignUpPage extends StatefulWidget {
  static String id = "SignUp";

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController(text: "+91");

  final _auth = FBAuth();

  String userName, phoneNumber, routes, email_signUp, password_signUp;
  final List<DropDownMenuModel> _routesNumberList = [
    DropDownMenuModel(routesNum: 'Trissur town'),
    DropDownMenuModel(routesNum: 'Guruvayoor - trpryar'),
    DropDownMenuModel(routesNum: 'Kannur - thalasseri'),
    DropDownMenuModel(routesNum: 'Thaliparambu - kaserkod'),
    DropDownMenuModel(routesNum: 'Manjeri - wandoor'),
    DropDownMenuModel(routesNum: 'Kondotty - nilambur'),
    DropDownMenuModel(routesNum: 'M.collage - Thamarasseri'),
    DropDownMenuModel(routesNum: 'Vadakara - nadapuram'),
    DropDownMenuModel(routesNum: 'Vengara - malappuram'),
    DropDownMenuModel(routesNum: 'Tirur - ponnani'),
    DropDownMenuModel(routesNum: 'Pattambi - tirurangadi'),
    DropDownMenuModel(routesNum: 'Calicut town-karaparambu'),
    DropDownMenuModel(routesNum: 'Calicut Beach - nadakkav'),
    DropDownMenuModel(routesNum: 'Perinthalmanna - mannarkad'),
    DropDownMenuModel(routesNum: 'Local roots'),
  ];
  DropDownMenuModel _dropDownMenuModel = DropDownMenuModel();
  List<DropdownMenuItem<DropDownMenuModel>> _routesNumberModelDropdownList;
  List<DropdownMenuItem<DropDownMenuModel>> _buildPersonNumModelDropdown(
      List personList) {
    List<DropdownMenuItem<DropDownMenuModel>> items = List();
    for (DropDownMenuModel routes in personList) {
      items.add(DropdownMenuItem(
        value: routes,
        child: Row(
          children: [
            const Icon(
              Icons.place,
              color: Colors.black,
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              routes.routesNum,
              style: const TextStyle(
                color: Colors.black,
                fontFamily: "Montserrat",
              ),
            ),
          ],
        ),
      ));
    }
    return items;
  }

  _onChangeFavouriteAddressModelDropdown(DropDownMenuModel dropDownMenuModel) {
    setState(() {
      _dropDownMenuModel = dropDownMenuModel;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _routesNumberModelDropdownList =
        _buildPersonNumModelDropdown(_routesNumberList);
    _dropDownMenuModel = _routesNumberList[0];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ModalProgressHUD(
        inAsyncCall: Provider.of<ModalHudProgress>(context).isLoading,
        child: Form(
          key: _globalKey,
          child: SafeArea(
              child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 220,
                  width: 220,
                  child: SvgPicture.asset(signUp),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 67,
                    width: MediaQuery.of(context).size.width,
                    child: TextFormField(
                      keyboardType: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "UserName is empty";
                          // ignore: missing_return
                        }
                      },
                      onSaved: (value) {
                        userName = value;
                      },
                      style: const TextStyle(
                        fontSize: 16,
                        fontFamily: "Montserrat",
                        color: const Color(0xff707070),
                        // color: Color(0xff544646)
                      ),
                      decoration: InputDecoration(
                        hintText: "Shop Name",
                        contentPadding: const EdgeInsets.only(left: 20),
                        fillColor: Colors.white,
                        hintStyle: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Colors.black, width: 2.0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                            gapPadding: 10),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 20),
                  child: const Text(
                    "Enter Phone Number With Code of Your Country",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff707070),
                      fontFamily: "Montserrat",
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 67,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: TextFormField(
                        controller: controller,
                        keyboardType: TextInputType.phone,
                        maxLength: 15,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Phone Number is empty";
                            // ignore: missing_return
                          }
                        },
                        onSaved: (value) {
                          phoneNumber = value;
                        },
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: "Montserrat",
                          color: Color(0xff707070),
                        ),
                        decoration: InputDecoration(
                          hintText: "Phone Number",
                          contentPadding: const EdgeInsets.only(left: 20),
                          hintStyle: const TextStyle(
                            fontSize: 16,
                            fontFamily: "Montserrat",
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.black, width: 2.0),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.circular(10),
                              gapPadding: 10),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                DropDownMenu(
                  dropdownMenuItemList: _routesNumberModelDropdownList,
                  onChanged: _onChangeFavouriteAddressModelDropdown,
                  value: _dropDownMenuModel,
                  isEnabled: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value.isEmpty) {
                        return "Email is empty";
                        // ignore: missing_return
                      }
                    },
                    onSaved: (value) {
                      email_signUp = value;
                    },
                    autocorrect: true,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Montserrat",
                      color: Color(0xff707070),
                      // color: Color(0xff544646)
                    ),
                    decoration: const InputDecoration(
                        hintText: "Email",
                        contentPadding: EdgeInsets.only(left: 20),
                        hintStyle: const TextStyle(
                          fontSize: 17,
                          fontFamily: "Montserrat",
                          fontWeight: FontWeight.bold,
                        ),
                        border: InputBorder.none),
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SizedBox(
                    height: 67,
                    width: MediaQuery.of(context).size.width,
                    child: Center(
                      child: TextFormField(
                        keyboardType: TextInputType.visiblePassword,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "Password is empty";
                            // ignore: missing_return
                          }
                        },
                        onSaved: (value) {
                          password_signUp = value;
                        },
                        obscureText: true,
                        autocorrect: true,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: const Color(0xff707070),
                          // color: Color(0xff544646)
                        ),
                        decoration: const InputDecoration(
                            hintText: "Password",
                            contentPadding: EdgeInsets.only(left: 20),
                            hintStyle: const TextStyle(
                                fontSize: 17, fontFamily: "Montserrat"),
                            border: InputBorder.none),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                Builder(
                  builder: (context) => GestureDetector(
                    onTap: () async {
                      final modalHud =
                          Provider.of<ModalHudProgress>(context, listen: false);
                      modalHud.changeIsLoading(true);

                      if (_globalKey.currentState.validate()) {
                        // sign up user info to firebase auth
                        try {
                          _globalKey.currentState.save();
                          try {
                            await _auth.signUp(
                                email_signUp,
                                password_signUp,
                                userName,
                                phoneNumber,
                                _dropDownMenuModel.routesNum);
                          } catch (e) {}
                          modalHud.changeIsLoading(false);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainPage()),
                              (route) => false);
                        } catch (e) {
                          modalHud.changeIsLoading(false);
                          Scaffold.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.black,
                            content: Text(
                              e.message,
                              style: const TextStyle(
                                  color: const Color(0xffFFDB84)),
                            ),
                            duration: const Duration(seconds: 5),
                          ));
                        }
                      }
                      modalHud.changeIsLoading(false);
                    },
                    child: Container(
                      height: 50,
                      width: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffFFDB84)),
                      child: const Center(
                        child: const Text(
                          "Sign Up",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Montserrat"),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        ),
      ),
    );
  }
}
