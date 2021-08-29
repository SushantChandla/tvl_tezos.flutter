import 'package:draw_graph/draw_graph.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tvl/state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MainApp(),
      child: MaterialApp(
        title: 'TVl',
        theme: ThemeData.dark(),
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    final d = context.watch<MainApp>();
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const SizedBox(
                height: 50,
              ),
              Image.asset(
                'assets/tezos_logo.gif',
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Liquidity Baking DEX -> ${d.latest.liquidityBalance} Mutez (${d.latest.liquidityBalanceInTez} Tez)",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                "Liquidity Baking LT -> ${d.latest.liquiditySupply} supply",
                style: const TextStyle(
                  fontSize: 24,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text("TVL ${d.latest.tvl}",
                  style: const TextStyle(
                    fontSize: 29,
                  )),

              const SizedBox(
                height: 10,
              ),

              // LineGraph(features: , size: const Size(400,400)),
            ],
          ),
        ),
      ),
    );
  }
}
