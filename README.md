# gemini-flutter-app
Este é um aplicativo criado para a finalidade de estudar o uso do SDK [Google Generative AI](https://pub.dev/packages/google_generative_ai) no Flutter.

A aplicação é bastante simples e consiste em um gerador de receitas com base em ingredientes disponíveis. O usuário pode digitar os ingredientes que ele possui a disposição ou que planeja utilizar, ou então, enviar uma foto dos itens e, a partir destas informações, o prompt criado é responsável por gerar uma receita contendo os ingredientes, tempo e modo de preparo e dicas.

O prompt utilizado pode ser encontrado no arquivo [prompt_creator.dart](prompt/prompt_creator.dart).

## Pré-requisitos

Para que você possa utilizar a aplicação é preciso gerar uma chave de API no [Google AI Studio](https://aistudio.google.com/app/apikey).

Após gerar a chave, crie um arquivo `.env` na raiz do projeto no seguinte formato:

```bash
API_KEY=SUA_CHAVE_DE_API
```

Feito isso é só rodar o projeto.
