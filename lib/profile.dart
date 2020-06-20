import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:profilefinalsql/update_table.dart';
import 'convertidor.dart';
import 'crud_operations.dart';
import 'insert.dart';
import 'delete.dart';
import 'select.dart';
import 'students.dart';
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.lightGreen),
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.lightGreen),
      home: DetailScreen(),
    );
  }
}

class DetailScreen extends StatefulWidget {
  @override
  _DetailScreen createState() => new _DetailScreen();
}

class _DetailScreen extends State<DetailScreen> {
  // VAR MANEJO BD
  List<Student> Students;
  TextEditingController controllerN = TextEditingController();
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

  final formkey = new GlobalKey<FormState>();
  var dbHelper;
  bool isUpdating;

  @override
  void initState() {
    super.initState();
    dbHelper = DBHelper();
    isUpdating = false;
    Students = [];
    refreshList();
  }

  void refreshList() {
    setState(() {
      dbHelper.getStudents().then((imgs){
        setState(() {
          Students.clear();
          Students.addAll(imgs);
        });
      });
    });
  }

  void cleanData() {
    controllerM.text = "";
    controllerAPP.text = "";
    controllerAP.text = "";
    controllerTE.text = "";
    controllerC.text = "";
    controllerN.text = "";
    controllerI.text = "";
  }

  void dataValidate() {
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (isUpdating) {
        Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
        dbHelper.update(stu);
        setState(() {
          isUpdating = false;
        });
      } else {
        Student stu = Student(null, photo, name, app, appP, telef, correo, matricula);
        dbHelper.insert(stu);
      }
      cleanData();
      refreshList();
    }
  }
  pickImagefromGallery(){
    ImagePicker.pickImage(source: ImageSource.gallery, maxHeight: 480, maxWidth: 640).then((imgFile){

      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      setState(() {
        photo= imgString;
      });
      Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
      dbHelper.update(stu);
      refreshList();

    });
  }

  pickImagefromCamara(){
    ImagePicker.pickImage(source: ImageSource.camera, maxHeight: 480, maxWidth: 640).then((imgFile){

      String imgString = Convertir.base64String(imgFile.readAsBytesSync());
      setState(() {
        photo= imgString;
        print(photo);
      });
      Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
      dbHelper.update(stu);
      refreshList();
    });
  }

  // SHOW DATA
  Widget dataTable() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: ListView(
          children:
          Students.map((foto)=> new InkWell(
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
                                backgroundImage: Convertir.imageFromBase64String(foto.photoName).image,

                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 110.0, right: 80.0),
                            child: new Row(
                              children: <Widget>[
                                new IconButton(icon: Icon(Icons.camera, color: Colors.white),
                                    onPressed: (){
                                      setState(() {
                                        currentUserId = foto.controlnum;
                                        name = foto.name;
                                        app = foto.app;
                                        appP = foto.appP;
                                        telef = foto.telef;
                                        correo = foto.correo;
                                        matricula = foto.matricula;
                                        pickImagefromCamara();
                                      });
                                    }),
                                new IconButton(icon: Icon(Icons.photo, color: Colors.white), onPressed: (){
                                  setState(() {
                                    currentUserId = foto.controlnum;
                                    name = foto.name;
                                    app = foto.app;
                                    appP = foto.appP;
                                    telef = foto.telef;
                                    correo = foto.correo;
                                    matricula = foto.matricula;
                                    pickImagefromGallery();
                                  });
                                }),
                              ],
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
                                              foto.name.toString() + " " + foto.app.toString() + " " + foto.appP.toString(),
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
                                              foto.correo.toString(),
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
                                              foto.telef.toString(),
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
          )).toList(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
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
        title: Text('Perfiles'),
      ),
      body:
      dataTable(),
    );
  }
}