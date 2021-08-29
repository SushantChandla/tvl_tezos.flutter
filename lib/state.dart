import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:tvl/tvl_model.dart';
import 'package:http/http.dart' as http;

class MainApp extends ChangeNotifier {
  TvlModel latest = TvlModel();
  MainApp() {
    jobPool();
  }

  jobPool() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _getLatest();
    });
  }

  _getLatest() async {
    int balance = (await _getLiquidityBalance())['balance'];
    int supply = int.parse((await _getLiquiditySupply())['total_supply']);
    if (latest.liquidityBalance != balance ||
        latest.liquiditySupply != supply) {
      latest = TvlModel(liquidityBalance: balance, liquiditySupply: supply);
      notifyListeners();
    }
  }

  Future _getLiquidityBalance() async {
    return jsonDecode((await http.get(Uri.parse(
            "https://api.tzkt.io/v1/accounts/KT1TxqZ8QtKvLu3V3JH7Gx58n7Co8pgtpQU5")))
        .body);
  }

  Future _getLiquiditySupply() async {
    return jsonDecode((await http.get(Uri.parse(
            "https://api.tzkt.io/v1/contracts/KT1AafHA1C1vk959wvHWBispY9Y2f3fxBUUo/storage")))
        .body);
  }
}
