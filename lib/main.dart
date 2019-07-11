import 'dart:convert';
import 'dart:async';

import 'detail.dart';
import 'addData.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
      routes: <String, WidgetBuilder>{
        '/home': (BuildContext context) => new MyApp(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<List> getData() async{
    final response = await http.get("http://192.168.89.91/YT/crud/selectbunga.php");
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: ()=> Navigator.of(context).push(
          MaterialPageRoute(builder: (BuildContext context)=> new AddData(),
          )
        ),
      ),
      body: FutureBuilder<List>(
        future: getData(),
        builder: (context, snapshot){
          if(snapshot.hasError)print(snapshot.error);

          return snapshot.hasData
              ? new ItemList(list: snapshot.data,)
              : new Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
class ItemList extends StatelessWidget {

  final List list;
  ItemList({this.list});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list == null ? 0 : list.length,
      itemBuilder: (context, i){
        return Container(
          padding: const EdgeInsets.all(5.0),
          child: GestureDetector(
            onTap: ()=> Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (BuildContext context) => new Detail(
                    list: list,
                    index: i,)
              )
            ),
            child: Card(
              child: ListTile(
                title: Text(list[i]['nama']),
                leading: Icon(Icons.widgets),
                subtitle: Text("Stok : ${list[i]['stok']}"),
              ),
            ),
          ),
        );
      },
    );
  }
}

