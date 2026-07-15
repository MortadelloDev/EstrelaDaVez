// Lição 07: Uso de Enums para delimitar os grupos da Copa
enum Grupo { A, B, C, D, E, F, G, H, I, J, K, L }

class Selecao {
  String nome;
  Grupo grupo;
  int rankingFifa; // Essencial para o desempate final!
  
  int pontos = 0;
  int golsPro = 0;
  int golsSofridos = 0;
  int cartoesAmarelos = 0;
  int cartoesVermelhos = 0;

  // Lição 05: Getters para regras de negócio calculadas dinamicamente
  int get saldoGols => golsPro - golsSofridos;
  
  // Regra de Fair Play da FIFA: Amarelo = 1pt, Vermelho = 3pts (Menos pontos é melhor)
  int get pontosFairPlay => (cartoesAmarelos * 1) + (cartoesVermelhos * 3);

  Selecao({
    required this.nome,
    required this.grupo,
    required this.rankingFifa,
  });
}