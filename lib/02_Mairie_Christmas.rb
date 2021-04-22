#require
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Lien du site
$url = "http://annuaire-des-mairies.com/"

#Récupération des Href pour chaque ville de Val d'oise
url = Nokogiri::HTML(URI.open("http://annuaire-des-mairies.com/val-d-oise.html"))
href = url.css('.lientxt[href]')
href_arr = href.map do |l|
  l['href'].gsub(/^./, '')
end

#map du lien de base pour ouvrir chaque page
def cmpl_link(arr)
  arr.map do |l|
    $url + l
  end
end

#Création d'un array pour y mettre chaque villes
city = cmpl_link(href_arr)

#Récupération des emails de chaque villes
def get_townhall_email(townhall_url)
  link_emails = URI.open(townhall_url)
  url = Nokogiri::HTML(link_emails.read)
  x = url.css('tbody tr')
  arr = x[3].text.split
  return arr[2]
end

#Récupérations des noms de chaque villes
def citys(url)
  url = Nokogiri::HTML(URI.open(url))
  href = url.css('.col-lg-offset-1')
  text = href.text.split
  return text[0]
end

#Le résultat
city.map do |e|
  result = []
  result << {citys(e) => get_townhall_email(e)}
  puts result
end
