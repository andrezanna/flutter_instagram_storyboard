// Dart imports:
import 'dart:io';

// Package imports:
import 'package:photo_manager/photo_manager.dart';

class PostFile{
  File file;
  File thumb;
  AssetType type;

  PostFile({this.file,this.type,this.thumb}){}

}
