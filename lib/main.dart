import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:gemini_app/api/gemini_api.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  TextEditingController _inputController = TextEditingController();
  TextEditingController _resultController = TextEditingController();

  late final GeminiAPI _geminiAPI;

  var _isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    createGeminiAPI();
    super.initState();
  }

  void createGeminiAPI() async {
    await dotenv.load(fileName: ".env");
    var apikey = dotenv.env["API_KEY"] ?? '';
    _geminiAPI = GeminiAPI(apiKey: apikey);
  }

  void _sendButtonPressed() async {
    List<String> prompt = [];

    prompt.add(
        "Você é um chefe de cozinha e vai apoiar cozinheiros amadores a criar receitas com ingredientes que estão à sua disposição");
    prompt.add(
        "Com base nos ingredientes informados sugira uma única receita detalhando: resumo da receita contendo título e tempo médio de preparo");
    prompt.add("ingredientes necessários");
    prompt.add("modo de preparo");
    prompt.add("Os ingredientes são: ");

    prompt.add(_inputController.text);

    _isLoading = true;

    setState(() { });

    final result = await _geminiAPI.executePrompt(prompt);

    _resultController.text = result?.text ?? "";

    _isLoading = false;


    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informe os ingredientes disponíveis'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _inputController,
              expands: false,
              decoration: const InputDecoration(
                hintText: 'Digite aqui',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _resultController,
                maxLines: null,
                expands: true,
                enabled: true,
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
