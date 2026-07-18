import 'package:flutter/material.dart';
import 'package:cash_tally/models/denom.dart';

class GrandTotalProvider extends ChangeNotifier {
  static const List<int> notes = [2000, 500, 200, 100, 50, 20, 10, 20, 5, 2, 1];

  final Map<String, Denom> _subTotals = {
    "2000_note": Denom(note: "2000", value: 2000, isNote: true),
    "500_note": Denom(note: "500", value: 500, isNote: true),
    "200_note": Denom(note: "200", value: 200, isNote: true),
    "100_note": Denom(note: "100", value: 100, isNote: true),
    "50_note": Denom(note: "50", value: 50, isNote: true),

    "20_note": Denom(note: "20", value: 20, isNote: true),
    "10_note": Denom(note: "10", value: 10, isNote: true),

    "20_coin": Denom(note: "20", value: 20, isNote: false),
    "10_coin": Denom(note: "10", value: 10, isNote: false),

    "5_coin": Denom(note: "5", value: 5, isNote: false),
    "2_coin": Denom(note: "2", value: 2, isNote: false),
    "1_coin": Denom(note: "1", value: 1, isNote: false),
  };

  final List<double> upiAmounts = [];

  double _expected = 0;
  double _upiAmount = 0;

  Map<String, Denom> get subTotals => _subTotals;

  double get expected => _expected;
  double get upiAmount => _upiAmount;
  double get grandTotal {
    double sum = 0;

    for (var item in _subTotals.values) {
      sum += item.amount;
    }

    for (var item in upiAmounts) {
      sum += item;
    }

    return sum;
  }

  Map<String, Denom> get subTotal => _subTotals;
  double get difference => expected - grandTotal;

  //Contributions
  double get cashTotal {
    double total = 0;

    for (final denom in _subTotals.values) {
      total += denom.amount;
    }

    return total;
  }

  double get upiTotal {
    double total = 0;

    for (final amount in upiAmounts) {
      total += amount;
    }

    return total;
  }

  double get cashPercent {
    if (grandTotal == 0) return 0;
    return (cashTotal / grandTotal) * 100;
  }

  double get upiPercent {
    if (grandTotal == 0) return 0;
    return (upiTotal / grandTotal) * 100;
  }

  /// -1 = Short
  ///  0 = Match
  ///  1 = Excess
  int get status {
    if (difference.abs() < 0.01) return 0;
    return difference > 0 ? -1 : 1;
  }

  void updateUpiAmount(double value) {
    _upiAmount = value;
    upiAmounts.add(value);
    notifyListeners();
  }

  void updateExpected(double value) {
    _expected = value;
    notifyListeners();
  }

  void updateCount(String denomination, int count) {
    final denom = _subTotals[denomination];
    if (denom == null) return;

    denom.count = count;
    denom.amount = denom.value * count.toDouble();

    notifyListeners();
  }

  void clear() {
    _expected = 0;
    _upiAmount = 0;

    upiAmounts.clear();

    for (final denom in _subTotals.values) {
      denom.count = 0;
      denom.amount = 0;
    }

    notifyListeners();
  }
}
