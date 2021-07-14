require_relative '../config/environment'

exit_app = false
prompt = TTY::Prompt.new
logged_in = false
current_user = nil

while exit_app == false
    
if logged_in == false

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
        # binding.pry
        if current_user
            puts "Welcome back, #{current_user.first_name}"
            logged_in = true
        else 
            puts "There is no user with that name"
        end
    elsif welcome_screen == "Exit"
        puts "We hope you enjoyed the app!"
        exit_app = true
        exit
    end    
    
elsif logged_in == true
    player_home_options = ["Create a tournament", "All tournaments", "Your tournaments", "Tournament history", "View Account Balance", "Logout"]
    
    home_screen = prompt.select("Please select from the following options", player_home_options)

    case home_screen
        when "Create a tournament"
            tournament_name = prompt.ask("Tournament name?")
            tournament_type = prompt.ask("Type of tournament?")
            tournament_datetime = prompt.ask("Date and time?")
            tournament_extra_prize = prompt.ask("What's the extra prizepool?")



            # new_tournament = Tournament.create(name: tournament_name, type_id: tournament_type, date_and_time: tournament_datetime, extra_prizepool: tournament_extra_prize, is_reg_open: true, is_active: true)
            puts "New tournament created! Check out your new tournament along all other active tournaments in the All Tournaments section."
        when "All tournaments"
            
        when "Your tournaments"
        when "Tournament history"
        when "View Account Balance"
            exit_page = false
            while exit_page == false
            current_amount = current_user.account_balance
            puts "You currently have $#{current_amount} in your account"
            account_transaction = prompt.select("What would you like to do?", ["Deposit", "Withdraw", "Back"])
                if account_transaction == "Deposit"
                    deposit_amount = prompt.ask("How much would you like to deposit?").to_i
                    current_user.account_balance += deposit_amount
                    puts "Thank you for depositing $#{deposit_amount} into your account. Your current balance is now $#{current_user.account_balance}."
                elsif account_transaction == "Withdraw"
                    withdraw_amount = prompt.ask("How much would you like to withdraw?").to_i
                    if withdraw_amount < current_amount
                        current_user.account_balance -= withdraw_amount
                        puts "You have successfully withdrawn $#{withdraw_amount} from your account. Your current balance is now $#{current_user.account_balance}."
                    else puts "Error: Insufficient funds"
                    end
                else exit_page = true
                end
            end
        when "Logout"
            puts "You have been successfully signed out"
            logged_in = false
            current_user = nil
    end

end


end

# binding.pry
