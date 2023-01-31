import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPage(judul: "Tambah Data");
          }));
        },
        child: Icon(Icons.add),
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
              padding: const EdgeInsets.all(16.0),
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
                    padding: const EdgeInsets.symmetric(vertical: 100),
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
                                                    BorderRadius.circular(20)),
                                            title:
                                                Text(documentSnapshot["harga"]),
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
                                            barang: documentSnapshot["barang"],
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
