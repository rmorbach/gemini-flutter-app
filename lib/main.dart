import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_app/api/gemini_api.dart';
import 'package:gemini_app/prompt/prompt_creator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _resultController = TextEditingController();

  final Color _inputTextColor = Color.fromARGB(255, 6, 243, 14);

  late final GeminiAPI _geminiAPI;

  var _isLoading = false;

  @override
  void initState() {
    createGeminiAPI();
    super.initState();
  }

  void createGeminiAPI() async {
    await dotenv.load(fileName: ".env");
    var apikey = dotenv.env["API_KEY"] ?? '';
    _geminiAPI = GeminiAPI(apiKey: apikey);
  }

  void _sendButtonPressed() async {
    List<String> prompt =
        PromptCreator.createRecipePrompt(_inputController.text);

    _isLoading = true;

    setState(() {});

    final result = await _geminiAPI.executePrompt(prompt);

    _resultController.text = result?.text ?? "";

    _isLoading = false;

    setState(() {});
  }

  void _captureImagePressed() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (result?.count != 0) {
      print("Nenhuma imagem selecionada");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Informe os ingredientes disponíveis'),
        backgroundColor: Colors.black,
        foregroundColor: _inputTextColor,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              style: TextStyle(color: _inputTextColor),
              controller: _inputController,
              expands: false,
              decoration: InputDecoration(
                hintText: 'Digite os ingredientes',
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: _inputTextColor, width: 1.0)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: _captureImagePressed,
            child: const Icon(Icons.camera_enhance_sharp),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                style: TextStyle(color: _inputTextColor),
                controller: _resultController,
                maxLines: null,
                expands: true,
                enabled: true,
                readOnly: true,
                decoration: const InputDecoration(
                  hintText: 'Digite aqui',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: getLastWidget(),
          ),
        ],
      ),
    );
  }

  Widget getLastWidget() {
    if (_isLoading) {
      return const CircularProgressIndicator(
        backgroundColor: Colors.black,
      );
    } else {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _sendButtonPressed,
          child: const Text('Enviar'),
        ),
      );
    }
  }
}
