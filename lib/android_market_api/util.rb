require 'sanitize'

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

    def get_content(url)
      open(url,'User-Agent' => 'ruby')
    end

    module_function :get_content
  end
end
