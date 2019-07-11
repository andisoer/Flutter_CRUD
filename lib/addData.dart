import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddData extends StatefulWidget {
  @override
  _AddDataState createState() => _AddDataState();
}

class _AddDataState extends State<AddData> {

  TextEditingController controllerNamaBarang = new TextEditingController();
  TextEditingController controllerHarga = new TextEditingController();
  TextEditingController controllerStok = new TextEditingController();

  void addData(){
    var url = "http://192.168.89.91/YT/crud/insertbunga.php";
    
    http.post(url, body: {
      "namaBarang": controllerNamaBarang.text,
      "hargaBarang": controllerHarga.text,
      "stokBarang": controllerStok.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Data"),
      ),
      body: Container(
        child: ListView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          children: <Widget>[
            Column(
              children: <Widget>[
                TextField(
                  controller: controllerNamaBarang,
                  decoration: InputDecoration(
                      labelText: "Nama Barang",
                  ),
                ),
                TextField(
                  controller: controllerHarga,
                  decoration: InputDecoration(
                      labelText: "Harga",
                  ),
                ),
                TextField(
                  controller: controllerStok,
                  decoration: InputDecoration(
                      labelText: "Stok",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                RaisedButton(
                  child: Text("Tambah Data"),
                  color: Colors.blue,
                  onPressed: (){
                    addData();
                    Navigator.pop(context);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
