import '../models/selecao.dart';

// Lição 08 (CLI): Tabela de Códigos ANSI para cores no Terminal
class Cores {
  static const String reset = '\x1B[0m';
  static const String negrito = '\x1B[1m';
  
  // Cores solicitadas
  static const String amarelo = '\x1B[1;33m';  // Liderança (1º lugar)
  static const String vermelho = '\x1B[1;31m'; // Zonas de risco/Eliminação (Último lugar)
  
  // Cores de apoio para deixar a tabela profissional
  static const String ciano = '\x1B[1;36m';    // Títulos e cabeçalho
  static const String verde = '\x1B[1;32m';    // Linha da Zona de Classificação
  static const String cinza = '\x1B[90m';      // Divisores da tabela
}

class TabelaService {
  // Algoritmo de ordenação oficial da FIFA 2026
  static void ordenarTabela(List<Selecao> selecoes) {
    selecoes.sort((b, a) {
      if (a.pontos != b.pontos) return a.pontos.compareTo(b.pontos);
      if (a.saldoGols != b.saldoGols) return a.saldoGols.compareTo(b.saldoGols);
      if (a.golsPro != b.golsPro) return a.golsPro.compareTo(b.golsPro);
      if (b.pontosFairPlay != a.pontosFairPlay) return b.pontosFairPlay.compareTo(a.pontosFairPlay);
      return b.rankingFifa.compareTo(a.rankingFifa);
    });
  }

  static void exibirTabela(List<Selecao> selecoes) {
    print('\n${Cores.ciano}=== SIMULADOR GRUPO A - COPA 2026 ===${Cores.reset}');
    print('${Cores.negrito}Pos | Seleção         | Pts | SG  | GP  | Ranking FIFA${Cores.reset}');
    print('${Cores.cinza}------------------------------------------------------${Cores.reset}');
    
    for (int i = 0; i < selecoes.length; i++) {
      var s = selecoes[i];
      
      // 1º PASSO: Padroniza os espaços das colunas PRIMEIRO (Garante o alinhamento perfeito)
      String pos = '${i + 1}º';
      String nomeAlinhado = s.nome.padRight(15);
      String pts = s.pontos.toString().padRight(3);
      String sg = (s.saldoGols >= 0 ? "+${s.saldoGols}" : "${s.saldoGols}").padRight(3);
      String gp = s.golsPro.toString().padRight(3);
      String rank = '${s.rankingFifa}º';

      // 2º PASSO: Aplica a cor no nome baseando-se na posição do time
      String nomeColorido;
      
      if (i == 0) {
        // Liderança (1º Colocado): Nome em AMARELO
        nomeColorido = '${Cores.amarelo}$nomeAlinhado${Cores.reset}';
      } else if (i == selecoes.length - 1) {
        // Lanterna (Último Colocado / Prestes a ser eliminado): Nome em VERMELHO
        nomeColorido = '${Cores.vermelho}$nomeAlinhado${Cores.reset}';
      } else {
        // Demais posições do grupo: Cor padrão do terminal
        nomeColorido = nomeAlinhado;
      }

      // Impressão da linha formatada
      print('$pos  | $nomeColorido | $pts | $sg | $gp | $rank');
      
      // Linha destacada em VERDE para a Zona de Classificação
      if (i == 1) {
        print('${Cores.verde}------------------------------------------------------ (Zona de Classificação)${Cores.reset}');
      }
    }
    print('');
  }
}