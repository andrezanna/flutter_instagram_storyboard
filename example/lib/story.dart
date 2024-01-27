// Project imports:
import 'PostFile.dart';
import 'media.dart';
import 'user.dart';

class Story {
  String? id;
  User? user;
  Media? media;
  String? caption;
  int? likes;
  int? comments;
  bool? suspended;
  bool? active;
  String? suspended_message;
  bool? watched;

  int? views;

  PostFile? picked;

  Story();

  Story.fromJSON(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap["id"].toString();
      user =
      jsonMap['user_data'] != null ? User.fromJSON(jsonMap['user_data'].first) : User.fromJSON({});

      if(jsonMap['media'] != null) {
        media=Media.fromJSON((jsonMap['media'] as List).first);
      }
      caption=jsonMap['caption']??'';
      likes = jsonMap["like_count"];
      views = jsonMap["view_count"];
      comments = jsonMap["comments_count"];
      suspended=jsonMap['suspended']??false;
      active=jsonMap['active']??true;
      suspended_message=jsonMap['message']??'';
      watched=jsonMap['watched'];
    }catch(e,stack){
      print(e);
      print(stack);
    }
  }


}
