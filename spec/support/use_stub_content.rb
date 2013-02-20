# -*- coding: utf-8 -*-
require "rspec"

shared_context :use_stub_content do
  before(:all) do
    module AndroidMarketApi
      module Util
        def get_content(url)
          p "stub: #{url}"
        end
      end
    end
  end
end