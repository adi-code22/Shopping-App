import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shopping_app/ui/size/All.dart';
import 'package:url_launcher/url_launcher.dart';
import 'size/L.dart';

class Women extends StatefulWidget {
  @override
  _WomenState createState() => _WomenState();
}

class _WomenState extends State<Women> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TabController tabController;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.orange,
            iconSize: 30.0,
            onPressed: () {
              Navigator.pop(context);
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
          bottom: PreferredSize(
            preferredSize: Size(400, 150),
            child: Column(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.orange,
                  ),
                  child: Center(
                    child: Text(
                      "-   Women's   -",
                      style: GoogleFonts.orbitron(
                          textStyle: TextStyle(fontSize: 35)),
                    ),
                  ),
                ),
                TabBar(
                  labelStyle:
                      TextStyle(fontSize: 15.0, fontWeight: FontWeight.bold),
                  controller: tabController,
                  indicatorColor: Colors.orange,
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorWeight: 3,
                  labelColor: Colors.orange,
                  unselectedLabelColor: Colors.orange,
                  tabs: [
                    Container(
                      height: 50,
                      child: Tab(
                        //icon: Image.asset(Constants.kHornIcon),
                        text: "All",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "Med",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "Large",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        text: "XL",
                      ),
                    ),
                    Container(
                      height: 50,
                      child: Tab(
                        //icon: Image.asset(Constants.kHornIcon),
                        text: "XXL",
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        body: TabBarView(children: [
          All(category: "Women"),
          Large(category: "Women", size: "M"),
          Large(category: "Women", size: "L"),
          Large(category: "Women", size: "XL"),
          Large(category: "Women", size: "XXL"),
        ]),
      ),
    );
  }
}
