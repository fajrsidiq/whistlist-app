import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class DatabaseServices {
  static Future<void> createUpdateWhistlist(
      BuildContext context, String barang, String harga) async {
    DocumentReference whistlistReference =
        FirebaseFirestore.instance.collection("whistlist").doc(barang);
    Map<String, dynamic> datawhistlist = {"barang": barang, "harga": harga};
    whistlistReference.set(datawhistlist).whenComplete(() {
      Navigator.pop(context);
    });
  }

  static Future<void> deleteWhistlist(String barang) async {
    CollectionReference whistlistCollection =
        FirebaseFirestore.instance.collection('whistlist');
    return await whistlistCollection.doc(barang).delete();
  }
}
