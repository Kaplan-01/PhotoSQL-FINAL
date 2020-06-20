import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crud_operations.dart';
import 'insert.dart';
import 'delete.dart';
import 'profile.dart';
import 'select.dart';
import 'students.dart';
import 'dart:async';
import 'convertidor.dart';
import 'update_table.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
          brightness: Brightness.light, primarySwatch: Colors.lightGreen),
      theme: ThemeData(
          brightness: Brightness.dark, primarySwatch: Colors.lightGreen),
      home: Search(),
    );
  }
}

class Search extends StatefulWidget {
  @override
  _mySearch createState() => new _mySearch();
}

class _mySearch extends State<Search> {
  // VAR MANEJO BD
  Future<List<Student>> Students;
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerB = TextEditingController();
  TextEditingController controllerAP = TextEditingController();
  TextEditingController controllerAPP = TextEditingController();
  TextEditingController controllerTE = TextEditingController();
  TextEditingController controllerC = TextEditingController();
  TextEditingController controllerM = TextEditingController();
  TextEditingController controllerI = TextEditingController();

  int currentUserId;
  String photo;
  String name;
  String app;
  String appP;
  String telef;
  String correo;
  String matricula;
  String search;
  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool _typing;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    _typing = false;
    //refreshList();
  }

  void refreshList(String matricula) {
    setState(() {
      Students = dbHelper.getStudent(matricula);
    });
  }

  void actualizar() {
    setState(() {
      Students = dbHelper.getStudent(matricula);
    });
  }

  void cleanData() {
    controllerB.text = "";
  }

  // SHOW DATA
  SafeArea dataTable(List<Student> Students) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children: Students.map((foto) => new InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) {
                return DetailedProfile(foto);
              }));
            },
            child: Card(
                color: Colors.deepPurple[400],
                child: new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          child: CircleAvatar(
                            radius: 100,
                            backgroundImage:
                            Convertir.imageFromBase64String(
                                foto.photoName)
                                .image,
                          ),
                        ),
                      ),
                      new Padding(padding: EdgeInsets.all(4)),
                      Text(foto.name.toString() +
                          " " +
                          foto.appP.toString() +
                          "\n" +
                          foto.matricula.toString()),
                    ])),
          )).toList(),
        ),
      ),
    );
  }

  //  SHOWS A DETAILED PROFILE
  Widget DetailedProfile(student) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                  height: 530.0,
                  width:  250.09,
                  decoration: new BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.blue],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(0.8, 0.0),
                        tileMode: TileMode.clamp
                    ),
                  ),
                  child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Center(
                          child: Container(
                            child: CircleAvatar(
                              radius: 100,
                              backgroundImage: Convertir.imageFromBase64String(student.photoName).image,
                            ),
                          ),
                        ),
                        new Column(
                          children: <Widget>[

                            new Text("KAPLAN",
                              style: TextStyle(fontFamily: 'Piedra', color: Colors.white, fontStyle: FontStyle.normal, fontSize: 46, letterSpacing: 5.0),
                            ),

                            new Text("FLUTTER DEV" + "\n",
                              style: TextStyle(color: Colors.white70, fontStyle: FontStyle.italic, fontSize: 16, letterSpacing: 13.0),
                            ),

                            /* const Text.rich(
                                  TextSpan(text: "____________________")
                              ),
                            */

                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new Container(
                                color: Colors.white,
                                height: 3,
                                width: 190,
                              ),
                            ),

                            new SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Container(
                                    width: 280,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.portrait, color: Colors.black),
                                        ),
                                        new Text(
                                            student.name.toString() + " " + student.app.toString() + " " + student.appP.toString(),
                                            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.black)
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),


                            new SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Container(
                                    width: 280,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.email, color: Colors.black),
                                        ),
                                        new Text(
                                            student.correo.toString(),
                                            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.black)
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),

                            new SafeArea(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: new Container(
                                    width: 280,
                                    color: Colors.white,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(Icons.phone, color: Colors.black),
                                        ),
                                        new Text(
                                            student.telef.toString(),
                                            style: TextStyle(fontFamily: 'RobotoMono', color: Colors.black)
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ]
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget list() {
    return Expanded(
      child: FutureBuilder(
        future: Students,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return dataTable(snapshot.data);
          }
          if (snapshot.data == null || snapshot.data.length == 0) {
            return Text("No data founded!");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  // FORMULARIO

  Widget form() {
    return SingleChildScrollView(
      child: Form(
        key: formkey,
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            verticalDirection: VerticalDirection.down,
            children: <Widget>[
              SizedBox(height: 30),
              SingleChildScrollView(
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: new Scaffold(
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Text('Bienvenido',
                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.w300),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  image: DecorationImage(
                    image: NetworkImage("https://i.pinimg.com/564x/c6/ba/ed/c6baed10c25ed570e5fa47cf709796d8.jpg"),
                  ),
                  color: Colors.white,
                ),
              ),
              ListTile(
                leading: Icon(Icons.assignment, color: Colors.yellow[800]),
                title: Text('Perfiles'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => DetailScreen()));
                },
              ),
              ListTile(
                leading: Icon(Icons.add, color: Colors.yellow[800]),
                title: Text('Insert'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Insert()));
                },
              ),
              ListTile(
                title: Text('Update'),
                leading: Icon(Icons.update, color: Colors.yellow[800]),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => UpdateData()));
                },
              ),
              ListTile(
                title: Text('Delete'),
                leading: Icon(Icons.delete, color: Colors.yellow[800]),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Delete()));
                },
              ),
              ListTile(
                leading: Icon(Icons.search, color: Colors.yellow[800]),
                title: Text('Select'),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Search()));
                },
              ),
            ],
          ),
        ),
        appBar: new AppBar(
          backgroundColor: Colors.black,
          title: _typing
              ? TextFormField(
            cursorColor: Colors.purpleAccent,
            cursorRadius: Radius.circular(10.0),
            textCapitalization: TextCapitalization.characters,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w300),
            cursorWidth: 5.0,
            controller: controllerB,
            keyboardType: TextInputType.number,
            decoration:
            InputDecoration(labelText: "Introduce una matricula"),
            validator: (val) => val.length == 0
                ? 'Llena el campo para una busqueda correcta'
                : null,
            onSaved: (val) => search = val,
            onChanged: (text) {
              refreshList(text);
            },
          )
              : Text('Search',
            style: TextStyle(),
          ),
          leading: IconButton(
            icon: Icon(_typing ? Icons.done : Icons.search),
            onPressed: () {
              print("Typing " + _typing.toString());
              setState(() {
                _typing = !_typing;
                controllerI.text = "";
              });
            },
          ),
        ),
        body: new Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              form(),
              list(),
            ],
          ),
        ),
      ),
    );
  }
}
