import 'dart:convert';

import 'package:escribo03/db/db_helper.dart';
import 'package:flutter/cupertino.dart';

class MyAvatar with ChangeNotifier {

  Map<String, dynamic> _defAvatar = json.decode('{"_id":"myavatar","topType":0,"accessoriesType":0,"hairColor":1,"facialHairType":0,"facialHairColor":1,"clotheType":4,"eyeType":0,"eyebrowType":0,"mouthType":8,"skinColor":3,"clotheColor":8,"style":0,"graphicType":0}');
  Map<String, dynamic> get defAavatar {
    var ava = {..._defAvatar};
    ava.remove('_id');
    return ava;
  }

  Future<void> fetchAvatar() async {
    var resp = await DBHelper.getData('avatar');
    print('###########################');
    print(resp.length);
    if(resp.isEmpty){
      await DBHelper.insert('avatar', defAavatar);
      // return jsonEncode(defAavatar);
    }else{
      _defAvatar = resp.first;
    }
    notifyListeners();
    // return jsonEncode(defAavatar);
  }

  Future saveAvatar(Map<String, dynamic> data) async {
    await DBHelper.update('avatar', data);
    _defAvatar = data;
    notifyListeners();
  }
}