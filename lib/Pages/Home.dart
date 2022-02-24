// ignore_for_file: unnecessary_const

import 'dart:async';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/Firebase/DBFireStore.dart';
import 'package:fooddeliveryapp/Firebase/FBAuth.dart';
import 'package:fooddeliveryapp/GlobalVariable/GlobalVariable.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:fooddeliveryapp/Pages/AboutUs.dart';
import 'package:fooddeliveryapp/Pages/SearchPage.dart';
import 'package:fooddeliveryapp/Pages/UserEdit.dart';
import 'package:fooddeliveryapp/Pages/signIn.dart';
import 'package:fooddeliveryapp/Provider/CartItem.dart';
import 'package:fooddeliveryapp/Theme/Theme.dart';
import 'package:fooddeliveryapp/model/foodModel.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PinCode.dart';
import 'SignInPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _dbFireStore = DBFireStore();
  final FBAuth fbAuth = FBAuth();
  List<FoodModel> _list = [];
  bool drawerCanOpen = true;
  List<TextEditingController> textEditingController = [];

  bool themeSwitch = false;
  List<int> listQty = [];

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  var uid;

  Future<DocumentSnapshot> getUserInfo() async {
    final _auth = FirebaseAuth.instance;

    final User user = _auth.currentUser;
    uid = user.uid;

    print("User UID : $uid");

    FirebaseFirestore _firestore = FirebaseFirestore.instance;

    await _firestore.collection("newUser").doc(uid).get().then((value) {
      snapshot = value;
    });
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);
    setState(() {
      getUserInfo();
    });

    return FutureBuilder(
        future: getUserInfo(),
        builder: (context, AsyncSnapshot snapshotfire) {
          if (snapshotfire.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            return DefaultTabController(
                length: 6,
                child: Scaffold(
                  key: scaffoldKey,
                  drawer: SizedBox(
                    width: 280,
                    child: Drawer(
                      child: ListView(
                        padding: const EdgeInsets.all(0),
                        children: <Widget>[
                          SizedBox(
                            height: 160,
                            child: DrawerHeader(
                              decoration: const BoxDecoration(),
                              child: Row(
                                children: <Widget>[
                                  Container(
                                    height: 60,
                                    width: 60,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(100)),
                                    child: Image.asset("assets/icons/man.png"),
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        width: 160,
                                        child: Text(
                                          snapshotfire.data['UserName'],
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                            fontFamily: "Montserrat",
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        snapshotfire.data['Routes'],
                                        style: const TextStyle(
                                            fontFamily: "Montserrat"),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                          const Divider(
                            height: 1.0,
                            thickness: 1.0,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons_FoodApp.search,
                              size: 25,
                            ),
                            title: const Text(
                              'Search',
                              style: TextStyle(
                                  fontSize: 18, fontFamily: "Montserrat"),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, SearchPage.id);
                            },
                          ),
                          ListTile(
                            leading: themeSwitch
                                ? Icon(
                              Icons_FoodApp.dark_mode,
                              size: 25,
                            )
                                : Icon(
                              Icons_FoodApp.white_mode,
                              size: 25,
                            ),
                            title: Text(
                              'Switch Theme',
                              style:
                              TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                            ),
                            onTap: () {
                              setState(() {
                                themeSwitch = !themeSwitch;
                                themeProvider.swapTheme();
                              });
                            },
                          ),
                          ListTile(
                            leading: Icon(
                              Icons_FoodApp.resturant,
                              size: 25,
                            ),
                            title: Text(
                              'About Us',
                              style:
                              TextStyle(fontSize: 18, fontFamily: "Montserrat"),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, AboutUs.id);
                            },
                          ),
                          ListTile(
                            leading: const Icon(
                              Icons_FoodApp.logout,
                              size: 25,
                              color: Colors.redAccent,
                            ),
                            title: const Text(
                              'Sign Out',
                              style: const TextStyle(
                                  color: Colors.redAccent,
                                  fontSize: 18,
                                  fontFamily: "Montserrat"),
                            ),
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      BackdropFilter(
                                        filter: ImageFilter.blur(
                                            sigmaX: 4, sigmaY: 4),
                                        child: AlertDialog(
                                          title: const Text(
                                            "Sign Out",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              fontFamily: "Montserrat",
                                            ),
                                          ),
                                          content: const Text(
                                            "are you sure?",
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontFamily: "Montserrat",
                                              color: Color(0xff707070),
                                            ),
                                          ),
                                          shape: const RoundedRectangleBorder(
                                            borderRadius:
                                                const BorderRadius.all(
                                              const Radius.circular(15),
                                            ),
                                          ),
                                          actions: <Widget>[
                                            ElevatedButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(false);
                                                },
                                                child: const Text(
                                                  "NO",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff707070),
                                                      fontFamily: "Montserrat"),
                                                )),
                                            ElevatedButton(
                                                onPressed: () async {
                                                  SharedPreferences prefs =
                                                      await SharedPreferences
                                                          .getInstance();
                                                  prefs.clear();
                                                  await fbAuth.signOut();
                                                  Navigator
                                                      .pushNamedAndRemoveUntil(
                                                          context,
                                                          SignInScreen.id,
                                                          (route) => false);
                                                },
                                                child: const Text(
                                                  "YES",
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Color(0xff707070),
                                                      fontFamily: "Montserrat"),
                                                ))
                                          ],
                                        ),
                                      ));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  appBar: PreferredSize(
                    preferredSize: const Size.fromHeight(180),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: AppBar(
                        elevation: 0,
                        automaticallyImplyLeading: false,
                        flexibleSpace: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(top: 25),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 25, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      "Crust Foods",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 35,
                                          fontFamily: "Montserrat"
                                          // color: Color(0xff544646),
                                          ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (drawerCanOpen) {
                                          scaffoldKey.currentState.openDrawer();
                                        } else {}
                                      },
                                      child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black
                                                    .withOpacity(0.05),
                                                spreadRadius: 3,
                                                blurRadius: 4,
                                                offset: const Offset(0,
                                                    2), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                          child: const Icon(
                                            Icons.menu,
                                            size: 19,
                                            color: Colors.black,
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TabBar(
                              isScrollable: true,
                              indicatorWeight: 6,
                              indicatorSize: TabBarIndicatorSize.label,
                              indicator: const UnderlineTabIndicator(
                                borderSide: BorderSide(
                                  color: Colors.black,
                                  width: 4,
                                ),
                                insets: EdgeInsets.symmetric(horizontal: 30),
                              ),
                              labelPadding: const EdgeInsets.all(13),
                              tabs: <Widget>[
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_Bun,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_Breads,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_PizzaBase,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_Rusks,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_Cookies,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                                Tab(
                                  child: SvgPicture.asset(
                                    icon_cake,
                                    height: 60,
                                    width: 60,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  body: TabBarView(children: [
                    foodView("Bun"),
                    foodView("Breads"),
                    foodView("Kuboos"),
                    foodView("PizzaBase"),
                    foodView("Cookies"),
                    foodView("Toast"),
                  ]),
                ));
          }
        });
  }

  Widget foodView(String nameCategory) {
    return StreamBuilder<QuerySnapshot>(
        stream: _dbFireStore.loadFoods(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<FoodModel> _foodModel = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();

              _foodModel.add(FoodModel(
                image: data["foodImage"],
                title: data["foodTitle"],
                shortname: data["foodshortname"],
                price: data["foodPrice"],
                category: data["foodCategory"],
              ));
            }
            _list = [..._foodModel];
            _foodModel.clear();
            _foodModel = getFoodByCategory(nameCategory);
            return GridView.builder(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 10, bottom: 100),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 0.50),
                itemCount: _foodModel.length,
                itemBuilder: (context, index) {
                  listQty.add(1);
                  textEditingController.add(TextEditingController(text: "1"));
                  return GestureDetector(
                    onTap: () {
                      // Navigator.pushNamed(context, FoodDetails.id);
                    },
                    child: Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CachedNetworkImage(
                              imageUrl: _foodModel[index].image,
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(
                                backgroundColor: Colors.black,
                              ),
                              height: 100,
                              width: 100,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: 130,
                              child: Text(
                                _foodModel[index].title,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    // color: Color(0xff544646),
                                    fontSize: 15,
                                    fontFamily: "Montserrat"),
                              ),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Text(
                              "\₹${_foodModel[index].price}",
                              style: const TextStyle(
                                  color: const Color(0xff0A9400),
                                  fontSize: 20,
                                  fontFamily: "Montserrat"),
                            ),
                            const SizedBox(
                              height: 7,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal:
                                      MediaQuery.of(context).size.width * 0.10),
                              child: SizedBox(
                                height: 35,
                                child: TextField(
                                  keyboardType: TextInputType.number,
                                  controller: textEditingController[index],
                                  textAlign: TextAlign.center,
                                  onChanged: (value) {
                                    setState(
                                      () {},
                                    );
                                  },
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontFamily: "Montserrat"),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      addToCart(
                                          context,
                                          _foodModel[index],
                                          index,
                                          int.tryParse(textEditingController[
                                                          index]
                                                      .text
                                                      .isEmpty ||
                                                  textEditingController[index]
                                                          .text ==
                                                      "0"
                                              ? 1
                                              : textEditingController[index]
                                                  .text));
                                    },
                                    child: SizedBox(
                                      height: 50,
                                      width: 130,
                                      child: Card(
                                        elevation: 3,
                                        color: Colors.white,
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(12)),
                                        child: Container(
                                          alignment: Alignment.center,
                                          child: const Text(
                                            "add to cart",
                                            style: const TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: "Montserrat",
                                                color: Colors.black),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
                child: SpinKitRipple(
              size: 70,
              color: Color(0xffFFDB84),
            ));
          }
        });
  }

  Future<void> addToCart(
    context,
    FoodModel fdModel,
    int index,
    int quantity,
  ) async {
    CartItems cartItem = Provider.of<CartItems>(context, listen: false);
    fdModel.quantity = quantity;
    bool exist = false;
    var foodInCart = cartItem.foodModel;
    for (var fdInCart in foodInCart) {
      if (fdInCart.title == fdModel.title) {
        exist = true;
      }
    }
    if (exist) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            Timer(const Duration(seconds: 1), () {
              Navigator.pop(context);
            });
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: const AlertDialog(
                title: const Icon(
                  Icons_FoodApp.order_success,
                  size: 35,
                  color: Colors.redAccent,
                ),
                content: Text(
                  "this food is already in cart",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    color: Colors.redAccent,
                  ),
                ),
              ),
            );
          });
    } else {
      // save each order food to google sheet

      // final int id = await GSheetApi.getRowCount() + 1;

      cartItem.addFood(fdModel);

      setState(() {});

      showDialog(
          context: context,
          builder: (BuildContext context) {
            Timer(const Duration(milliseconds: 400), () {
              Navigator.pop(context);
            });
            return BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
              child: const AlertDialog(
                title: const Icon(
                  Icons_FoodApp.order_success,
                  size: 35,
                  color: Colors.green,
                ),
                content: Text(
                  "Added To Cart",
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontFamily: "Montserrat",
                    color: Color(0xff707070),
                  ),
                ),
              ),
            );
          });
    }
  }

  List<FoodModel> getFoodByCategory(String foodCategory) {
    List<FoodModel> _foodModel = [];
    try {
      for (var food in _list) {
        if (food.category == foodCategory) {
          _foodModel.add(food);
        }
      }
    } on Error catch (ex) {
      print(ex);
    }
    return _foodModel;
  }
}
