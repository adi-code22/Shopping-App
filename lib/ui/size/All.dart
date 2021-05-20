import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:favorite_button/favorite_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class All extends StatefulWidget {
  final String category;

  const All({Key key, @required this.category}) : super(key: key);
  @override
  _AllState createState() => _AllState(category);
}

class _AllState extends State<All> {
  final String category;

  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  final CollectionReference cref = FirebaseFirestore.instance
      .collection(FirebaseAuth.instance.currentUser.email);

  _AllState(this.category);
  @override
  Widget build(BuildContext context) {
    final User _auth = auth.currentUser;
    String _email = _auth.email;
    return Scaffold(
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
      StreamBuilder(
          stream: firestore.collection("user").snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView(
                shrinkWrap: true,
                children: snapshot.data.docs.map((DocumentSnapshot document) {
                  if (document.data()["Category"] == category) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ListTile(
                          onTap: () {
                            return showDialog(
                                context: context,
                                builder: (context) {
                                  //bool fav = false;
                                  String temp = document.data()["ItemName"];
                                  bool dec;
                                  var deca = FirebaseFirestore.instance
                                      .collection(_email)
                                      .doc(temp)
                                      .get()
                                      .then((doc) {
                                    if (doc.data()["fav"] == true) {
                                      setState(() {
                                        dec = true;
                                      });
                                      print(dec);
                                    } else {
                                      setState(() {
                                        dec = false;
                                      });
                                      print(dec);
                                    }
                                  });
                                  // .snapshots()
                                  // .map((DocumentSnapshot document) {})
                                  // .toList();

                                  return AlertDialog(
                                    backgroundColor:
                                        Colors.black.withOpacity(0.8),
                                    title: Text(
                                      document.data()["ItemName"] +
                                              " - " +
                                              document.data()["Size"] ??
                                          "No Data",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30,
                                          color: Colors.orange),
                                    ),
                                    content: SingleChildScrollView(
                                      child: Column(
                                        children: [
                                          Container(
                                            height: 220,
                                            width: 220,
                                            color: Colors.black,
                                            child: Image(
                                                image: NetworkImage(
                                                    document.data()["Image"])),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: Colors.white,
                                                    width: 3)),
                                            height: 50,
                                            width: 220,
                                            //color: Colors.blue,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Center(
                                                  child: Text(
                                                    document.data()["Price"],
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        color: Colors.orange,
                                                        fontSize: 25),
                                                  ),
                                                ),
                                                FavoriteButton(
                                                  isFavorite: dec,
                                                  valueChanged: (fav) {
                                                    fav = !fav;
                                                    if (fav = true) {
                                                      _addFav(_email, temp);
                                                      print(fav.toString() +
                                                          temp);
                                                    } else {
                                                      String temp = document
                                                          .data()["ItemName"];
                                                      _removeFav(_email, temp);
                                                      print("False");
                                                    }
                                                  },
                                                  iconColor: Colors.orange,
                                                )
                                              ],
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              document.data()["Description"],
                                              style: TextStyle(
                                                  color: Colors.orange),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            85, 10, 85, 10),
                                                    primary: Colors.orange),
                                                onPressed: () {
                                                  //_launchURL(url);
                                                },
                                                child: Text(
                                                  "Buy",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black),
                                                )),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            65, 10, 65, 10),
                                                    primary: Colors.orange),
                                                onPressed: () {},
                                                child: Text(
                                                  "Cancel",
                                                  style: TextStyle(
                                                      fontSize: 30,
                                                      color: Colors.black),
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          isThreeLine: true,
                          tileColor: Colors.black.withOpacity(0.6),
                          title: Text(
                            document.data()["ItemName"] ?? "No Data",
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                document.data()["Description"] ?? "No Data",
                                style: TextStyle(color: Colors.white),
                              ),
                              Text(
                                document.data()["Size"],
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                              ),
                            ],
                          ),
                          trailing: Container(
                            height: 35,
                            width: 80,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.white)),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(1.0),
                                child: Text(
                                  document.data()["Price"] ?? "No Data",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.orange),
                                ),
                              ),
                            ),
                          ),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: NetworkImage(
                              document.data()["Image"] ?? "No Data",
                            ),
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }).toList(),
              );
            } else {
              return Container();
            }
          }),
    ]));
  }

  void _addFav(_email, temp) {
    cref.doc(temp).set({
      "fav": true,
      "Item": temp,
    });
  }

  void _removeFav(_email, temp) {
    cref.doc(temp).set({
      "fav": false,
    });
  }
}
