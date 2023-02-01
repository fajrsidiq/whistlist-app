import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whistlist/about_page.dart';
import 'package:whistlist/form_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        toolbarHeight: 30,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () =>
                  _openAboutPage(context = context, fullscreenDialog: true),
              icon: Icon(Icons.info_outline))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPage(judul: "Tambah Data");
          }));
        },
        child: Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 1, 186, 240),
        foregroundColor: Colors.white,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        notchMargin: 5,
        shape: CircularNotchedRectangle(),
        color: Color.fromARGB(255, 1, 186, 240),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 1, 186, 240),
                    size: 45,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 1, 186, 240),
                    size: 45,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 1, 186, 240),
                    size: 45,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.circle,
                    color: Color.fromARGB(255, 1, 186, 240),
                    size: 45,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: size.height * 3,
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/img/top_header.png'))),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 0, left: 16, right: 16),
              child: Column(
                children: [
                  Container(
                    height: 95,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          backgroundImage: AssetImage('assets/img/logo.png'),
                          radius: 50,
                          backgroundColor: Colors.transparent,
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello! Welcome to",
                              style: TextStyle(
                                  fontFamily: "Montserrat Reguler",
                                  color: Colors.white,
                                  fontSize: 15),
                            ),
                            Text(
                              "MyWish App",
                              style: TextStyle(
                                  fontFamily: "Montserrat Medium",
                                  color: Colors.white,
                                  fontSize: 30),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 65),
                    child: Text(
                      "Ini Data Kamu",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 25),
                    child: SingleChildScrollView(
                      child: Container(
                        child: StreamBuilder<QuerySnapshot>(
                            stream: FirebaseFirestore.instance
                                .collection('whistlist')
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.vertical,
                                    itemCount: snapshot.data!.docs.length,
                                    itemBuilder: (context, index) {
                                      DocumentSnapshot documentSnapshot =
                                          snapshot.data!.docs[index];
                                      print("${documentSnapshot["harga"]}");
                                      return InkWell(
                                        child: Card(
                                          color: Colors.transparent,
                                          elevation: 40,
                                          child: Container(
                                            margin: EdgeInsets.only(bottom: 10),
                                            decoration: BoxDecoration(
                                                color: Colors.blue[300],
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            child: ListTile(
                                              leading: Icon(
                                                Icons.catching_pokemon,
                                                size: 60,
                                              ),
                                              trailing: Icon(Icons.edit),
                                              iconColor: Colors.white,
                                              textColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              title: Text(
                                                  documentSnapshot["harga"]),
                                              subtitle: Text(
                                                  documentSnapshot["barang"]),
                                            ),
                                          ),
                                        ),
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                                  builder: (context) {
                                            return FormPage(
                                              judul: "Ubah Data",
                                              barang:
                                                  documentSnapshot["barang"],
                                              harga: documentSnapshot["harga"],
                                            );
                                          }));
                                        },
                                      );
                                    });
                              } else {
                                return Text("Tidak ada data");
                              }
                            }),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

void _openAboutPage(BuildContext context, {bool, fullscreenDialog}) {
  Navigator.push(
      context,
      MaterialPageRoute(
          fullscreenDialog: fullscreenDialog,
          builder: (context) => AboutPage()));
}
