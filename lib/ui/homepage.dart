import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:simple_animations/simple_animations.dart';
import 'package:shopping_app/account/account.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String url = "https://www.finlage.in/upi-pay/00003D6";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.account_circle_outlined),
          color: Colors.orange,
          iconSize: 40.0,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Account(),
              ),
            );
          },
        ),
        title: Padding(
          padding: EdgeInsets.fromLTRB(60, 0, 0, 0),
          child: Text(
            "FashDeal",
            style: GoogleFonts.greatVibes(
                textStyle: TextStyle(fontSize: 40, color: Colors.orange)),
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 2.0,
      ),
      body: Stack(children: [
        Container(
          decoration: BoxDecoration(
            color: Color(0xff000000),
            backgroundBlendMode: BlendMode.srcOver,
          ),
          child: PlasmaRenderer(
            type: PlasmaType.infinity,
            particles: 20,
            color: Color(0x34ffa300),
            blur: 0.5,
            size: 0.49,
            speed: 3.916667302449544,
            offset: 0,
            blendMode: BlendMode.plus,
            particleType: ParticleType.atlas,
            variation1: 0,
            variation2: 0,
            variation3: 0,
            rotation: 0,
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 5.0, top: 5),
                child: Container(
                  color: Colors.white.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 50,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/shirt.png'))),
                                  Container(
                                      child: Text(
                                    "All",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            onTap: () {
                              print("Clicked");
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 50,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/mens.png'))),
                                  Container(
                                      child: Text(
                                    "Men's",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/men');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 50,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image:
                                              AssetImage('assets/womens.png'))),
                                  Container(
                                    child: Text(
                                      "Women's",
                                      style: TextStyle(
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/women');
                            },
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: GestureDetector(
                            child: Container(
                              // width: 60,
                              // height: 50,
                              child: Column(
                                children: [
                                  Container(
                                      width: 30,
                                      height: 30,
                                      child: Image(
                                          image: AssetImage(
                                              'assets/children.png'))),
                                  Container(
                                      child: Text(
                                    "Children's",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                    ),
                                  )),
                                ],
                              ),
                            ),
                            onTap: () {
                              Navigator.pushNamed(context, '/child');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                    ),
                    child: Center(
                      child: Text(
                        "-   Fashion is Life   -",
                        style: GoogleFonts.orbitron(
                            textStyle: TextStyle(fontSize: 35)),
                      ),
                    ),
                  ),
                ],
              ),

              StreamBuilder(
                stream: firestore.collection("user").snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                        return Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: ListTile(
                              tileColor: Colors.black.withOpacity(0.6),
                              title: Text(
                                document.data()["ItemName"],
                                style: TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 23),
                              ),
                              subtitle: Text(
                                document.data()["Description"] ?? "No Data",
                                style: TextStyle(color: Colors.white),
                              ),
                              trailing: Container(
                                height: 35,
                                width: 70,
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white)),
                                child: Center(
                                  child: Text(
                                    document.data()["Price"] ?? "No Data",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.orange),
                                  ),
                                ),
                              ),
                              leading: CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  document.data()["Image"] ?? "No Data",
                                ),
                              ),
                              onTap: () {
                                return showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        backgroundColor:
                                            Colors.black.withOpacity(0.8),
                                        title: Text(
                                          document.data()["ItemName"],
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 30,
                                              color: Colors.orange),
                                        ),
                                        content: Column(
                                          children: [
                                            Container(
                                              height: 220,
                                              width: 220,
                                              color: Colors.black,
                                              child: Image(
                                                  image: NetworkImage(document
                                                      .data()["Image"])),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: Colors.white,
                                                      width: 3)),
                                              height: 50,
                                              width: 220,
                                              //color: Colors.blue,
                                              child: Center(
                                                child: Text(
                                                  document.data()["Price"],
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.orange,
                                                      fontSize: 25),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: ElevatedButton(
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          padding:
                                                              EdgeInsets
                                                                  .fromLTRB(
                                                                      30,
                                                                      40,
                                                                      30,
                                                                      40),
                                                          primary:
                                                              Colors.orange),
                                                  onPressed: () {},
                                                  child: Text(
                                                    "WishList",
                                                    style: TextStyle(
                                                        fontSize: 30,
                                                        color: Colors.black),
                                                  )),
                                            ),
                                            ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    primary: Colors.orange),
                                                onPressed: () {},
                                                child: Text("Buy")),
                                          ],
                                        ),
                                      );
                                    });
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  } else {
                    return Container();
                  }
                },
              )
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Container(
              //     height: 30,
              //     width: 30,
              //     color: Colors.black,
              //   ),
              // )
            ],
          ),
        ),
      ]),
    );
  }
}
