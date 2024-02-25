import 'dart:convert';
import 'dart:io';
import 'package:dti_digital/serialize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';


Future<List<EventData>> fetchData(DateTime newDate) async {
  DateTime currentDate = newDate;
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String documentsPath = documentsDirectory.path;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  try {
    // Carrega o conteúdo do arquivo JSON local
    final File file = File("$documentsPath/form_data.json");

    // Verifica se o arquivo existe
    if (!(await file.exists())) {
      return [];
    }

    // carregando JSON
    final List<String> jsonLines = await file.readAsLines();

    // converter linhas em objetos EventData
    final List<EventData> events =
        jsonLines.map((json) => EventData.fromJson(jsonDecode(json))).toList();

    // filtro
    final eventDay = events
        .where((event) => event.data == dateFormatter.format(currentDate))
        .toList();

    return eventDay;
  } catch (error) {
    throw Exception('Falha ao carregar os dados: $error');
  }
}

Future<void> insertDataOnJson(
    String nome, String data, BuildContext context) async {
  try {
    // Criando um mapa com os dados
    Map<String, dynamic> formData = {
      'nome': nome,
      'data': data,
    };

    // Codificando o mapa para uma string JSON
    String jsonData = jsonEncode(formData);

    // Obtendo o caminho do diretório de documentos do aplicativo
    String documentsPath = (await getApplicationDocumentsDirectory()).path;

    // Cria o arquivo ou abre se já existir
    File file = File('$documentsPath/form_data.json');

    // Escreve os dados JSON no arquivo
    file.writeAsString('$jsonData\n', mode: FileMode.append);

    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Lembrete criado com sucesso!"),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                        onPressed: () => GoRouter.of(context).go('/'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              const Color(0xFF35BCD4)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(10.0), // Arredondamento
                            ),
                          ),
                          minimumSize: MaterialStateProperty.all<Size>(
                              const Size(100.0, 40.0)),
                        ),
                        child: const Text("Voltar ao Início")),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            const Color(0xFF35BCD4)),
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.white),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(10.0), // Arredondamento
                          ),
                        ),
                        minimumSize: MaterialStateProperty.all<Size>(
                            const Size(50.0, 40.0)),
                      ),
                      child: const Text("Ok"),
                    )
                  ],
                ),
              ],
            );
          });
    }
  } catch (e) {
    if (kDebugMode) {
      print("Erro ao salvar o arquivo: $e");
    }
  }
}

void deleteDatafromJson(String nome, context, appState) async {
  Directory documentsDirectory = await getApplicationDocumentsDirectory();
  String documentsPath = documentsDirectory.path;

  try {
    // ler json file
    File file = File("$documentsPath/form_data.json");
    List<String> jsonLines = await file.readAsLines();

    // analisa json
    List<dynamic> data = jsonLines.map((line) => json.decode(line)).toList();

    // deletando a entrada
    data.removeWhere((element) => element["nome"] == nome);

    // converte os dados atualizados de volta no JSON
    List<String> updatedJson = data.map((entry) => json.encode(entry)).toList();

    // Adiciona uma quebra de linha no final do arquivo
    updatedJson.add('');

    // escreve os dados atualizados no JSON
    await file.writeAsString(updatedJson.join("\n"), mode: FileMode.write);

    // Notifica os ouvintes sobre a mudança nos dados
    appState.notifyListeners();

    if (context.mounted) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              title: const Text("Lembrete excluído com sucesso!"),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        const Color(0xFF35BCD4)),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Arredondamento
                      ),
                    ),
                    minimumSize:
                        MaterialStateProperty.all<Size>(const Size(50.0, 40.0)),
                  ),
                  child: const Text("Ok"),
                )
              ],
            );
          });

    }
  } catch (error) {
    throw Exception('Falha ao apagar o dado: $error');
  }
}
