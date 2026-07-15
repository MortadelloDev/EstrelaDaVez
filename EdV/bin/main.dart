import 'dart:io';
import 'package:copa2026_simulator/models/selecao.dart';
import 'package:copa2026_simulator/services/dados_service.dart';
import 'package:copa2026_simulator/services/partida_service.dart';
import 'package:copa2026_simulator/services/tabela_service.dart';

void main() async {
  // Inicialização assíncrona de dados controlada pelo Aluno 4
  List<Selecao> selecoesGrupoA = await DadosService.carregarSelecoesDoServidor();

  if (selecoesGrupoA.isEmpty) {
    print('Não foi possível iniciar o simulador. Abortando.');
    return;
  }

  bool rodando = true;
  while (rodando) {
    print('=== MENU PRINCIPAL COPA 2026 ===');
    print('1. Registrar Resultado de Jogo');
    print('2. Ver Classificação Atual');
    print('3. Sair');
    stdout.write('Opção: ');
    
    String? opcao = stdin.readLineSync();

    switch (opcao) {
      case '1':
        _executarFluxoDeJogo(selecoesGrupoA);
        break;
      case '2':
        // Aluno 3 entra em ação para ordenar e exibir
        TabelaService.ordenarTabela(selecoesGrupoA);
        TabelaService.exibirTabela(selecoesGrupoA);
        break;
      case '3':
        print('\n⚽ Obrigado por usar a Estrela da vez! Até o próximo semestre com Flutter!');
        rodando = false;
        break;
      default:
        print('❌ Opção inválida! Selecione 1, 2 ou 3.\n');
    }
  }
}

// Fluxo auxiliar para o usuário escolher quais seleções vão se enfrentar
void _executarFluxoDeJogo(List<Selecao> selecoes) {
  print('\nEscolha o primeiro time:');
  for (int i = 0; i < selecoes.length; i++) {
    print('${i + 1}. ${selecoes[i].nome}');
  }
  int indexA = _obterIndiceSelecao(selecoes.length) - 1;

  print('\nEscolha o segundo time:');
  for (int i = 0; i < selecoes.length; i++) {
    if (i != indexA) {
      print('${i + 1}. ${selecoes[i].nome}');
    }
  }
  int indexB = _obterIndiceSelecao(selecoes.length) - 1;

  if (indexA == indexB) {
    print('❌ Erro: Uma seleção não pode jogar contra ela mesma!');
    return;
  }

  // Invoca o serviço do Aluno 2
  PartidaService.registrarJogo(selecoes[indexA], selecoes[indexB]);
}

int _obterIndiceSelecao(int max) {
  while (true) {
    try {
      stdout.write('Digite o número correspondente: ');
      String? entrada = stdin.readLineSync();
      int valor = int.parse(entrada!);
      if (valor >= 1 && valor <= max) return valor;
      print('❌ Seleção inválida.');
    } catch (_) {
      print('❌ Entrada inválida. Digite um número.');
    }
  }
}