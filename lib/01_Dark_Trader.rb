#require
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Lien du site
 url = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

#Récupération des cryptos en utilisant xpath et css
 sym = url.xpath('.//tbody').css('.cmc-table__cell--sort-by__symbol')
 sym_tx = sym.map{|abc| abc.text}

#Récupération des prix en utilisant xpath et css
 pr = url.xpath('.//tbody').css('.cmc-table__cell--sort-by__price')
 pr_txt = pr.map{|prc| prc.text}

#Conversion de deux arrays en un hash (key = sym_tx ; value = pr_txt)
 def perform(key, value)
   result =[]
   key.each_with_index do |k, v|
     result << {k => (value)[v]}
   end
   puts result
   return result
 end

 perform(sym_tx, pr_txt)
