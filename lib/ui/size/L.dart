import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_animations/simple_animations.dart';

class Large extends StatefulWidget {
  final String category;
  final String size;

  const Large({Key key, @required this.category, @required this.size})
      : super(key: key);
  @override
  _LargeState createState() => _LargeState(category, size);
}

class _LargeState extends State<Large> {
  final String category;
  final String size;

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  _LargeState(this.category, this.size);
  @override
  Widget build(BuildContext context) {
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
                  if (document.data()["Category"] == category &&
                      document.data()["Size"] == size) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: ListTile(
                          tileColor: Colors.white.withOpacity(0.4),
                          title: Text(
                            document.data()["ItemName"],
                            style: TextStyle(
                                color: Colors.orange,
                                fontWeight: FontWeight.bold,
                                fontSize: 23),
                          ),
                          subtitle:
                              Text(document.data()["Description"] ?? "No Data"),
                          trailing: Text(document.data()["Price"] ?? "No Data"),
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
}
