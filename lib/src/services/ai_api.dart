import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

class AiAPI {
  final String _apiKey = "YOUR API KEY";
  final String _url = "YOUR GROQ URL";

  Future<String> transcribeAudio(File file) async {
    var fileName = file.path.split('/').last;
    var request = http.MultipartRequest('POST', Uri.parse(_url));

    var multipartFile = await http.MultipartFile.fromPath('file', file.path,
        contentType: MediaType('audio', 'm4a'), // is it always m4a ???
        filename: fileName);

    request.fields['model'] = 'whisper-large-v3';
    request.fields['temperature'] = '0';
    request.fields['response_format'] = 'json';
    request.fields['language'] = 'en';
    request.headers['Authorization'] = 'Bearer $_apiKey';
    request.files.add(multipartFile);

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var jsonResponse = json.decode(responseBody);
      return jsonResponse['text'];
    } else {
      throw Exception('Failed to transcribe audio');
    }
  }
}
