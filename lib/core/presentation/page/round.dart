class round
{
  final int id;
  final String NPC;
  final String ask;
  final String result;
  round({required this.id, required this.NPC, required this.ask, required this.result});
  factory round.fromJson (Map<String, dynamic> data) {
    final id = data['id'];
    final NPC = data['npc'];
    final ask = data['ask'];
    final result = data['result'];
    return round(id: id, NPC: NPC, ask: ask, result: result);
  }
}