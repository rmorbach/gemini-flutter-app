import 'dart:ffi';
import 'dart:typed_data';

import 'package:google_generative_ai/google_generative_ai.dart';

final class GeminiAPI {
  final String apiKey;
  late final GenerativeModel _model;
  final String modelName;

  static const String flashModel = "gemini-1.5-flash";
  static const String proModel = "gemini-1.5-pro";

  GeminiAPI({required this.apiKey, this.modelName = GeminiAPI.flashModel}) {
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

  Future<GenerateContentResponse?> executePromptWithData(
      List<String> items, Uint8List data) async {
    final List<Content> content = [];

    for (var element in items) {
      content.add(Content.text(element));
    }

    content.add(Content.data("image/jpeg", data));

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
