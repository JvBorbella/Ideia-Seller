import 'dart:convert';
import 'package:http/http.dart' as http;

class SDUIService {
  static Future<Map<String, dynamic>> fetchLayout() async {
    final response = await http.get(
      Uri.parse(
        'http://licenciamento.ideiatecnologia.com.br:8997/ideia/public/metas.json',
      ),
      headers: {
        'Accept': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Erro HTTP: ${response.statusCode}');
    }

    final decodedBody = latin1.decode(response.bodyBytes);

    try {
      return jsonDecode(decodedBody);
    } catch (e) {
      print('JSON inválido recebido:');
      print(decodedBody);
      rethrow;
    }
  }
}

