require_relative "config"
require_relative "settings"
require_relative "monkey_patch"
require_relative "datasource"
require_relative "models"
require_relative "thin_outer"
require "open-uri"
require "json"

Plugin.create(:"mikutter-datasource-exchange") {
  @proc = ThinOuter.new

  @user = ExchangeUser.new_ifnecessary({
    :uri => URI.parse("exchangeuser://singleton"),
    :idname => _("exchange"),
    :name => _("為替"),
    :profile_image_url => Skin["icon.png"].uri.path
  })

  # メッセージを投げる
  def send_message(currency, record)
    message = ExchangeMessage.new_ifnecessary({
      :uri => URI.parse("#{currency[:code]}://#{Time.now.to_i}"),
      :user => @user
    })

    message[:description] = "1#{currency[:name]}=#{record["ask"]}円"
    message[:created] = Time.now

    Plugin.call(:extract_receive_message, :"mikutter_datasource_#{currency[:code]}", [message])
  end

  # 1分周期処理
  on_period { |service|
    if Service.primary == service
      Thread.new {
        @proc.period = UserConfig[:exchange_period]

        @proc.exec {
          begin
            json_raw = open("https://www.gaitameonline.com/rateaj/getrate", "r") { |fp| fp.read }
            json = JSON.parse(json_raw)

            @currencies.each { |currency|
              begin
                record = json["quotes"].find { |_| _["currencyPairCode"] == currency[:code] }

                if record
                  send_message(currency, record)
                end
              rescue => e
                activity(:system, "#{currency[:name]}円情報取得失敗\n#{e}\n#{e.backtrace[0]}")
              end
            }
          rescue => e
            activity(:system, "為替情報取得失敗\n#{e}\n#{e.backtrace[0]}")
          end
        }
      }
    end
  }
}
