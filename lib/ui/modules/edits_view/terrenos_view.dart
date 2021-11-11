import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
var encoded = utf8.encode("Îñţérñåţîöñåļîžåţîờñ");
var decoded = utf8.decode([0x62, 0x6c, 0xc3, 0xa5, 0x62, 0xc3, 0xa6,
  0x72, 0x67, 0x72, 0xc3, 0xb8, 0x64]);
const Utf8Codec utf8 = Utf8Codec();

class TerrenosView extends StatefulWidget {

  @override
  _TerrenosViewState createState() => _TerrenosViewState();
}

class _TerrenosViewState extends State<TerrenosView> {
  DatabaseReference dbRef = FirebaseDatabase.instance.reference().child("terrenos");
  List list =  List();

  @override
  void initState()  {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            'Lista de Terrenos',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
          ),
        ),
        body:FutureBuilder(
            future: dbRef.once(),
            builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
              if (snapshot.hasData) {
                list.clear();
                Map<dynamic, dynamic> values = snapshot.data.value;
                values.forEach((key, values) {
                  list.add(values);
                });
                return new ListView.builder(
                    shrinkWrap: true,
                    itemCount: list.length,
                    itemBuilder: (BuildContext context, int index) {
                      return buildDismissible(index, context);
                    });
              }
              return CircularProgressIndicator();
            })
    );
  }

  Dismissible buildDismissible(int index, BuildContext context) {
    return Dismissible(direction: DismissDirection.horizontal,
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Icon(Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      key: Key(list[index].toString()),

                      child: GestureDetector(
                        onTap: () {
                          _showOptions(context, index);
                        },
                        child: Card(
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(08.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                width: 80.0,
                                    height: 80.0,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                          image: NetworkImage(list[index]["foto"]),
                                          fit: BoxFit.cover),
                                    ),

//                            Image(image: NetworkImage(list[index]["foto"]),)
                                ),
                                SizedBox(width: 10.0,),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text("Descricao: " + list[index]["descricao"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 22.0, fontWeight: FontWeight.bold),
                                      ),

                                      Text("Endereço: "+ list[index]["endereco"],
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 22.0, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                               /* Text("Name: " + list[index]["longitude"].toString()),
                                Text("Name: " + list[index]["latitude"].toString()),
                                Text("Name: " + list[index]["preco"].toString()),
                                Text("Name: " + list[index]["tamanho"].toString()),*/
                              ],
                            ),
                          ),
                        ),
                      ),
                      onDismissed: (direction){
                        FirebaseDatabase.instance.reference().child('terrenos').orderByChild('descricao').equalTo(list[index]["descricao"]).once()
                            .then((DataSnapshot snapshot) {
                          Map<dynamic, dynamic> children = snapshot.value;
                          children.forEach((key, value) {
                            FirebaseDatabase.instance.reference().child('terrenos').child(key).remove();
                          });
                        });
                      },
                    );
  }

  void _showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text(
                          "Excluir",
                          style: TextStyle(color: Colors.red, fontSize: 20.0),
                        ),
                        onPressed: () {
                          FirebaseDatabase.instance.reference().child('terrenos').orderByChild('descricao').equalTo(list[index]["descricao"]).once()
                              .then((DataSnapshot snapshot) {
                            Map<dynamic, dynamic> children = snapshot.value;
                            children.forEach((key, value) {
                              FirebaseDatabase.instance.reference().child('terrenos').child(key).remove();
                              setState(() {
//                                Navigator.pop(context);
                              });
                            });
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        });
  }
}

