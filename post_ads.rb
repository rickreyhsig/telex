require 'watir'

# Config file
cnf = YAML::load_file(File.join('./', 'config.yml'))
user = cnf['user']

browser = Watir::Browser.new

browser.goto 'http://brasiltelexbit.com/publicar.php'
browser.text_field(name: 'usernames[]').set user
browser.input(:type =>'submit').click
anuncio_text = browser.link(:id => 'ad'+user+'0').text
p anuncio_text.inspect

browser.goto 'https://office.telexbit.com/'
browser.text_field(name: 'username').set cnf['user']
browser.text_field(name: 'password').set cnf['password']
sleep 30

#sleep 20000
# Give use time to do captcha
browser.link(:text =>'3 - Valide seus anúncios').when_present.click

browser.text_field(id: 'site_ads').set anuncio_text
browser.text_field(id: 'link_ads').set anuncio_text


sleep 20

#puts browser.title
#browser.close