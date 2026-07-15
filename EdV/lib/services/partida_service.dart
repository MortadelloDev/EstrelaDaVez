import 'dart:io';
import '../models/selecao.dart';

class PartidaService {
  // Lição 02 & 08: Interatividade no terminal e manipulação de fluxos
  static void registrarJogo(Selecao timeA, Selecao timeB) {
    print('\n=========================================');
    print('   PARTIDA: ${timeA.nome} x ${timeB.nome}   ');
    print('=========================================');

    int golsA = _lerEntradaValida('Gols do(a) ${timeA.nome}: ');
    int golsB = _lerEntradaValida('Gols do(a) ${timeB.nome}: ');
    
    int caA = _lerEntradaValida('Cartões Amarelos do(a) ${timeA.nome}: ');
    int caB = _lerEntradaValida('Cartões Amarelos do(a) ${timeB.nome}: ');

    int cvA = _lerEntradaValida('Cartões Vermelhos do(a) ${timeA.nome}: ');
    int cvB = _lerEntradaValida('Cartões Vermelhos do(a) ${timeB.nome}: ');

    // Atualização dos Gols
    timeA.golsPro += golsA;
    timeA.golsSofridos += golsB;
    timeB.golsPro += golsB;
    timeB.golsSofridos += golsA;

    // Atualização de Cartões
    timeA.cartoesAmarelos += caA;
    timeA.cartoesVermelhos += cvA;
    timeB.cartoesAmarelos += caB;
    timeB.cartoesVermelhos += cvB;

    // Distribuição de Pontos baseada nas regras do futebol
    if (golsA > golsB) {
      timeA.pontos += 3;
    } else if (golsB > golsA) {
      timeB.pontos += 3;
    } else {
      timeA.pontos += 1;
      timeB.pontos += 1;
    }

    print('\n✅ Partida computada com sucesso!');
  }

  // Integração com o Aluno 4 (Tratamento de erros robusto)
  static int _lerEntradaValida(String texto) {
    while (true) {
      try {
        stdout.write(texto);
        String? entrada = stdin.readLineSync();
        if (entrada == null || entrada.trim().isEmpty) throw FormatException();
        return int.parse(entrada);
      } catch (e) {
        print('❌ Erro: Digite um placar ou número de cartões válido!');
      }
    }
  }
}