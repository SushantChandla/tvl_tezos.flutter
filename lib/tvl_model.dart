class TvlModel {
  int liquidityBalance = 0;
  int liquiditySupply = 0;

  TvlModel({this.liquiditySupply = 0, this.liquidityBalance = 0});

  double get liquidityBalanceInTez => liquidityBalance / 1000000;

  double get tvl => liquidityBalance * 2 / liquiditySupply;
}
