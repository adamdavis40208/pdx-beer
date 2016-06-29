class BaileysParser
  require 'nokogiri'
  require 'open-uri'

  def initialize(url)
    @beers = Array.new
    if url.nil?
      url = 'http://www.baileystaproom.com/draft-list/'
    end
    @page = Nokogiri::HTML(open(url))
  end


  def get_beers
    parse_site(@page)
    save_beers
    #save_beers_to_brew_pub
  end

  def parse_site(page_chunk)
    #each beer is nested in the previous beer
    page_chunk.css('div#boxfielddata').each do |beer|
      inner_brewery_text = beer.css('b>span')
      #some of these have links to the brewery
      #Data looks like:
      #<span>8: <a href="http://www.ancestrybrewing.com" target="_blank">Ancestry</a> <i>Best Coast IPA</i></span>
      #or
      #<span>2: Bauman’s <i>Loganberry</i></span>
      if inner_brewery_text.to_s.index('<a href') != nil
        brewery = inner_brewery_text.to_s.byteslice(inner_brewery_text.to_s.index('blank">')+7..inner_brewery_text.to_s.index('</a')-1)
      else
        brewery = inner_brewery_text.to_s.byteslice(inner_brewery_text.to_s.index(': ')+2..inner_brewery_text.to_s.index(' <i>')-1)
      end
      name = inner_brewery_text.to_s.byteslice(inner_brewery_text.to_s.index('<i>')+3..inner_brewery_text.to_s.index('</i>')-1)

      #Data looks like: "American IPA  7.8% " with a space at the end, so strip it.
      style_abv = beer.at_xpath('//*[@id="boxfielddata"]/text()')
      style_abv = style_abv.to_s.strip

      style = style_abv.to_s.chars.take(style_abv.to_s.rindex(/\s/))
      abv = style_abv[style_abv.to_s.rindex(/\s/)..style_abv.length]
      @beers.push(Hash["name" => name, "brewery" => brewery, "style" => style, "abv" => abv])
    end

  end

  def save_beers


  end

  def save_beers_to_brew_pub
    brewpub = BrewPub.find_or_create(:name=>"Bailey's Taproom")
    @beers.each do |beer|
      beer = Beer.find_or_create(:name=>beer['name'], :brewery=>beer['brewery'],:style=>beer['style'],abv=>beer['abv'])
    end
  end
end