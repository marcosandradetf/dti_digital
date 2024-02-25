import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'data.dart';

final _formKey = GlobalKey<FormState>();

class NewReminder extends StatefulWidget {
  const NewReminder({super.key});

  @override
  State<NewReminder> createState() => _NewReminderState();
}

class _NewReminderState extends State<NewReminder> {
  DateTime selectedDate = DateTime.now();
  final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
  TextEditingController nameController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  bool isFormValid = true;

  String? validateDate(String? data) {
    if (data == null || data.isEmpty) {
      return 'Selecione a data';
    }

    if (selectedDate.isBefore(DateTime.now())) {
      return 'A data deve ser no futuro';
    }

    return null; // Retorna nulo se a validação for bem-sucedida
  }

  Future<void> _selectedDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = dateFormatter.format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(55),
          child: Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: 0,
                ),
              ],
            ),
            child: AppBar(
              backgroundColor: Colors.white,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "dti",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    width: 50,
                  )
                ],
              ),
              leading: IconButton(
                onPressed: () => GoRouter.of(context).go('/'),
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),
        body: Container(
            color: Colors.white10,
            padding: const EdgeInsets.only(top: 100.0, left: 10.0, right: 10.0),
            child: Card(
                elevation: 5,
                color: const Color(0xFF38C7DA),
                child: Container(
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
                    height: isFormValid ? 250 : 300,
                    padding: const EdgeInsets.all(10.0),
                    child: Form(
                        key: _formKey,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              TextFormField(
                                key: const Key('nome'),
                                controller: nameController,
                                decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nome do Lembrete"),
                                validator: (name) => name!.isEmpty
                                    ? 'Este campo deve ser preenchido'
                                    : null,
                              ),
                              const SizedBox(
                                height: 15.0,
                              ),
                              InkWell(
                                onTap: () {
                                  _selectedDate(context);
                                },
                                child: IgnorePointer(
                                  child: TextFormField(
                                    key: const Key('data'),
                                    controller: dateController,
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "Data do Lembrete",
                                      suffixIcon:
                                          Icon(Icons.calendar_month_outlined),
                                    ),
                                    validator: (data) {
                                      return validateDate(data);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              ElevatedButton(
                                key: const Key('submit'),
                                onPressed: () {
                                  setState(() {
                                    isFormValid = _formKey.currentState!.validate();
                                  });


                                  if (isFormValid) {
                                    String nome = nameController.text;
                                    String data =
                                        dateFormatter.format(selectedDate);
                                    insertDataOnJson(nome, data, context);
                                    nameController.clear();
                                    dateController.clear();
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF35BCD4)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          10.0), // Arredondamento
                                    ),
                                  ),
                                  minimumSize: MaterialStateProperty.all<Size>(
                                      const Size(450.0, 40.0)),
                                ),
                                child: const Text("Criar Lembrete"),
                              )
                            ]))))));
  }
}
