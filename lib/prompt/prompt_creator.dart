class PromptCreator {
  static List<String> createRecipePrompt(String ingredients) {
    List<String> prompt = [];
    prompt.add(
        "Você é um chefe de cozinha e vai apoiar cozinheiros amadores a criar receitas com ingredientes que estão à sua disposição");
    prompt.add(
        "Com base nos ingredientes informados sugira uma única receita detalhando: resumo da receita contendo título e tempo médio de preparo");
    prompt.add("ingredientes necessários");
    prompt.add("modo de preparo");
    prompt.add("na sua resposta, na lista de ingredientes substitua os arteriscos que marcam cada ingrediente pelo emoji 🍎");    
    prompt.add("Os ingredientes são: ");

    prompt.add(ingredients);
    return prompt;
  }

  static List<String> createRecipePromptForImage() {
    List<String> prompt = [];
    prompt.add(
        "Você é um chefe de cozinha e vai apoiar cozinheiros amadores a criar receitas com ingredientes que estão à sua disposição");
    prompt.add(
        "Com base na imagem fornecida, identifique os elementos e sugira uma única receita detalhando: resumo da receita contendo título e tempo médio de preparo");
    prompt.add("ingredientes necessários");
    prompt.add("modo de preparo");
    prompt.add("na sua resposta, na lista de ingredientes substitua os arteriscos que marcam cada ingrediente pelo emoji 🍎");    
    
    return prompt;
  }
}
