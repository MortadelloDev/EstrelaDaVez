import 'dart:convert';
import '../models/selecao.dart';

class DadosService {
  // Lição 03 & 11: Simulação assíncrona de busca de dados na Web
  static Future<List<Selecao>> carregarSelecoesDoServidor() async {
    print('⏳ Conectando à API da FIFA para obter dados do grupo...');
    await Future.delayed(Duration(seconds: 2)); // Simula o lag da internet

    // Lição 09: String simulando uma resposta JSON estruturada
    String jsonMock = '''
    [
      {"nome": "México", "grupo": "A", "rankingFifa": 15},
      {"nome": "África do Sul", "grupo": "A", "rankingFifa": 59},
      {"nome": "Rep. Checa", "grupo": "A", "rankingFifa": 36},
      {"nome": "Coreia do Sul", "grupo": "A", "rankingFifa": 22}
    ]
    ''';

    // Lição 06: Tratamento elegante de falhas na conversão dos dados
    try {
      List<dynamic> dadosDecodificados = jsonDecode(jsonMock);
      
      return dadosDecodificados.map((item) {
        return Selecao(
          nome: item['nome'],
          grupo: Grupo.values.firstWhere((g) => g.name == item['grupo']),
          rankingFifa: item['rankingFifa'],
        );
      }).toList();
    } catch (e) {
      print('❌ Erro crítico ao processar os dados da Copa. Carregando dados de contingência...');
      return [];
    }
  }
}