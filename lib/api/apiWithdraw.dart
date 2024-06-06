
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobile_version_bloc/models/withdraw.dart';
import 'package:mobile_version_bloc/utility/networkUrl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiWithdraw {
  String token = '';

  static final String url = networkURL.prefix;

  Future<String> getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    token = localStorage.getString('token') ?? '';
    return token;
  }

  _setHeaders() => {
    'Content-type': 'application/json',
    'Accept': 'application/json',
    'Authorization': 'Bearer $token',
  };

  Future<List<Withdraw>> getWithdrawByUser() async {
    token = await getToken();

    try {
      var response = await http.get(Uri.http(url, '/api/withdraw-user'), headers: _setHeaders());
      if (response.statusCode != 200) throw Exception(response.reasonPhrase);
      List<dynamic> body = json.decode(response.body)['data'];
      List<Withdraw> withdraws = body.map((dynamic item) => Withdraw.fromJson(item)).toList();
      return withdraws;
    } catch (e) {
      return Future.error(e.toString());
    }
  }

  Future<bool> storeWithDraw(int jumlah, String namaBank, String noRek) async {
    token = await getToken();

    try {
      print("url ${ Uri.http(url, '/api/withdraw-user')}");
      var response = await http.post(
        Uri.http(url, '/api/withdraw-user'),
        headers: _setHeaders(),
        body: json.encode({
          'jumlah': jumlah,
          'nama_bank': namaBank,
          'no_rek': noRek,
        }),
      );
      print("response ${response.body}");
      if (response.statusCode != 201) throw Exception(response.reasonPhrase);
      return true;
    } catch (e) {
      print("err ${e}");
      return Future.error(e.toString());
    }
  }

 
}
