# #require 'rest-client'
# require 'json'
# #require 'HTTParty'
# #require 'Nokogiri'



# @url = 'https://www.nutritionix.com/food/superone-foods-'


# def get_data_from_api(user_input)
#    response = RestClient.get('https://flatironschool.com/?utm_source=Google&utm_medium=ppc&utm_campaign=1783325438&utm_content=75897432663&utm_term=flatiron%20school&uqaid=393386639725&CjwKCAiArJjvBRACEiwA-WiqqysUEWgTHlwwy7v7cjolAV_3JbyRfmReEHHdaY_eY147Tqo51VOGRBoC8GQQAvD_BwE&gclid=CjwKCAiArJjvBRACEiwA-WiqqysUEWgTHlwwy7v7cjolAV_3JbyRfmReEHHdaY_eY147Tqo51VOGRBoC8GQQAvD_BwE')
#     # res_hash = JSON.parse(response)
#     # binding.pry

#     # response = HTTParty.get(@url + user_input)
#     @parse_page = Nokogiri::HTML(response)
#     # binding.pry
#      puts "DID THE STUFF"
#     #binding.pry
# end



#response =RestClient.get('https://www.nutritionix.com/food/superone-foods-banana')
#response = HTTParty.get('https://www.nutritionix.com/food/superone-foods-banana')
# @parse_page ||= Nokogiri::HTML(response)
#binding.pry