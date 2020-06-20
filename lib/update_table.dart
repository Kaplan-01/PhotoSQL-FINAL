import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'crud_operations.dart';
import 'insert.dart';
import 'delete.dart';
import 'profile.dart';
import 'select.dart';
import 'students.dart';
import 'dart:async';


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.lightGreen),
      theme: ThemeData(brightness: Brightness.dark, primarySwatch: Colors.lightGreen),
      home: UpdateData(),
    );
  }
}

class UpdateData extends StatefulWidget {
  @override
  _UpdateData createState() => new _UpdateData();
}

class _UpdateData extends State<UpdateData> {
  // VAR MANEJO BD
  Future<List<Student>> Students;
  TextEditingController controllerN = TextEditingController();
  TextEditingController controllerAP = TextEditingController();
  TextEditingController controllerAPP = TextEditingController();
  TextEditingController controllerTE = TextEditingController();
  TextEditingController controllerC = TextEditingController();
  TextEditingController controllerM = TextEditingController();
  TextEditingController controllerUp = TextEditingController();

  int currentUserId;
  String valor;
  int opcion;
  String descriptive_text = "Actualicemos datos";
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
    refreshList();
  }

  void refreshList() {
    setState(() {
      Students = dbHelper.getStudents();
    });
  }

  void cleanData() {
    controllerM.text = "";
    controllerAPP.text = "";
    controllerAP.text = "";
    controllerTE.text = "";
    controllerC.text = "";
    controllerN.text = "";
    controllerUp.text = "";
  }

  void updateData(){
    print("Seleccion columna: ");
    print(opcion);
    if (formkey.currentState.validate()) {
      formkey.currentState.save();
      if (opcion==1) {
        name = controllerUp.text;
        Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
        dbHelper.update(stu);
        refreshList();
      }
      else if (opcion==2) {
        app = controllerUp.text;
        Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
        dbHelper.update(stu);
        refreshList();
      }
      else if (opcion==3) {
        appP = controllerUp.text;
        Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
        dbHelper.update(stu);
        refreshList();
      }
      else if (opcion==4) {
        telef = controllerUp.text;
        Student stu = Student(currentUserId, photo, name, app, appP, telef, correo, matricula);
        dbHelper.update(stu);
        refreshList();
      }
      cleanData();
      refreshList();
    }
  }

  // SHOW DATA
  SingleChildScrollView dataTable(List<Student> Students) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(
            label: Text("Nombre"),
          ),
          DataColumn(
            label: Text("Apellido Materno"),
          ),
          DataColumn(
            label: Text("Apellido Paterno"),
          ),
          DataColumn(
            label: Text("Telefono"),
          ),
        ],
        rows: Students.map((student) =>
            DataRow(cells: [
              DataCell(Text(student.name), onTap: () {
                setState(() {
                  descriptive_text = "Nombre";
                  currentUserId = student.controlnum;
                  valor = student.name;
                  app = student.app;
                  appP = student.appP;
                  telef=student.telef;
                  correo = student.correo;
                  matricula=student.matricula;
                  opcion=1;
                });
                controllerUp.text = student.name;
              }),
              DataCell(Text(student.app.toString()), onTap: () {
                setState(() {
                  descriptive_text = "Apellido Materno";
                  currentUserId = student.controlnum;
                  photo = student.photoName;
                  name = student.name;
                  valor = student.app;
                  appP = student.appP;
                  telef=student.telef;
                  correo = student.correo;
                  matricula=student.matricula;
                  opcion=2;
                });
                controllerUp.text= student.app;
              }),
              DataCell(Text(student.appP.toString()), onTap: () {
                setState(() {
                  descriptive_text = "Apellido Paterno";
                  currentUserId = student.controlnum;
                  photo = student.photoName;
                  name = student.name;
                  app = student.app;
                  valor = student.appP;
                  telef=student.telef;
                  correo = student.correo;
                  matricula=student.matricula;
                  opcion=3;
                });
                controllerUp.text= student.appP;
              }),
              DataCell(Text(student.telef.toString()), onTap: () {
                setState(() {
                  descriptive_text = "Telefono";
                  currentUserId = student.controlnum;
                  photo = student.photoName;
                  name = student.name;
                  app = student.app;
                  appP = student.appP;
                  valor=student.telef;
                  correo = student.correo;
                  matricula=student.matricula;
                  opcion=4;
                });
                controllerUp.text= student.telef;
              }),
            ])).toList(),
      ),
    );
  }
  Widget form() {
    return Form(
      key: formkey,
      child: Padding(
        padding: EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          verticalDirection: VerticalDirection.down,
          children: <Widget>[
            new SizedBox(height: 50.0),
            TextFormField(
              controller: controllerUp,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: descriptive_text),
              cursorColor: Colors.green,
              textCapitalization: TextCapitalization.characters,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.yellow, fontWeight: FontWeight.w300),
              cursorRadius: Radius.circular(10.0),
              cursorWidth: 5.0,
              validator: (val) => val.length == 0 ? 'Hey! Olvidaste escribir la actualizacion' : null,
              onSaved: (val) => valor = val,
            ),

            SizedBox(height: 30,),
            new Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.yellow),
                  ),
                  onPressed: updateData,
                  child: Text('Guardar'),
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                    side: BorderSide(color: Colors.yellow),
                  ),
                  onPressed: () {
                    setState(() {
                      isUpdating = false;
                    });
                    cleanData();
                    refreshList();
                  },
                  child: Text("Cancel"),
                ),
              ],
            )
          ],
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
        title: Text('Actualizado'),
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
    );
  }
}

