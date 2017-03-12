require_relative "config"

Plugin.create(:"mikutter-datasource-exchange") {
  # データソース
  filter_extract_datasources { |datasources|
    @currencies.each { |currency|
      datasources[:"mikutter_datasource_#{currency[:code]}"] = _("為替") + "/" + _("#{currency[:name]}円")
    }

    [datasources]
  }
}
