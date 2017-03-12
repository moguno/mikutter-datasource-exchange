Plugin.create(:"mikutter-datasource-exchange") {
  UserConfig[:exchange_period] = 1

  # 設定画面
  settings(_("為替")) {
    adjustment(_("表示周期（分）"), :exchange_period, 1, 10000000)
  }
}
