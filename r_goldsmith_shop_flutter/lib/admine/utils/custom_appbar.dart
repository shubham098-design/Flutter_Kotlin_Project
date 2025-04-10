import 'package:flutter/material.dart';

var CustomAppbar =  AppBar(
  leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
  actions: [
    IconButton(onPressed: () {}, icon: Icon(Icons.search)),
    IconButton(onPressed: () {}, icon: Icon(Icons.calendar_today)),
    IconButton(onPressed: () {}, icon: Icon(Icons.notifications_outlined)),
    IconButton(onPressed: () {}, icon: Icon(Icons.message_outlined)),
    Row(
      children: [
        Image.asset("images/q_radhika.png", width: 30, height: 30),
        Column(
          children: [
            Text("Radhika", style: TextStyle(fontWeight: FontWeight.bold)),
            Text("Radhika@gmail.com")
          ],
        )
      ],
    )
  ],
);