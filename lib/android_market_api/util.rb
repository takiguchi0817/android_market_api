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

    def get_content(uri)
      url = URI.parse(uri)
      req = Net::HTTP::Get.new(url.path)
      res = Net::HTTP.start(url.host, url.port) {|http|
        args = [Net::HTTP::Get.new(uri)]
        http.request(*args)
      }
      res.body
    end

    module_function :get_content

  end
end
