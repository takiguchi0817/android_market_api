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

    def get_content(url, headers = {})
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true  if url.start_with?("https://")

      res = http.start {|http|
        req = Net::HTTP::Get.new(url)
        headers.each do |name, value|
          req[name] = value
        end
        http.request(req)
      }

      res.body
    end

    module_function :get_content

  end
end
