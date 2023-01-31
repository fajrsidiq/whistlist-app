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
    return Scaffold(
      appBar: AppBar(
        title: Text("MyWhistilist"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return FormPage(judul: "Tambah Data");
          }));
        },
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
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
                            child: ListTile(
                              leading: Icon(
                                Icons.catching_pokemon,
                                size: 60,
                              ),
                              title: Text(documentSnapshot["harga"]),
                              subtitle: Text(documentSnapshot["barang"]),
                            ),
                            onTap: () {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
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
                })
          ],
        ),
      ),
    );
  }
}
