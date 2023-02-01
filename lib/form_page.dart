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
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          judul,
        ),
        backgroundColor: Color.fromRGBO(13, 200, 179, 1),
        elevation: 0,
        actions: [
          IconButton(
              onPressed: popupMenuClick,
              icon: Icon(
                Icons.delete,
              ))
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    alignment: Alignment.topCenter,
                    image: AssetImage('assets/img/header2.png'))),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150, left: 15),
            child: Text(
              "Tambahkan wishlist kamu di sini",
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 225),
            child: ListView(children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      controller: txtharga,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          prefixIcon: Icon(
                            Icons.card_giftcard,
                            color: Colors.green,
                          ),
                          labelText: "Nama Barang",
                          labelStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(),
                          hintText: "Masukkan Nama Barang",
                          hintStyle: TextStyle(color: Colors.green),
                          filled: true,
                          fillColor: Colors.green[50]),
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
                      keyboardType: TextInputType.number,
                      controller: txtbarang,
                      decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                          prefixIcon: Icon(
                            Icons.monetization_on_outlined,
                            color: Colors.green,
                          ),
                          labelText: "Harga Barang",
                          labelStyle: TextStyle(color: Colors.green),
                          border: OutlineInputBorder(),
                          hintText: "Masukkan Harga Barang",
                          hintStyle: TextStyle(color: Colors.green),
                          filled: true,
                          fillColor: Colors.green[50]),
                      onChanged: (value) {
                        setState(() {
                          barang = value;
                        });
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15),
                    child: ElevatedButton.icon(
                      onPressed: () {
                        DatabaseServices.createUpdateWhistlist(
                            context, barang, harga);
                      },
                      icon: Icon(Icons.save_as_outlined),
                      label: Text("Simpan"),
                      style: ElevatedButton.styleFrom(
                          fixedSize: Size(300, 50),
                          textStyle: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                          backgroundColor: Colors.green,
                          shape: StadiumBorder()),
                    ),
                  )
                ],
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void popupMenuClick() {
    DatabaseServices.deleteWhistlist(widget.barang);
    Navigator.pop(context);
  }
}
