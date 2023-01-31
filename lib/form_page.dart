import 'package:whistlist/database_services.dart';
import 'package:flutter/material.dart';

class FormPage extends StatefulWidget {
  String barang = "";
  String harga = "";
  String judul = "";

  FormPage({Key? key, this.barang = "", this.harga = "", this.judul = ""});
  @override
  State<FormPage> createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  String barang = "";
  String harga = "";
  String judul = "";
  var txtbarang = TextEditingController();
  var txtharga = TextEditingController();

  @override
  void initState() {
    super.initState();
    txtbarang.text = widget.barang;
    txtharga.text = widget.harga;
    barang = widget.barang;
    harga = widget.harga;
    judul = widget.judul;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(judul),
        actions: [
          IconButton(onPressed: popupMenuClick, icon: Icon(Icons.delete))
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: txtharga,
              decoration: InputDecoration(
                labelText: "Nama Barang",
                border: OutlineInputBorder(),
                hintText: "Masukkan Nama Barang",
              ),
              onChanged: (value) {
                setState(() {
                  harga = value;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: txtbarang,
              decoration: InputDecoration(
                labelText: "Harga",
                border: OutlineInputBorder(),
                hintText: "Masukkan Harga",
              ),
              onChanged: (value) {
                setState(() {
                  barang = value;
                });
              },
            ),
          ),
          
          ElevatedButton(
              onPressed: () {
                DatabaseServices.createUpdateWhistlist(context, barang, harga);
              },
              child: Text("Simpan"))
        ],
      ),
    );
  }

  void popupMenuClick() {
        DatabaseServices.deleteWhistlist(widget.barang);
        Navigator.pop(context);
  }
}
