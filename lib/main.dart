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
                'assets/tezos-xtz-logo.png',
                height: 100,
              ),
              const SizedBox(
                height: 30,
              ),

              DataTable(
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Name',
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'Value',
                    ),
                  ),
                ],
                rows: <DataRow>[
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('Liquidity Baking DEX')),
                      DataCell(Text(
                          '${d.latest.liquidityBalance} Mutez (${d.latest.liquidityBalanceInTez} Tez)')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('Liquidity Baking DEX * 2')),
                      DataCell(Text(
                          '${d.latest.liquidityBalance*2} Mutez (${d.latest.liquidityBalanceInTez*2} Tez)')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('Liquidity Baking LT')),
                      DataCell(Text('${d.latest.liquiditySupply} supply')),
                    ],
                  ),
                  DataRow(
                    cells: <DataCell>[
                      const DataCell(Text('Ratio')),
                      DataCell(Text('${d.latest.tvl}',style:const TextStyle(fontSize: 30),)),
                    ],
                  ),
                ],
              ),

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
