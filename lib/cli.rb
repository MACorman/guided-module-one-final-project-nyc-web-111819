require "tty-prompt"
@prompt = TTY::Prompt.new

def welcome
    puts "Welcome to Healthy Eating: The World's Largest Nutrition Database!"
    username
end

def username
    user_input_name = @prompt.ask("Please enter your Username.", required: true)
    password(user_input_name)
    #recieve_username
   # password
end

# def recieve_username
#     # test = gets
#     # user_input_name = gets.chomp
#     binding.pry
#     password(user_input_name)
# end

def password(user_input_name)
    user_input_pass = @prompt.mask("Please enter your Password.", required: true)
#     recieve_pass(user_input_name)
#     # user_choose_food
# end 

# def recieve_pass(user_input_name)
#     user_input_pass = gets.chomp
#     binding.pry
    User.find_or_create_by(username: user_input_name, password: user_input_pass)
    return 
    #user_choose_food
    
end

# def user_choose_food
#     puts "Please enter a food you would like to look up."
#     #get user input
#     user_input = gets.chomp
#     #get_data_from_api(user_input)
#     #Query.create(Food.find_by(name: user_input).id, User.find_by(username: self).id)
# end 