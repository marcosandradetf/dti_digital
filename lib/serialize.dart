class EventData {
  final String nome;
  final String data;

  EventData({
    required this.nome,
    required this.data,
  });

  factory EventData.fromJson(Map<String, dynamic> json) {
    return EventData(
      nome: json["nome"] ?? "",
      data: json["data"] ?? "",
    );
  }
}
