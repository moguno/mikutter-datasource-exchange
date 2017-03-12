Plugin.create(:"mikutter-datasource-exchange") {
  # 通貨の定義
  @currencies = [
    { :code => "USDJPY", :name => "ドル" },
    { :code => "EURJPY", :name => "ユーロ" },
    { :code => "GBPJPY", :name => "ポンド" },
    { :code => "AUDJPY", :name => "豪ドル" },
    { :code => "NZDJPY", :name => "ＮＺドル" },
    { :code => "ZARJPY", :name => "南アランド" },
  ]
}
