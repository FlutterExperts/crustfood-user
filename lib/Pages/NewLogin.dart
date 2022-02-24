import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fooddeliveryapp/Icons_illustrations/Icons_illustrations.dart';
import 'package:fooddeliveryapp/Pages/PinCode.dart';
import 'package:fooddeliveryapp/Provider/ModalHudProgress.dart';
import 'package:fooddeliveryapp/model/AddShopeNameModel.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class NewLoginPage extends StatefulWidget {
  static String id = "NewLogin";

  @override
  _NewLoginPageState createState() => _NewLoginPageState();
}

class _NewLoginPageState extends State<NewLoginPage> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  FocusNode focusNode = FocusNode();
  String name = "";

  String userName, routes;

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
                  height: 0,
                ),
                SizedBox(
                  height: 260,
                  width: 260,
                  child: SvgPicture.asset(searching),
                ),
                const SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: TextField(
                        controller: controller,
                        focusNode: focusNode,
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                          userName = value;
                        },
                        autocorrect: true,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Montserrat",
                          color: Color(0xff707070),
                        ),
                    decoration: const InputDecoration(
                      icon: Icon(
                        CupertinoIcons.doc_text_search,
                        color: Color(0xffaeaeae),
                      ),
                      counter: Offstage(),
                      hintText: "Enter Shope Name",
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
                      ),
                ),



                SizedBox(
                  height: 450,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: (name != "" && name != null)
                        ? FirebaseFirestore.instance
                            .collection('ShopeNames')
                            .where("searchIndex", arrayContains: name)
                            .snapshots()
                        : FirebaseFirestore.instance
                            .collection("shopeNames")
                            .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<AddShopeNameModel> _addShopeNameModel = [];
                        for (var doc in snapshot.data.docs) {
                          var data = doc.data();

                          _addShopeNameModel.add(AddShopeNameModel(
                            shopename: data["ShopeName"],
                          ));
                        }
                        return GridView.builder(
                            padding: const EdgeInsets.only(
                                left: 20, right: 20, top: 10, bottom: 50),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1, childAspectRatio: 4.90),
                            itemCount: snapshot.data.docs.length,
                            itemBuilder: (context, index) {
                              DocumentSnapshot data = snapshot.data.docs[index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    focusNode.unfocus();
                                    controller.text = data["ShopeName"];
                                  });

                                  Navigator.of(context).pushAndRemoveUntil(
                                      MaterialPageRoute(
                                        builder: (context) => PinCodePage(
                                          requiredNumber: data["pincode"],
                                          shopName: data["ShopeName"],
                                          route: data["Routes"],
                                        ),
                                      ),
                                      (Route<dynamic> route) => false);
                                },
                                child: Card(
                                  elevation: 3,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          data.data()["ShopeName"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontFamily: "Montserrat"),
                                        ),
                                        Text(
                                          data.data()["Routes"],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 10,
                                              fontFamily: "Montserrat"),
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
                    },
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
