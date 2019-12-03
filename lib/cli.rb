require "tty-prompt"
@prompt = TTY::Prompt.new

system 'clear'

def welcome
    puts "Welcome to Healthy Eating: The World's Largest Nutrition Database!"
    username
end

def username
    @user_input_name = @prompt.ask("Please enter your Username.", required: true)
    password
end

def password
    user_input_pass = @prompt.mask("Please enter your Password.", required: true)
    @user_instance = User.find_or_create_by(username: @user_input_name, password: user_input_pass)
    system 'clear'
    main_menu
end

def main_menu
    ans = @prompt.select("Choose an one of the following options.", ["See saved searches.", "Create new search.", "Log Out", "Quit"])
    if ans == "See saved searches."
        @new_array = (@user_instance.foods.map {|data| data.name}).uniq
        system 'clear'
        search_saved_query
    elsif ans == "Create new search."
        search_new_query
    elsif ans == "Log Out"
        welcome
    else
        ans == "Quit"
        exit
    end  
end

def search_saved_query
    ans = @prompt.select("Choose from an existing search.", [@new_array, "Delete saved search.", "Back"])
    if ans == "Back"
        main_menu
    elsif ans == "Delete saved search."
        delete_saved_search
    else
    @chosen_food = Food.find_by(name: ans)
    system 'clear'
    print_chosen_food
    end
end

def delete_saved_search
    delete_search = @prompt.ask("Please enter the name of the search you would like to delete.", required: true)
    delete_food_id = Food.find_by(name: delete_search).id
    Query.find_by(food_id: delete_food_id).destroy
    system 'clear'
    puts "Search deleted!"
end

def print_chosen_food
    puts "name: #{@chosen_food.name}"
    puts "serving size: #{@chosen_food.serving_size}"
    puts "calories: #{@chosen_food.calories}"
    puts "total fat: #{@chosen_food.total_fat}"
    puts "cholesterol: #{@chosen_food.cholesterol}"
    puts "sodium: #{@chosen_food.sodium}"
    puts "total carbohydrates: #{@chosen_food.total_carbohydrate}"
    puts "sugar: #{@chosen_food.sugar}"
    puts "protein: #{@chosen_food.protein}"
    now_what
end

def now_what
    ans = @prompt.select("Now what?", ["Back", "Main Menu"])
    if ans == "Back"
        search_saved_query
    else
        main_menu
    end
end


def search_new_query
    ans = @prompt.select("Choose one of the following options.", ["Please enter a food you would like to look up.", "Back"])
    if ans == "Back"
        main_menu
    else
        user_input = gets.chomp
        input_food_id = Food.find_by(name: user_input).id
        input_user_id = User.find_by(username: @user_input_name).id
        @query_instance = Query.new(food_id: input_food_id, user_id: input_user_id)
        @food_deets = @query_instance.food
        system 'clear'
        print_new_food_search
    end
end 

def print_new_food_search
    puts "name: #{@food_deets.name}"
    puts "serving size: #{@food_deets.serving_size}"
    puts "calories: #{@food_deets.calories}"
    puts "total fat: #{@food_deets.total_fat}"
    puts "cholesterol: #{@food_deets.cholesterol}"
    puts "sodium: #{@food_deets.sodium}"
    puts "total carbohydrates: #{@food_deets.total_carbohydrate}"
    puts "sugar: #{@food_deets.sugar}"
    puts "protein: #{@food_deets.protein}"
    save_new_search
end

def save_new_search
    ans = @prompt.select("What's the plan?", ["Save", "Back"])
    if ans == "Back"
        search_new_query
        binding.pry
    else
        puts "Saved search!"
        @query_instance.save
        system 'clear'
    binding.pry
    end
end