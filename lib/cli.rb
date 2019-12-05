require 'colorize'
require "tty-prompt"
@prompt = TTY::Prompt.new

def yeet
    #clears DEPRECATION WARNING to make the app look neater
    system 'clear'
end

def welcome
    yeet
    puts "Welcome to the FRESHEST nutrition look-up app *not* on the market!".colorize(:color => :green, :background => :light_yellow)
    front_page
end

def front_page
    #existing users log in and new users create an account 
    ans = @prompt.select("Please choose one of the following options.", ["Log in", "Change password", "Create account"])
    if ans == "Log in"
        username
        existing_user_password
    elsif
        ans == "Change password"
        username
        change_password
    else 
        username
        creating_user_password
    end
end

def username
    @user_input_name = @prompt.ask("Please enter your Username.", required: true)
    
end

def existing_user_password
    #identifies user by their input values. If user does not exist in database based on values entered, returns incorrect log in and directs to front page. Otherwise, logs user in
    user_input_pass = @prompt.mask("Please enter your Password.", required: true)
    @user_instance = User.find_by(username: @user_input_name, password: user_input_pass)
    binding.pry
    if @user_instance == nil
        yeet
        puts "Incorrect log in".colorize(:color => :magenta)
        front_page
    else
        main_menu
    end
    yeet
    main_menu
end

def creating_user_password
    #new users create password and are directed to main menu
    user_input_pass = @prompt.mask("Please enter your Password.", required: true)
    @user_instance = User.create(username: @user_input_name, password: user_input_pass)
    yeet
    main_menu
end

def change_password
    new_password = @prompt.mask("Please enter a new password.", required: true)
    @user_instance = User.find_by(username: @user_input_name)
    @user_instance.update(password: new_password)
    yeet
    puts "Password updated!".colorize(:color => :cyan)
    main_menu
end

def main_menu
   #@user_instance.reload
    yeet
    ans = @prompt.select("Please choose one of the following options.", ["Instantiate new search", "View saved searches", "Log out", "Quit".colorize(:color => :red)])
    if ans == "View saved searches"
        @new_array = (@user_instance.foods.map {|data| data.name}).uniq
        yeet
        saved_queries
    elsif ans == "Instantiate new search"
        new_query
    elsif ans == "Log out"
        front_page
    else
        ans == "Quit"
        exit
    end  
end

def new_query
    #user enters search term. Downcase and singularize so app doesn't break when terms like "APPLE", "Cherry", or "hams" are entered. If food does not exist in database, directs to food_not_found method
    ans = @prompt.select("Please choose one of the following options.", ["Enter the food/beverage you would like to search", "Main Menu"])
    if ans == "Main Menu"
        main_menu
    else
        user_input = gets.chomp.downcase.singularize
        input_food_name = Food.find_by(name: user_input)
        if input_food_name == nil
            yeet
            food_not_found
        else input_food_id = input_food_name.id
            input_user_id = User.find_by(username: @user_input_name).id
            @query_instance = Query.new(food_id: input_food_id, user_id: input_user_id)
            @food_deets = @query_instance.food
            yeet
            print_new_food
        end
    end
end 

def food_not_found
    ans = @prompt.select("Sorry, that is outside our scope. What would you like to do?", ["Start new search", "Main Menu"])
    if ans == "Start new search"
        new_query
    else
        main_menu
    end
end

def print_new_food
    puts "| Name                   |    #{@food_deets.name.capitalize}".colorize(:color => :green)
    puts "|________________________|________________________".colorize(:color => :green)
    puts "| Serving Size           |    #{@food_deets.serving_size}".colorize(:color => :green)
    puts "| Calories               |    #{@food_deets.calories}".colorize(:color => :green)
    puts "| Total Fat              |    #{@food_deets.total_fat}".colorize(:color => :green)
    puts "| Cholesterol            |    #{@food_deets.cholesterol}".colorize(:color => :green)
    puts "| Sodium                 |    #{@food_deets.sodium}".colorize(:color => :green)
    puts "| Total Carbohydrates    |    #{@food_deets.total_carbohydrate}".colorize(:color => :green)
    puts "| Sugar                  |    #{@food_deets.sugar}".colorize(:color => :green)
    puts "| Protein                |    #{@food_deets.protein}".colorize(:color => :green)
    save_new_search
end

def save_new_search
    ans = @prompt.select("Please choose one of the following options.", ["Save", "Start new search"])
    if ans == "Start new search"
        new_query
    else
        @query_instance.save
        @user_instance.foods.reload
        yeet
        puts "Saved search!".colorize(:color => :cyan)
        return_to_main_menu_or_quit
    end
end

def return_to_main_menu_or_quit
    ans = @prompt.select("Please choose one of the following options.", ["Main Menu", "Quit".colorize(:color => :red)])
    if ans == "Quit"
        exit
    else
        main_menu
    end
end 

def saved_queries
    ans = @prompt.select("Choose from an existing search.", [@new_array, "Delete saved search", "Main Menu"])
    if ans == "Main Menu"
        main_menu
    elsif ans == "Delete saved search"
        delete_saved_search
    else
        @chosen_food = Food.find_by(name: ans)
        yeet
        print_saved_food
    end
end

def delete_saved_search
    user_input = @prompt.ask("Please enter the name of the search you would like to delete.", required: true).downcase.singularize
    if @new_array.any? {|food| food==user_input} == false
        ans = @prompt.select("The item was not found in your saved searches. What would you like to do?", ["Search Again", "Main Menu"])
        if ans == "Search Again"
            saved_queries
        else 
            main_menu
        end
    else delete_food_id = Food.find_by(name: user_input).id
        Query.find_by(food_id: delete_food_id).destroy
        @user_instance.foods.reload   
        yeet
        puts "Search deleted!".colorize(:color => :magenta)
        return_to_main_menu_or_quit
    end
end

def print_saved_food
    puts "| Name                   |   #{@chosen_food.name.capitalize}".colorize(:color => :green)
    puts "|________________________|_________________________".colorize(:color => :green)
    puts "| Serving Size           |   #{@chosen_food.serving_size}".colorize(:color => :green)
    puts "| Calories               |   #{@chosen_food.calories}".colorize(:color => :green)
    puts "| Total Fat              |   #{@chosen_food.total_fat}".colorize(:color => :green)
    puts "| Cholesterol            |   #{@chosen_food.cholesterol}".colorize(:color => :green)
    puts "| Sodium                 |   #{@chosen_food.sodium}".colorize(:color => :green)
    puts "| Total Carbohydrates    |   #{@chosen_food.total_carbohydrate}".colorize(:color => :green)
    puts "| Sugar                  |   #{@chosen_food.sugar}".colorize(:color => :green)
    puts "| Protein                |   #{@chosen_food.protein}".colorize(:color => :green)
    saved_queries_or_main_menu
end

def saved_queries_or_main_menu
    ans = @prompt.select("What would you like to do?", ["Back to saved searches", "Main Menu"])
    if ans == "Back to saved searches"
        saved_queries
    else
        main_menu
    end
end
