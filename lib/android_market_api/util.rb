require 'sanitize'
require 'net/http'

module AndroidMarketApi
  module Util

    # remove html tags
    # <br> -> \n
    def sanitize(str)
      return str unless str
      str = str.gsub(%r{<br\s*?/?>}, "\n")
      Sanitize.clean(str)
    end

    module_function :sanitize

    def get_content(uri, headers = {})
      url = URI.parse(uri)
      req = Net::HTTP::Get.new(uri)
      headers.each do |name, value|
        req[name] = value
      end
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.request(req)
      }
      res.body
    end

    module_function :get_content

  end
end
