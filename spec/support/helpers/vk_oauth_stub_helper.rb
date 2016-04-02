require 'json'
require 'hashie'

module VkOauthStubHelper
  def vk_json
    json_string = '{ "auth":
                     { "uid":"111",
                       "provider":"vkontakte"
                     },
                     "info":{ "email": "", "name": "" }
                   }'
    hash = JSON.parse json_string
    Hashie::Mash.new hash
  end

  def vk_new_json
    json_string = '{ "auth":
                     { "uid":"zzz",
                       "provider":"vkontakte"
                     },
                     "info":{ "email": "", "name": "" }
                   }'
    hash = JSON.parse json_string
    Hashie::Mash.new hash
  end
end
