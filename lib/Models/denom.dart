class Denom {
  final String note;
  final int value;
  final bool isNote;
  int count;
  double amount;

  Denom({
    required this.note,
    required this.value,
    required this.isNote,
    this.count = 0,
    this.amount = 0,
  });
}
