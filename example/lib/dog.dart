// Project imports:
import 'user.dart';

class Dog{
  String id;
  String nome;
  DateTime dataNascita;
  int taglia;
  String bio;
  bool sesso;//true maschio, false femmina
  User user;

  //campi scheda alimentare
  String attivita;
  int passeggiate;
  double peso;
  String preferenza;

  String imagePath;
  int age=0;

  double latitude;
  double longitude;
  double distance;

  Dog();

  Dog.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id']!=null?jsonMap['id'].toString():null;
      nome = jsonMap['nome'];
      dataNascita= jsonMap['nascita']!=null?DateTime.parse(jsonMap['nascita'].toString()):null;
      calculateAge();
      taglia = jsonMap['id_taglia'];
      bio = jsonMap['bio'] ;
      sesso = jsonMap['sesso'].toString()=='true' || jsonMap['sesso'].toString()=='1';
      user = jsonMap['user'] != null ? User.fromJSON(jsonMap['user']) : null;
      attivita=jsonMap['attivita'];
      passeggiate=jsonMap['num_pass'];
      peso=double.tryParse(jsonMap['peso'].toString());
      preferenza=jsonMap['preferenza'];

      if(jsonMap['latitude']!=null && jsonMap['longitude']!=null) {
        latitude = double.parse(jsonMap['latitude'].toString());
        longitude = double.parse(jsonMap['longitude'].toString());
        distance = double.parse(jsonMap['distance'].toString());
      }
    } catch (e,stack) {

      print(e);
      print(stack);
      //print(CustomTrace(StackTrace.current, message: e));
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["nome"] = nome;
    if(dataNascita!=null)
    map["nascita"] = dataNascita.toString();
    map["id_taglia"] = taglia;
    map["bio"] = bio;
    map["sesso"] = sesso;

    return map;
  }

  Map toRestrictedMap(){
    var map = new Map<String, dynamic>();
    map["nome"] = nome;
    return map;
  }

  Map schedaAlimentareMap(){
    var map = new Map<String, dynamic>();

    map["attivita"] = attivita;
    map["num_pass"] = passeggiate;
    map["peso"] = peso;
    map["preferenza"]=preferenza;

    return map;
  }

  calculateAge(){
    try {
      final now = DateTime.now();
      age = (now
          .difference(dataNascita)
          .inDays / 365).floor();
    }catch(e){
      age=0;
    }
  }

  bool schedaCompleta(){
    return dataNascita!=null && taglia!=null && sesso!=null && passeggiate!=null && attivita!=null && peso!=null && preferenza!=null;
  }
}
