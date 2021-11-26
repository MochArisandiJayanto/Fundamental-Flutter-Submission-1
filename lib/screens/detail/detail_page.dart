import 'package:flutter/material.dart';
import 'package:flutter_sub1/screens/get_started.dart';
import 'package:flutter_sub1/screens/restauran/restaurant.dart';


class DetailPage extends StatelessWidget {
  final Restaurant restaurants;
  const DetailPage({Key? key, required this.restaurants}) : super(key: key);

  static const tag = 'detail_restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan[900],
        title: Text(restaurants.name),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
        actions: <Widget>[
          IconButton(
            iconSize: 30,
            color: Colors.white,
            onPressed: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) {
                    return GetStarted();
                  }));
            },
            icon: const Icon(Icons.person),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: const Color(0xFFB2EBF2),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(0),
                ),
              ),
              child: Image.network(restaurants.pictureId),
            ),
            Container(
              color: Colors.cyan[100],
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    restaurants.name,
                    style: const TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
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
                        restaurants.city,
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    "Description:\n",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    restaurants.description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Foods',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurants.menus.foods.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 20),
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xffe0f7fa),
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                              child: Text(item.name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.center)),
                        );
                      }).toList(),
                    ),
                  ),
                  Text(
                    'Drinks',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 150,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: restaurants.menus.drinks.map((item) {
                        return Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 20),
                          height: 150,
                          width: 120,
                          decoration: BoxDecoration(
                              color: const Color(0xffe0f7fa),
                              borderRadius: BorderRadius.circular(18)),
                          child: Center(
                              child: Text(item.name,
                                  style: Theme.of(context).textTheme.subtitle2,
                                  textAlign: TextAlign.center)),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
