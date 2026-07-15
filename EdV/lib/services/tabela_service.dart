import '../models/selecao.dart';

class TabelaService {
  // Algoritmo de ordenação utilizando encadeamento de condições no .sort()
  static void ordenarTabela(List<Selecao> selecoes) {
    selecoes.sort((b, a) {
      // 1º Critério: Pontos (Maior primeiro)
      if (a.pontos != b.pontos) return a.pontos.compareTo(b.pontos);

      // 2º Critério: Saldo de Gols (Maior primeiro)
      if (a.saldoGols != b.saldoGols) return a.saldoGols.compareTo(b.saldoGols);

      // 3º Critério: Gols Pró (Maior primeiro)
      if (a.golsPro != b.golsPro) return a.golsPro.compareTo(b.golsPro);

      // 4º Critério: Fair Play (Menos pontos de cartão primeiro, logo 'b' compara com 'a')
      if (b.pontosFairPlay != a.pontosFairPlay) return b.pontosFairPlay.compareTo(a.pontosFairPlay);

      // 5º Critério Final 2026: Ranking da FIFA (A melhor posição é o menor número, ex: 15º é melhor que 59º)
      return b.rankingFifa.compareTo(a.rankingFifa);
    });
  }

  // Lição 08: Formatação visual de Strings no Terminal
  static void exibirTabela(List<Selecao> selecoes) {
    print('\n=== SIMULADOR GRUPO A - COPA 2026 ===');
    print('Pos | Seleção         | Pts | SG  | GP  | Ranking FIFA');
    print('------------------------------------------------------');
    
    for (int i = 0; i < selecoes.length; i++) {
      var s = selecoes[i];
      String pos = '${i + 1}º';
      String nome = s.nome.padRight(15);
      String pts = s.pontos.toString().padRight(3);
      String sg = (s.saldoGols >= 0 ? "+${s.saldoGols}" : "${s.saldoGols}").padRight(3);
      String gp = s.golsPro.toString().padRight(3);
      String rank = '${s.rankingFifa}º';

      print('$pos  | $nome | $pts | $sg | $gp | $rank');
      
      if (i == 1) {
        print('------------------------------------------------------ (Zona de Classificação)');
      }
    }
    print('');
  }
}