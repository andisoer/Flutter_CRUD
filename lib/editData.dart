import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EditData extends StatefulWidget {

  List list;
  int index;
  EditData({this.index, this.list});

  @override
  _EditDataState createState() => _EditDataState();
}

class _EditDataState extends State<EditData> {

  TextEditingController controllerNamaBarang;
  TextEditingController controllerHargaBarang;
  TextEditingController controllerStokBarang;

  void editData(){
    var url = "http://192.168.89.91/YT/crud/editbarang.php";

    http.post(url, body: {
      "idBarang": widget.list[widget.index]['id'],
      "namaBarang": controllerNamaBarang.text,
      "hargaBarang": controllerHargaBarang.text,
      "stokBarang": controllerStokBarang.text,
    });

  }

  @override
  void initState() {
    controllerNamaBarang = new TextEditingController(text: widget.list[widget.index]['nama'],);
    controllerHargaBarang = new TextEditingController(text: widget.list[widget.index]['harga'],);
    controllerStokBarang = new TextEditingController(text: widget.list[widget.index]['stok'],);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Data"),
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
                    labelText: "Nama barang",
                  ),
                ),
                TextField(
                  controller: controllerHargaBarang,
                  decoration: InputDecoration(
                    labelText: "Harga barang",
                  ),
                ),
                TextField(
                  controller: controllerStokBarang,
                  decoration: InputDecoration(
                    labelText: "Stok barang",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                ),
                FlatButton(
                  child: Text("Edit data"),
                  onPressed: (){
                      editData();
                      Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
