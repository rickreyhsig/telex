require 'watir'

# Config file
cnf = YAML::load_file(File.join('./', 'config.yml'))
user = cnf['user']

browser = Watir::Browser.new

browser.goto 'http://brasiltelexbit.com/publicar.php'
browser.text_field(name: 'usernames[]').set user
browser.input(:type =>'submit').click
anuncio_text = browser.link(:id => 'ad'+user+'0').text

browser.goto 'https://office.telexbit.com/'
browser.text_field(name: 'username').set cnf['user']
browser.text_field(name: 'password').set cnf['password']
sleep 13 # Give use time to do captcha
browser.button(type: 'submit').click

#browser.link(:text =>'3 - Valide seus anúncios').click
browser.goto 'https://office.telexbit.com/Ads/AdsSelectIII'
sleep 15

[0,1,2,3,4].each do |num|
	browser.select_list(:name, "n_adcentral").select_value("0")
	browser.text_field(id: 'site_ads').set anuncio_text
	browser.text_field(id: 'link_ads').set anuncio_text+num.to_s
	browser.button(type: 'submit').click
	sleep 3
	p "#{num} --- \xE2\x9C\x94 "
	browser.goto 'https://office.telexbit.com/Ads/AdsSelectIII'
end

browser.goto 'https://office.telexbit.com/Ads/MyAdcentral'

sleep 10

puts browser.title
browser.close