#require
require 'rubygems'
require 'nokogiri'
require 'open-uri'

#Lien du site
$url = "https://www2.assemblee-nationale.fr/"

#Récupération des Href pour aller sur chaque profils
url = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
href = url.css('a[href]')
href_arr = href.map{|l| l['href']}.select{|l| l.match("/deputes/fiche/OMC")}

#Lien du site et le Href
def cmpl_link(arr)
  arr.map do |l|
    $url + l
  end
end

#Stockage des liens pour avoir accès à chaque profils
deputes = cmpl_link(href_arr)

#Récupération des noms
def name(url)
  url = Nokogiri::HTML(URI.open(url))
  name_text= url.css('.titre-bandeau-bleu h1').text
  return name_text
end

#Récupération des mails
def email(url)
  url = Nokogiri::HTML(URI.open(url))
  mail = url.css('.deputes-liste-attributs a[href]')[2]
  if mail == nil
    return nil
  else
    mail = mail.text
    return mail
  end
end

#Le résultat
deputes.map do |e|
  result = []
  result << {name(e) => email(e)}
  puts result
end
