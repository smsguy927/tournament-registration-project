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
    player_home_options = ["Create a tournament", "Manage tournaments", "All tournaments", "Register for a tournament", "My active tournaments", "My tournament history", "View Account Balance", "Logout"]
    
    home_screen = prompt.select("Please select from the following options", player_home_options)

    case home_screen
        when "Create a tournament"
            tournament_name = prompt.ask("Tournament name?")
            tournament_type = prompt.ask("Type of tournament?")
            tournament_datetime = prompt.ask("Date and time?")
            tournament_extra_prize = prompt.ask("What's the extra prizepool?")

            # new_tournament = Tournament.create(name: tournament_name, type_id: tournament_type, date_and_time: tournament_datetime, extra_prizepool: tournament_extra_prize, is_reg_open: true, is_active: true)
            # Here's how to create a tournament
            #
            # Tournament.create(date_and_time: "2021-07-20 13:15", type_id: afternoon_turbo.id)
            # Use Tournament.display_types to display tournament types with IDs
            #
            # Here's how to create a tournament type
            #
            # TournamentType.create(name: 'Afternoon Turbo', buy_in: 50, max_reentries: 1, percent_paid: 12.5)
            #
            puts "New tournament created! Check out your new tournament along all other active tournaments in the All Tournaments section."
        when "Manage tournaments"
            exit_page = false
            while exit_page == false
            active_tournament_list = [Tournament.all.where(is_active: true)]
            active_tournament_list << "Go Back"
            selected_tournament = prompt.select("Select a tournament you'd like to manage", active_tournament_list)
            if selected_tournament == "Go Back"
                exit_page = true
            else
                puts "You've selected:"
                puts "Tournament ID: #{selected_tournament.id}"
                puts "Tournament Name: #{selected_tournament.tournament_name}"
                puts "Tournament Date: #{selected_tournament.date_and_time}"
                puts "Total Players: #{selected_tournament.total_players}"
                puts "Remaining Players: #{selected_tournament.remaining_players}"
                puts "Total Prize Pool: #{selected_tournament.total_prizepool}"
                answer = prompt.select("What would you like to do?", ["Manage players", "Close to new registrants", "End tournament", "Go Back"])
                    case answer
                    when "Close to new registrants"
                        if prompt.yes?("Are you sure you would like to close the tournament to new registrants??")
                            selected_tournament.close_registration
                            puts "Registration has been closed for this tournament"
                        end
                    when "Manage players"
                        exit_players = false
                        while exit_players == false
                            tournament_registrants = [selected_tournament.players]
                            tournament_registrants << "Go Back"
                            selected_player = prompt.select("Select a player in this tournament", tournament_registrants)
                            if selected_player == "Go Back"
                                exit_players = true
                            else
                                puts "You've selected:"
                                puts "Player ID: #{selected_player.id}"
                                puts "Player Name: #{selected_player.full_name}"
                                if prompt.yes?("Would you like to remove #{selected_player.first_name} from the tournament?")
                                    #Remove from tournament function
                                    puts "#{selected_player.first_name} is no longer in the tournament."
                                end
                            end
                        end
                    when "End tournament"
                        if prompt.yes?("Are you sure you would like to end the tournament??")
                            selected_tournament.is_active = false
                            puts "The tournament has officially ended."
                        end
                    end
                end
            end
        when "All tournaments"
            tournament_list = Tournament.display_tournaments
            puts tournament_list
        when "Register for a tournament"
            selected_tournament_id = prompt.ask("Please enter the Id for the tournament you'd like to register for.")
            selected_tournament = Tournament.all.find(selected_tournament_id)
            puts "You've Selected | ID: #{selected_tournament.id} | Date: #{selected_tournament.date_and_time} | #{selected_tournament.tournament_name} | Buy in : #{selected_tournament.buy_in} | Re-entries: #{selected_tournament.max_reentries} | Percent Paid #{selected_tournament.percent_paid}"
            if prompt.yes?("Would you like to register for this tournament?")
                current_user.register(selected_tournament_id)
                puts "Congrats! You've been registered"
            end 
        when "My active tournaments"
            exit_page = false
            while exit_page == false
            user_tournament_list = [current_user.tournaments.where(is_active: true)]
            user_tournament_list << "Go Back"
            selected_tournament = prompt.select("Select a tournament for more information", user_tournament_list)
            if selected_tournament == "Go Back"
                exit_page = true
            else
                puts "You've selected:"
                puts "Tournament ID: #{selected_tournament.id}"
                puts "Tournament Name: #{selected_tournament.tournament_name}"
                puts "Tournament Date: #{selected_tournament.date_and_time}"
                answer = prompt.select("What would you like to do?", ["Withdraw from competition", "Go Back"])
                    if answer == "Withdraw from competition"
                    #Stuff to unregister here
                    end
                end
            end
        when "My tournament history"
            puts current_user.tournaments.where(is_active: false)
        when "View Account Balance"
            exit_page = false
            while exit_page == false
            current_amount = current_user.account_balance
            puts "You currently have $#{current_amount} in your account"
            account_transaction = prompt.select("What would you like to do?", ["Deposit", "Withdraw", "Back"])
                if account_transaction == "Deposit"
                    deposit_amount = prompt.ask("How much would you like to deposit?").to_i
                    current_user.deposit(deposit_amount)
                    puts "Thank you for depositing $#{deposit_amount} into your account. Your current balance is now $#{current_user.account_balance}."
                elsif account_transaction == "Withdraw"
                    withdraw_amount = prompt.ask("How much would you like to withdraw?").to_i
                    current_user.withdraw(withdraw_amount)
                else exit_page = true
                end
            end
        when "Logout"
            if prompt.yes?("Are you sure you would like to log out?")
                puts "You have been successfully signed out"
                logged_in = false
                current_user = nil
            end
    end

end

end




