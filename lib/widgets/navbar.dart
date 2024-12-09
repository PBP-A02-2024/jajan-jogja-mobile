import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:jajan_jogja_mobile/zoya/screens/landing_page.dart';

Container navbar(context) {
  return Container(
    height: 75,
    width: MediaQuery.sizeOf(context).width,
    alignment: Alignment.bottomCenter,
    color: Color(0xFFEBE9E1),
    padding: EdgeInsets.only(top: 7),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Column(children: [
          IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedHome11,
              color: Color(0XFF7A7A7A),
              size: 24.0,
            ),
            onPressed: () async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LandingPage()),
              );
            },
          ),
          Text(
            "Home",
            style: TextStyle(color: Color(0XFF7A7A7A)),
          )
        ])),
        Center(
            child: Column(
          children: [
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedSearch01,
                color: Color(0XFF7A7A7A),
                size: 24.0,
              ),
              onPressed: () {},
            ),
            Text(
              "Search",
              style: TextStyle(color: Color(0XFF7A7A7A)),
            )
          ],
        )),
        Center(
            child: Column(
          children: [
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedVegetarianFood,
                color: Color(0XFF7A7A7A),
                size: 24.0,
              ),
              onPressed: () {},
            ),
            Text(
              "Food Plans",
              style: TextStyle(color: Color(0XFF7A7A7A)),
            )
          ],
        )),
        Center(
            child: Column(
          children: [
            IconButton(
              icon: HugeIcon(
                icon: HugeIcons.strokeRoundedUser,
                color: Color(0xFF7A7A7A),
                size: 24.0,
              ),
              onPressed: () {},
            ),
            Text(
              "Profile",
              style: TextStyle(color: Color(0XFF7A7A7A)),
            )
          ],
        )),
      ],
    ),
  );
}
