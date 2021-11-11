import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'modules/predios_home.dart';
import 'modules/casa_home.dart';
import 'modules/terrenos_home.dart';

class StartScreen extends StatefulWidget {
  @override
  _StartScreenState createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final Color kColor =  Colors.white;
  static const kSize = 80.0;
  static const kTextSize = 30.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Escolha o que inserir',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
      ),
      ),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(
                      Icons.account_balance, color: kColor,
                      size: kSize
                  ),
                  Text('Apartamentos',
                    style: TextStyle(color: kColor, fontSize: kTextSize),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => PrediosHome()));
              },
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(
                      Icons.home, color: kColor,
                      size: kSize
                  ),
                  Text('Casas',style:
                  TextStyle(color: kColor, fontSize: kTextSize),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => CasasHome()));
              },
            ),
            FlatButton(
              child: Column(
                children: <Widget>[
                  Icon(
                      Icons.landscape, color: kColor,
                      size: kSize
                  ),
                  Text('Lotes/Terrenos/Chacarás',
                    style: TextStyle(color: kColor, fontSize: kTextSize),
                  ),
                ],
              ),
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => TerrenosHome()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
