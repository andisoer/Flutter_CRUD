import 'package:flutter/material.dart';
import 'editData.dart';
import 'package:http/http.dart' as http;

class Detail extends StatefulWidget {

  List list;
  int index;
  Detail({this.index, this.list});

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {

  void confirm(){
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Hapus '${widget.list[widget.index]['nama']}' ? "),
      actions: <Widget>[
        FlatButton(
          child: Text("Batal"),
          onPressed: (){
            Navigator.of(context).pop();
          },
          textColor: Colors.grey,
        ),
        FlatButton(
          child: Text("Hapus"),
          textColor: Colors.pinkAccent,
          onPressed: (){
            delete();
            Navigator.of(context).pushNamedAndRemoveUntil('/home', (Route<dynamic> route) => false);
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  void delete(){
    var url = "http://192.168.89.91/YT/crud/deletebarang.php";

    http.post(url, body: {
      "idBarang": widget.list[widget.index]["id"],
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.list[widget.index]['nama']}"),
      ),
      body: Container(
        height: 250.0,
        padding: const EdgeInsets.all(20.0),
        child: Card(
          child: Center(
            child: Column(
              children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 30.0),),
                Text(widget.list[widget.index]['nama'], style: TextStyle(fontSize: 20),),
                Text("Harga : ${widget.list[widget.index]['harga']}", style: TextStyle(fontSize: 18.0),),
                Text("Stok : ${widget.list[widget.index]['stok']}", style: TextStyle(fontSize: 16.0),),
                Padding(padding: const EdgeInsets.only(top: 30.0),),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Edit"),
                      color: Colors.green,
                      onPressed: ()=> Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (BuildContext context) => new EditData(
                              list: widget.list,
                              index: widget.index,
                            )
                        )
                      )
                    ),
                    RaisedButton(
                      child: Text("Delete"),
                      color: Colors.red,
                      onPressed: ()=> confirm()
                    )
                  ],
                ),
                Padding(padding: const EdgeInsets.only(bottom: 30.0),),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
