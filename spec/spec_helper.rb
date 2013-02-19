# -*- coding: utf-8 -*-

require "android_market_api"
require "rspec"
require "pry"
require "memoist"
require File.expand_path(File.dirname(__FILE__) + "/../spec/matchers/array_instance_of")

RSpec.configure do |config|
  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"

  # memorize AndroidMarketApi::Util.get_content
  # because, many requests are rejected by google
  config.before(:suite) do
    module AndroidMarketApi
      module Util
        extend Memoist
        memoize :get_content
      end
    end
  end
end
