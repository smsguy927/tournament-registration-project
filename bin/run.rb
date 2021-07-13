require_relative '../config/environment'

prompt = TTY::Prompt.new
current_user = nil
logged_in = false

welcome_screen = prompt.select('What would you like to do?', ['Login', 'Sign Up', "Exit"])

if welcome_screen == "Sign Up"
    first_name = prompt.ask("First Name:")
    last_name = prompt.ask("Last Name:")
    initial_balance = prompt.ask("How much would you like to transfer as an initial amount to your account?")
    # password = prompt.mask("Create a Password:")

    existing_user = Player.all.find{|player| player.first_name == first_name && player.last_name == last_name}

    if first_name == existing_user.first_name && last_name == existing_user.last_name
        puts "A user with that name already exists"
    else 
        current_user = Player.create(first_name: first_name, last_name: last_name, account_balance: initial_balance) #&& player.password == password
        puts "Welcome to Virtual Poker, #{current_user.first_name}"
        logged_in = true
    end
    
elsif welcome_screen == "Login"
    first_name = prompt.ask("Enter your First Name:")
    last_name = prompt.ask("Enter your Last Name:")
    # password = prompt.mask("Create a Password:")
    # role = prompt.select("What is your role?", ["Player", "Dealer", "Manager"])
    current_user = Player.all.find{|player| player.first_name == first_name && player.last_name == last_name} #&& player.password == password
    if current_user
        puts "Welcome back, #{current_user.name}"
        logged_in = true
    else 
        puts "There is no user with that name"
    end
elsif welcome_screen == "Exit"
    puts "We hope you enjoyed the app!"
    exit
end

if logged_in 
else welcome_screen = prompt.select('What would you like to do?', ['Login', 'Sign Up'])
end

# binding.pry