import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:signalr_core/signalr_core.dart';
import 'package:tvl/tvl_model.dart';
import 'package:http/http.dart' as http;

class MainApp extends ChangeNotifier {
  TvlModel latest = TvlModel();
  MainApp() {
    _getLatest();
    subscriptToEvent();
  }

  _getLatest() async {
    int balance = (await _getLiquidityBalance())['balance'];
    int supply = int.parse((await _getLiquiditySupply())['total_supply']);
    latest = TvlModel(liquidityBalance: balance, liquiditySupply: supply);
    notifyListeners();
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

  void subscriptToEvent() async {
    final connection = HubConnectionBuilder()
        .withUrl(
          'https://api.tzkt.io/v1/events',
        )
        .build();
    await connection.start();
    await connection.invoke("SubscribeToAccounts", args: [
      {
        "addresses": ['KT1TxqZ8QtKvLu3V3JH7Gx58n7Co8pgtpQU5']
      }
    ]);
    connection.on("accounts", (account) async {
      latest.liquidityBalance = account![0]['data'][0]['balance'];
      latest.liquiditySupply =
          int.parse((await _getLiquiditySupply())['total_supply']);
      notifyListeners();
    });
  }
}
