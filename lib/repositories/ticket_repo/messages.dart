import 'package:http/http.dart' as http;

class Messages {
  Future getMessage(String id) async {
    var res;
    String url = 'https://pharmabag.in:3000/user/get/message/for/ticket/$id';
    res = await http.get(Uri.parse(url)).then((value) {
      print(value.body);
      res = value.body;
      return res;
    });
    return res;
  }
}
