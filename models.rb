# 為替ユーザーモデル
class ExchangeUser < Retriever::Model
  include Retriever::Model::UserMixin

  register(:exchange_user, name: Plugin[:"mikutter-datasource-exchange"]._("為替"))

  field.string(:idname, required: true)
  field.string(:name, required: true)
  field.string(:uri, required: true)
  field.string(:profile_image_url, required: true)
end

# 為替メッセージモデル
class ExchangeMessage < Retriever::Model
  include Retriever::Model::MessageMixin

  register(:exchange_message, name: Plugin[:"mikutter-datasource-exchange"]._("為替"))

  field.string(:description, required: false)
  field.time(:created, required: false)
  field.string(:uri, required: true)
  field.has(:user, ExchangeUser, required: true)
end


