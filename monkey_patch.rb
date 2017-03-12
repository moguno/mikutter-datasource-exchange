Plugin.create(:"mikutter-datasource-exchange") {
  # メッセージのアイコンをちっちゃくするクソパッチ
  class Gdk::MiraclePainter
    alias :initialize_org :initialize

    def initialize(message, *coodinate)
      initialize_org(message, *coodinate)

      if message.is_a?(ExchangeMessage)
        self.icon_width = 24
        self.icon_height = 24
      end
    end
  end
}
