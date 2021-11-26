import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_sub1/screens/restauran/restaurant.dart';
import 'package:flutter/services.dart' as root_bundle;
import 'package:flutter_sub1/theme/theme.dart';

import 'detail/detail_page.dart';

class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);
  @override
  _ListPage createState() => _ListPage();
}

class _ListPage extends State<ListPage> {
  bool isSearching = false;

  String searchString = "";

  TextEditingController? textEditingController = TextEditingController();

  Future<List<Restaurant>> readJsonData() async {
    final jsondata =
    await root_bundle.rootBundle.loadString("assets/local_restaurant.json");
    final data = Restaurants.fromJson(
      json.decode(jsondata),
    );
    return data.restaurants;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        title: !isSearching
            ? const Text('List Restaurant')
            : TextField(
          onChanged: (value) {
            setState(() {
              searchString = value.toLowerCase();
            });
          },
          style: const TextStyle(color: Colors.white),
          controller: textEditingController,
          decoration: const InputDecoration(
            hintText: "Search Here",
            hintStyle: TextStyle(color: Colors.white),
            icon: Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
        ),
        actions: <Widget>[
          !isSearching
              ? IconButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            icon: const Icon(Icons.search),
          )
              : TextButton(
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
              });
            },
            child: const Text(
              "Cancel",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.cyan[200],
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Restaurants",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(
                "Recommendation restaurant for you!",
                style: TextStyle(fontSize: 20, color: Colors.black87),
              ),
            ),
            FutureBuilder(
              future: readJsonData(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final restaurants = snapshot.data as List<Restaurant>;
                  return ListView.builder(
                    itemCount: restaurants.length,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return restaurants[index]
                          .name
                          .toLowerCase()
                          .contains(searchString)
                          ? InkWell(
                        splashColor: Colors.grey,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return DetailPage(
                                  restaurants: restaurants[index],
                                );
                              },
                            ),
                          );
                        },
                        child: Container(
                          margin:
                          const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          height: 100,
                          child: Card(
                            color: Colors.cyan[100],
                            child: Row(
                              children: <Widget>[
                                Container(
                                  height: 100,
                                  width: 120,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(0),
                                    ),
                                  ),
                                  child: Image.network(
                                      restaurants[index].pictureId),
                                ),
                                Container(
                                  padding: const EdgeInsets.fromLTRB(
                                      20, 0, 0, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: <Widget>[
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        restaurants[index].name,
                                        style: greyTextStyle.copyWith(
                                            fontSize: 19.0,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.location_on,
                                            color: Colors.blue,
                                          ),
                                          Text(
                                            restaurants[index].city,
                                            style: robotStyle.copyWith(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: <Widget>[
                                          const Icon(
                                            Icons.star,
                                            color: Colors.yellow,
                                          ),
                                          Text(
                                            "${restaurants[index].rating}",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                          : Container();
                    },
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
