import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:imobiliariaadmin/ui/modules/edits_view/terrenos_view.dart';
import 'package:firebase_storage/firebase_storage.dart';
//import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:path/path.dart' as Path;


class TerrenosHome extends StatefulWidget {
  @override
  _TerrenosHomeState createState() => _TerrenosHomeState();
}

class _TerrenosHomeState extends State<TerrenosHome> {


  static String query = "1600 Amphiteatre Parkway, Mountain View";

  double latitude;
  double longetitude;
  String precoController= '';
  String tamanhoController= '';
  String descricaoController = '';
  File _image;
  String _uploadedFileURL;
  File _image2;
  String _uploadedFileURL2;
  File  _image3;
  String _uploadedFileURL3;
  final dbRef = FirebaseDatabase.instance.reference().child("terrenos");
//  final ImagePicker _picker = ImagePicker();




  _getLocation() async
  {
    var addresses = await Geocoder.local.findAddressesFromQuery(query);
    var first = addresses.first;
    latitude = first.coordinates.latitude;
    longetitude = first.coordinates.longitude;
    print("${first.featureName} : ${first.coordinates}");
  }
  @override
  void initState() {
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Adicione o Terreno',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                          keyboardType: TextInputType.number,
                          onChanged: (preco) {
                            setState(() {
                              precoController = preco;
                            });
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Digite o Preço do Terreno',
                            contentPadding: EdgeInsets.only(left: 10.0, bottom: 4.0, top: 4.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                        child: TextField(
                            keyboardType: TextInputType.number,
                            onChanged: (tamanho) {
                              setState(() {
                                tamanhoController = tamanho;
                              });
                            },
                            decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Digite o tamanho do terreno',
                            contentPadding: EdgeInsets.only(left: 10.0, bottom: 4.0, top: 4.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                          ),
                        )
                        ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    /*SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Text('Endereço:',
                        style: TextStyle(color:Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(width: 20),*/
                    Expanded(
                      flex: 8,
                      child: TextField(
                        onChanged: (text) {
                          setState(() {
                            query = text;
                            _getLocation();
                          });
                        },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Digite o endereço',
                            contentPadding: EdgeInsets.only(left: 10.0, bottom: 4.0, top: 4.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 8,
                      child: TextField(
                          keyboardType: TextInputType.multiline,
                          onChanged: (descricao) {
                            setState(() {
                              descricaoController = descricao;
                            });
                          },
                          maxLines: null,
                          minLines: 5,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: 'Digite uma descrição',
                            contentPadding: EdgeInsets.only(left: 10.0, bottom: 4.0, top: 4.0),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(25.7),
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Text('Imagem Selecionada'),
                    _image != null
                        ? Image(image: FileImage(
                    _image,
                    ),
                      height: 150,)
                        : Container(height: 150),
                    _image == null
                        ? RaisedButton(
                      child: Text('Escolha uma Imagem'),
                      onPressed: chooseFile,
                      color: Colors.cyan,
                    )
                        : Container(),
                    _image != null
                        ? RaisedButton(
                      child: Text('Enviar Imagem'),
                      onPressed: uploadFile,
                      color: Colors.cyan,
                    )
                        : Container(),
                    Text('Imagem Enviada'),
                    _uploadedFileURL != null
                        ? Image.network(
                      _uploadedFileURL,
                      height: 150,
                    )
                        : Container(),
                  ],
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Text('Imagem Selecionada'),
                    _image2 != null
                        ?  Image(image: FileImage(
                      _image2,
                    ),
                      height: 150,)
                        : Container(height: 150),
                    _image2 == null
                        ? RaisedButton(
                      child: Text('Escolha uma Imagem'),
                      onPressed: chooseFile2,
                      color: Colors.cyan,
                    )
                        : Container(),
                    _image2 != null
                        ? RaisedButton(
                      child: Text('Enviar Imagem'),
                      onPressed: uploadFile2,
                      color: Colors.cyan,
                    )
                        : Container(),
                    Text('Uploaded Image2'),
                    _uploadedFileURL2 != null
                        ? Image.network(
                      _uploadedFileURL2,
                      height: 150,
                    )
                        : Container(),
                  ],
                ),
              ),
              Card(
                color: Colors.black,
                child: Column(
                  children: <Widget>[
                    Text('Imagem Selecionada'),
                    _image3 != null
                        ?  Image(image: FileImage(
                      _image3,
                    ),
                      height: 150,)
                        : Container(height: 150),
                    _image3 == null
                        ? RaisedButton(
                      child: Text('Escolha uma Imagem'),
                      onPressed: chooseFile3,
                      color: Colors.cyan,
                    )
                        : Container(),
                    _image3 != null
                        ? RaisedButton(
                      child: Text('Enviar Imagem'),
                      onPressed: uploadFile3,
                      color: Colors.cyan,
                    )
                        : Container(),
                    Text('Imagem Enviada'),
                    _uploadedFileURL3 != null
                        ? Image.network(
                      _uploadedFileURL3,
                      height: 150,
                    )
                        : Container(),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      onPressed: () {
                        dbRef.push().set({
                          "preco": precoController,
                          "tamanho": tamanhoController,
                          "latitude": latitude,
                          "longitude": longetitude,
                          "descricao": descricaoController,
                          "endereco": query,
                          "foto" : _uploadedFileURL,
                          "foto2" : _uploadedFileURL2,
                          "foto3" : _uploadedFileURL3,

                        }).then((_) {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => TerrenosView()));
                        }).catchError((onError) {
                          print(onError);
                        });
                      },
                      color: Colors.blueAccent,
                      child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Icon(Icons.save, color: Colors.white),
                              SizedBox(width: 10),
                              Text('Salvar Terreno', style: TextStyle(color: Colors.white))
                            ],
                          )
                      )
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future chooseFile() async {
    File file = await FilePicker.getFile();
    {
      this.setState(() {
        _image = file;
      });
    }
  }
  Future uploadFile() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('images/${Path.basename(_image.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL = fileURL;
        print(_uploadedFileURL);
      });
    });
  }
  Future chooseFile2() async {
    File file = await FilePicker.getFile();
    {
      this.setState(() {
        _image2 = file;
      });
    }
  }
  Future uploadFile2() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('images/${Path.basename(_image2.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image2);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL2 = fileURL;
        print(_uploadedFileURL2);
      });
    });
  }
  Future chooseFile3() async {
    File file = await FilePicker.getFile();
    {
      this.setState(() {
        _image3 = file;
      });
    }
  }
  Future uploadFile3() async {
    StorageReference storageReference = FirebaseStorage.instance.ref().child('images/${Path.basename(_image3.path)}}');
    StorageUploadTask uploadTask = storageReference.putFile(_image3);
    await uploadTask.onComplete;
    print('File Uploaded');
    storageReference.getDownloadURL().then((fileURL) {
      setState(() {
        _uploadedFileURL3 = fileURL;
        print(_uploadedFileURL3);
      });
    });
  }
}
