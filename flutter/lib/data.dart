import 'package:dti_digital/serialize.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:dio/dio.dart';

//
String ip = "localhost";
String porta = "8090";
Dio dio = Dio(BaseOptions(baseUrl: 'http://$ip:$porta'));


Future<List<EventData>> fetchData(DateTime newDate) async {
  DateTime currentDate = newDate;
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');

  try {
    Response response = await dio.get("/events");

    if (response.statusCode == 200) {
      // Filtre os eventos durante a leitura da resposta
      final List<EventData> events = (response.data as List)
          .map((json) => EventData.fromJson(json))
          .where((event) => event.data == dateFormatter.format(currentDate))
          .toList();

      return events;
    } else {
      // Trate outros códigos de status, se necessário
      if (kDebugMode) {
        print('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
      }
      throw Exception('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
    }
  } catch (e) {
    // Lidar com exceções, se houver algum problema na solicitação
    if (kDebugMode) {
      print('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
    }
    throw Exception('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
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

    Response response = await dio.post(
      "/events",
      data: formData,
    );

    // Verifique a resposta
    if (response.statusCode == 200) {
      // Requisição bem-sucedida, você pode processar a resposta aqui
      if (kDebugMode) {
        print('Requisição POST bem-sucedida!');
      }
      if (kDebugMode) {
        print('Resposta: ${response.data}');
      }
    } else {
      // Requisição falhou
      if (kDebugMode) {
        print('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
      }
    }

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
      print('*** Erro - ip: Altere a variavel ip na linha 9 do arquivo lib/data.dart para o endereço ipv4 da sua maquina ***');
    }
  }
}

void deleteDatafromJson(String nome, context, appState) async {
  try {
    // Realiza a requisição DELETE
    Response response = await dio.delete('/events/$nome');

    // Verifica se a requisição foi bem-sucedida
    if (response.statusCode == 200) {
        if (kDebugMode) {
        print('Evento deletado com sucesso!');
      }
    } else {
      throw Exception('Falha ao deletar o evento. Código de resposta: ${response.statusCode}');
    }

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
