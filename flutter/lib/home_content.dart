import 'package:flutter/material.dart';
import 'package:dti_digital/serialize.dart';
import 'package:dti_digital/main.dart';
import 'package:provider/provider.dart';

import 'data.dart';

class EventList extends StatefulWidget {
  final List<EventData> events;

  const EventList({super.key, required this.events});

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
    final List<EventData> events = widget.events;

    return ListView.builder(
        shrinkWrap: true,
        itemCount: events.length,
        itemBuilder: (context, index) {
          final event = events[index];

          return Stack(
            children: [
              Card(
                elevation: 5,
                color: Colors.red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  constraints: const BoxConstraints(),
                  margin: const EdgeInsets.only(left: 5),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    // Cor de fundo do container
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8),
                      // Arredonda o canto superior direito
                      bottomRight: Radius.circular(
                          8), // Arredonda o canto inferior direito
                    ), // Define um raio de 10 para arredondar as bordas
                  ),
                  padding:
                      const EdgeInsets.only(top: 10.0, left: 15.0, bottom: 15),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            'Data: ${event.data}',
                            style: const TextStyle(
                              fontSize: 16.0,
                              color: Colors.orange,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                  backgroundColor: Colors.white,
                                  title: Text("Confirme a exclusão"),
                                  content: Text(
                                      "Você tem certeza de que deseja continuar?"),
                                  actions: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        TextButton(
                                            onPressed: () => { Navigator.of(context).pop(true),deleteDatafromJson(event.nome, context, appState)},
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
                                            child: const Text("Sim")),
                                        TextButton(
                                          onPressed: () =>  Navigator.of(context).pop(true),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all<Color>(
                                                 Colors.red),
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
                                          child: const Text("Não"),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: const Icon(
                                Icons.close,
                                color: Colors.red,
                              ),
                            ),
                          )
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              padding: const EdgeInsets.only(top: 7.0),
                              child: Text(
                                "Nome: ${event.nome}",
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 18.0,
                                ),
                              ))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ],
          );
        });
  }
}
