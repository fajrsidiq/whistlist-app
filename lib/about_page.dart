import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'About Us',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
        ),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Card(
                child: (Column(
              children: [
                Text("Mozes Hasian Veltin Sinaga"),
                Text("20103052"),
              ],
            ))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 5),
            child: Card(
                child: (Column(
              children: [
                Text("Muhammad Albyrra AR"),
                Text("20103054"),
              ],
            ))),
          ),
          Padding(
           padding: const EdgeInsets.only(top: 5),
            child: Card(
                child: (Column(
              children: [
                Text("Muhammad Fajar Sidiq"),
                Text("20103055"),
              ],
            ))),
          ),
        ]));
  }
}
