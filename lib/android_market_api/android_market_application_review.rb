require 'rubygems'

class AndroidMarketApplicationReview

  attr_accessor :author, :app_verison, :date, :title, :text, :rating

  def initialize(doc)
    @author = ""
    @app_version = "";
    @date = ""
    @title = ""
    @text = ""
    @rating = 0
    parse_review_doc(doc)
  end

  def print
    puts "-------------------------------------------------------------"
    puts " author = " + @author.to_s
    puts " app version = " + @app_version
    puts " date = " + @date.to_s
    puts " title = " + @title.to_s
    puts " text = " + @text.to_s
    puts " rating = " + @rating.to_s
    puts "-------------------------------------------------------------"
  end

  def to_hash
    {
      "author" => @author.to_s,
      "app version" => @app_version,
      "date" => @date.to_s,
      "title" => @title.to_s,
      "text" => @text.to_s,
      "rating" => @rating.to_s
    }
  end

  private

  def parse_review_doc(doc)
    if !doc
      return
    end

    fill_author(doc)
    fill_app_verison(doc)
    fill_date(doc)
    fill_title(doc)
    fill_text(doc)
    fill_rating(doc)
  end

  def fill_author(doc)
    author_doc =  doc.at("span[@class='doc-review-author  g-hovercard']")
    if author_doc
      @author = format_market_text(author_doc.inner_text)
    end
  end

  def fill_app_verison(doc)
    doc.to_html.match(/ - バージョン [^<]*/) do |match_data|
      match_text = format_market_text(match_data.to_s)
      @app_version = match_text.slice(6, match_text.size - 1)
    end
  end

  def fill_date(doc)
    review_doc = doc.at("span[@class='doc-review-date']")
    if review_doc
      @date = format_market_text(review_doc.inner_html)
    end
  end

  def fill_title(doc)
    title_doc = doc.at("h4[@class='review-title']")
    if title_doc
      @title = title_doc.inner_html
    end
  end

  def fill_text(doc)
    text_doc = doc.at("p[@class='review-text']")
    if text_doc
      @text = text_doc.inner_html
    end
  end

  def fill_rating(doc)
    rating_doc_list = (doc/"div[@class='goog-inline-block star SPRITE_star_on_dark']")
    @rating = rating_doc_list.size
  end

  def format_market_text(text)
    text.slice(3, text.size - 1)
  end

end
