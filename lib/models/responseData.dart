import 'dart:convert';

import 'package:mobile_version_bloc/models/user.dart';

class ResponseData {
  String message ;
  User? data;
  String access_token;
  String token_type;
  int status;

  ResponseData({required this.status, required this.message, this.data,required this.access_token,required this.token_type});
  factory ResponseData.fromJson(Map<String, dynamic>? json) {
   
     print("json model $json!");
    return ResponseData(
      message: json!['message'] ?? '',
      data: json['data'] == null? null : User.fromJson(json['data'] ?? User.empty()),
      access_token: json!['access_token']??'' ,
      token_type: json!['token_type'] ?? '',
      status : json['status'] ?? 0,
    );
  }

}