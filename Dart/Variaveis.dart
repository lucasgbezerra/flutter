void main() {
	
  // Implementando uma lojinha
  
  String nome = "Lojinha do Daniel";
  int bananas = 5;
  double preco = 10.5;
  bool aindaTem = true;
  
  bananas = 10;
  
  print(nome);
  print("O nome da Lojinha é " + nome);
  print("A $nome tem $bananas bananas");
  print("Cada banana custa $preco reais");
  print("Ainda tem? $aindaTem");
  
  dynamic teste = 1;	// mostrar var e dynamic
  print(teste);
  teste = "hehehe";
  print(teste);
  
}

