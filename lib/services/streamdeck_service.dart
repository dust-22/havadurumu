import 'package:http/http.dart' as http;

class StreamDeckService {
  static Future<bool> sendCommand(String command) async {
    try {
      // Bilgisayarının IP adresini buraya yaz!
      final uri = Uri.parse('http://192.168.1.20:5000/streamdeck/command');
      final response = await http.post(uri, body: {'command': command});
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}