# Copyright 2011 by Helder VAsconcelos (heldervasc@bearstouch.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.

require 'rubygems'
require 'hpricot'
require 'open-uri'
require 'cgi'
require File.expand_path(File.dirname(__FILE__) + "/android_market_application")

class AndroidMarket

  @@game_categories=Array.[]('ARCADE','BRAIN','CARDS','CASUAL','GAME_WALLPAPER','RACING','SPORTS_GAMES','GAME_WIDGETS')
  @@application_categories=Array.[]('BOOKS_AND_REFERENCE','BUSINESS','COMICS','COMMUNICATION','EDUCATION','ENTERTAINMENT','FINANCE','HEALTH_AND_FITNESS','LIBRARIES_AND_DEMO','LIFESTYLE','APP_WALLPAPER','MEDIA_AND_VIDEO','MEDICAL','MUSIC_AND_AUDIO','NEWS_AND_MAGAZINES','PERSONALIZATION','PHOTOGRAPHY','PRODUCTIVITY','SHOPPING','SOCIAL','SPORTS','TOOLS','TRANSPORTATION','TRAVEL_AND_LOCAL','WEATHER','APP_WIDGETS')
  @@languages=Array.[]('en','pt_PT','pt_BR','es','es_419','fr','it','es')

  @@debug=false

  # apps in ranking page
  APP_COUNT_IN_PAGE = 24

  class << self
    include AndroidMarketApi::Util

    def get_top_selling_free_app_in_category(category,position,language='en')
      url = category_url(category, language, position)
      xpath = CATEGORY_TOP_FREE_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_top_selling_paid_app_in_category(category,position,language='en')
      url = category_url(category, language, position)
      xpath = CATEGORY_TOP_PAID_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_free_app(position,language='en')
      url = top_selling_free_url(position, language)
      xpath = OVERALL_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_paid_app(position,language='en')
      url = top_selling_paid_url(position, language)
      xpath = OVERALL_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_overall_top_grossing_app(position,language='en')
      url = top_grossing_url(position, language)
      xpath = OVERALL_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_new_paid_app(position,language='en')
      url = top_selling_new_paid_url(position, language)
      xpath = OVERALL_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_new_free_app(position,language='en')
      url = top_selling_new_free_url(position, language)
      xpath = OVERALL_XPATH
      get_app_in_carousel(url, xpath, language)
    end

    def get_top_selling_free_apps_in_category(category,position,language='en')
      url = category_url(category, language, position)
      xpath = CATEGORY_TOP_FREE_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_top_selling_paid_apps_in_category(category,position,language='en')
      url = category_url(category, language, position)
      xpath = CATEGORY_TOP_PAID_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_free_apps(position,language='en')
      url = top_selling_free_url(position, language)
      xpath = OVERALL_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_paid_apps(position,language='en')
      url = top_selling_paid_url(position, language)
      xpath = OVERALL_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_overall_top_grossing_apps(position,language='en')
      url = top_grossing_url(position, language)
      xpath = OVERALL_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_new_paid_apps(position,language='en')
      url = top_selling_new_paid_url(position, language)
      xpath = OVERALL_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_overall_top_selling_new_free_apps(position,language='en')
      url = top_selling_new_free_url(position, language)
      xpath = OVERALL_XPATH
      get_apps_in_carousel(url, xpath, language)
    end

    def get_developer_app_list(developer_name, position, language='en')
      url="https://play.google.com/store/apps/developer?id=#{CGI.escape(developer_name)}&start=#{position-1}&hl=#{language}"
      xpath = "li[@class='goog-inline-block']"
      get_apps_in_carousel(url, xpath, language)
    end

    def get_languages()
      return @@languages
    end

    def get_game_categories()
      return @@game_categories
    end

    def get_application_categories()
      return @@application_categories
    end

    def debug=(is_debug)
      @@debug = is_debug
    end

    private
    CATEGORY_TOP_FREE_XPATH = "//div[@data-analyticsid='top-free']//div[@class='goog-inline-block carousel-cell']"
    CATEGORY_TOP_PAID_XPATH = "//div[@data-analyticsid='top-paid']//div[@class='goog-inline-block carousel-cell']"
    OVERALL_XPATH = "//div[@class='num-pagination-page']//li[@class='goog-inline-block']"

    def category_url(category, language, position)
      "https://play.google.com/store/apps/category/#{category}?start=#{position-1}&hl=#{language}"
    end

    def top_selling_free_url(position, language)
      "https://play.google.com/store/apps/collection/topselling_free?start=#{position-1}&hl=#{language}"
    end

    def top_selling_paid_url(position, language)
      "https://play.google.com/store/apps/collection/topselling_paid?start=#{position-1}&hl=#{language}"
    end

    def top_grossing_url(position, language)
      "https://play.google.com/store/apps/collection/topgrossing?start=#{position-1}&hl=#{language}"
    end

    def top_selling_new_paid_url(position, language)
      "https://play.google.com/store/apps/collection/topselling_new_paid?start=#{position-1}&hl=#{language}"
    end

    def top_selling_new_free_url(position, language)
      "https://play.google.com/store/apps/collection/topselling_new_free?start=#{position-1}&hl=#{language}"
    end

    def get_app_in_carousel(url, xpath, language)
      doc = Hpricot(get_content(url))
      buy_div=doc.search(xpath).first
      puts "Getting Application package "+buy_div.attributes['data-docid'] if @@debug
      AndroidMarketApplication.new(buy_div.attributes['data-docid'],language)
    end

    def get_apps_in_carousel(url, xpath, language)
      apps = []
      doc = Hpricot(get_content(url))
      doc.search(xpath).each do |buy_div|
        puts "Getting Application package "+buy_div.attributes['data-docid'] if @@debug
        apps << AndroidMarketApplication.new(buy_div.attributes['data-docid'],language)
      end
      apps
    end
  end
end
