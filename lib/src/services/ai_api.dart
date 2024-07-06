import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:smart_piggy/src/models/piggy_model.dart';

class AiAPI {
  final String _apiKey = "YOUR_API_KEY";
  final String _whisperUrl =
      "https://api.groq.com/openai/v1/audio/transcriptions";
  final String _groqChatUrl = "https://api.groq.com/openai/v1/chat/completions";

  Future<PiggyModel> transcribeAudio(File file) async {
    var fileName = file.path.split('/').last;
    var request = http.MultipartRequest('POST', Uri.parse(_whisperUrl));

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
      var record = await _tokenizeTextResults(jsonResponse['text']);
      record["created_at"] = DateTime.now().toIso8601String(); // The cake
      return PiggyModel.fromJson(record);
    } else {
      throw Exception('Failed to transcribe audio');
    }
  }

  Future<Map> _tokenizeTextResults(String transcribedText) async {
    var requestBody = {
      'messages': [
        {
          'role': 'system',
          'content': """
Write a JSON object representing a user sentence about budget tracking. The JSON object should include keys for "item", "amount" (numerical value), and "sign" (+ for income, - for expense).

*Example:* 
The user says: "I spent 20 dollars on groceries."

*Output:* {"item": "Groceries", "amount": 20, "sign": "-"}

*Note:* Please respond only with a JSON object based on a user's sentence.
""",
        },
        {
          'role': 'user',
          'content': transcribedText,
        },
      ],
      'model': 'llama3-8b-8192',
      'temperature': 0.5,
      'max_tokens': 1024,
      'top_p': 1,
      'stop': null,
      'stream': false,
    };

    var requestBodyJson = json.encode(requestBody);

    var response = await http.post(
      Uri.parse(_groqChatUrl),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      },
      body: requestBodyJson,
    );

    if (response.statusCode == 200) {
      var jsonResponse = json.decode(response.body);
      var content = jsonResponse['choices'][0]['message']['content'];
      return json.decode(content);
    } else {
      throw Exception('Failed to get completion');
    }
  }
}
