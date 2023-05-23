import 'dart:convert';

import 'package:get/get.dart';
import 'package:project_if21b/config/api.dart';
import 'package:project_if21b/event/event_pref.dart';
import 'package:project_if21b/model/user.dart';
import 'package:project_if21b/widget/info.dart';
import 'package:http/http.dart' as http;

class EventDb {
  //fungsi login dg 2 param
  static Future<User?> login(String username, String pass) async {
    User? user;

    try {
      var response = await http.post(Uri.parse(Api.login), body: {
        'username': username,
        'pass': pass,
      });

      //kondisi akses api
      if (response.statusCode == 200) {
        var responBody = jsonDecode(response.body);

        //kondisi username dan password
        if (responBody['success']) {
          user = User.fromJson(responBody['user']);
          EventPref.saveUser(user);
          Info.snackbar('Login Berhasil');
          Future.delayed(Duration(milliseconds: 1700), () {
            // Get.off(
            //   Login(),
            // );
          });
        } else {
          Info.snackbar('Login Gagal');
        }
      } else {
        Info.snackbar('Request Login Gagal');
      }
    } catch (e) {
      print(e);
    }
    return user;
  }
}
