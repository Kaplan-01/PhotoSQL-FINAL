class Student{
  int controlnum;
  String photoName;
  String name;
  String app;
  String appP;
  String telef;
  String correo;
  String matricula;

  Student (this.controlnum, this.photoName, this.name, this.app, this.appP, this.telef, this.correo, this.matricula);
  Map<String,dynamic>toMap(){
    var map = <String,dynamic>{
      'controlnum': controlnum,
      'photoName':photoName,
      'name': name,
      'app': app,
      'appP': appP,
      'telef': telef,
      'correo': correo,
      'matricula': matricula,
    };
    return map;
  }

  Student.fromMap(Map<String, dynamic>map){
    controlnum = map['controlnum'];
    photoName = map['photoName'];
    name = map['name'];
    app = map['app'];
    appP = map['appP'];
    telef = map['telef'];
    correo = map['correo'];
    matricula = map['matricula'];
  }
}