import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiAPI {
  final String apiKey;
  late final GenerativeModel _model;
  final String modelName;

  GeminiAPI({required this.apiKey, this.modelName = "gemini-1.5-flash"}) {
    _model = GenerativeModel(model: modelName, apiKey: apiKey);
  }

  Future<GenerateContentResponse?> executePrompt(List<String> items) async {
    final List<Content> content = [];

    for (var element in items) {
      content.add(Content.text(element));
    }

    final safetySettings = [
      SafetySetting(HarmCategory.harassment, HarmBlockThreshold.high),
      SafetySetting(HarmCategory.hateSpeech, HarmBlockThreshold.high),
    ];
    try {
      return _model.generateContent(content, safetySettings: safetySettings);
    } on ServerException {
      return null;
    }
  }
}
