// Project imports:
import 'media.dart';
import 'dog.dart';

enum UserState { available, away, busy }

class User {
  String id;
  String username;
  String name;
  String nome_azienda;
  String email;
  String password;
  String apiToken;
  String deviceToken;
  String phone;
  String address;
  String bio;
  Media image=Media();
  DateTime created_at;
  Dog dog;
  DateTime banned_to;

  // used for indicate if client logged in or not
  bool auth;
  //bool fattura;
  bool notif;
  bool localiz;
  //String userInvitationCode;

  String imagePath;
  int postCount;
  int followers;
  int following;
  bool private;
  bool verified;

  String segnalatoDa;
  //  String role;

  User();

  User.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'].toString();
      username= jsonMap['username'] !=null ? jsonMap['username'] : '';
      name = jsonMap['name'] != null ? jsonMap['name'] : '';
      email = jsonMap['email'] != null ? jsonMap['email'] : '';
      apiToken = jsonMap['api_token'];
      deviceToken = jsonMap['device_token'];
      phone = jsonMap['phone']??'';
      address = jsonMap['address'];
      localiz = jsonMap['location'];
      notif = jsonMap['notification'];
      bio=jsonMap['bio'];
      //print(jsonMap['dog']);
      dog =jsonMap['dog']!=null ?Dog.fromJSON(jsonMap['dog']):Dog.fromJSON({});
      image = jsonMap['media'] != null && (jsonMap['media'] as List).length > 0 ? Media.fromJSON(jsonMap['media'][0]) : new Media();
      postCount=jsonMap['posts_count']??0;
      following=jsonMap['following']??0;
      followers=jsonMap['followers']??0;
      try {
        created_at = DateTime.tryParse(jsonMap['created_at']);
      }catch(e){}
      //userInvitationCode=jsonMap['invitation_code'];
      private=false;
      verified=jsonMap['verified']??false;
      nome_azienda=jsonMap["nome_azienda"];
      try {
        banned_to = DateTime.tryParse(jsonMap['banned_to']);
      } catch (e) {

      }
    } catch (e,stack) {
      print(e);
      print(stack);
      image=Media();
    }
  }

  Map toMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["username"]=username;
    map["name"] = name;
    map["password"] = password;
    map["api_token"] = apiToken;
    if (deviceToken != null) {
      map["device_token"] = deviceToken;
    }
    map["phone"] = phone;
    map["address"] = address;
    map["bio"] = bio;
    map["media"] = image?.toMap();
    //map["fattura"]=fattura;
    map["location"]=localiz;
    map["notification"]=notif;
    map["nome_azienda"]=nome_azienda;
    if(segnalatoDa!=null)
    map["segnalato_da"]=segnalatoDa;
    return map;
  }

  Map toRestrictMap() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["email"] = email;
    map["username"]=username;
    map["name"] = name;
    map["thumb"] = image?.thumb;
    map["device_token"] = deviceToken;
    return map;
  }

  Map toNewPass(String code){
    var map = <String, dynamic>{};
    map['password']=password;
    map['email']=email;
    map['code']=code;
    return map;
  }

  @override
  String toString() {
    var map = this.toMap();
    map["auth"] = this.auth;
    return map.toString();
  }

  bool profileCompleted() {
    return name!=null && name!='username' && dog?.nome!=null;
  }

  String displayName() {
    return nome_azienda?? name;
  }
}
