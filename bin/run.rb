require_relative '../config/environment'

exit_app = false
prompt = TTY::Prompt.new(active_color: :cyan)
logged_in = false
current_user = nil

prompt.say("
/$$$$$$$$                                                                                       /$$
|__  $$__/                                                                                      | $$
   | $$     /$$$$$$  /$$   /$$  /$$$$$$  /$$$$$$$   /$$$$$$  /$$$$$$/$$$$   /$$$$$$  /$$$$$$$  /$$$$$$
   | $$    /$$__  $$| $$  | $$ /$$__  $$| $$__  $$ |____  $$| $$_  $$_  $$ /$$__  $$| $$__  $$|_  $$_/
   | $$   | $$  \\ $$| $$  | $$| $$  \\__/| $$  \\ $$  /$$$$$$$| $$ \\ $$ \\ $$| $$$$$$$$| $$  \\ $$  | $$
   | $$   | $$  | $$| $$  | $$| $$      | $$  | $$ /$$__  $$| $$ | $$ | $$| $$_____/| $$  | $$  | $$ /$$
   | $$   |  $$$$$$/|  $$$$$$/| $$      | $$  | $$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$| $$  | $$  |  $$$$/
   |__/    \\______/  \\______/ |__/      |__/  |__/ \\_______/|__/ |__/ |__/ \\_______/|__/  |__/   \\___/



 /$$$$$$$            /$$                                 /$$      /$$
| $$__  $$          | $$                                | $$$    /$$$
| $$  \\ $$  /$$$$$$ | $$   /$$  /$$$$$$   /$$$$$$       | $$$$  /$$$$  /$$$$$$  /$$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$
| $$$$$$$/ /$$__  $$| $$  /$$/ /$$__  $$ /$$__  $$      | $$ $$/$$ $$ |____  $$| $$__  $$ |____  $$ /$$__  $$ /$$__  $$ /$$__  $$
| $$____/ | $$  \\ $$| $$$$$$/ | $$$$$$$$| $$  \\__/      | $$  $$$| $$  /$$$$$$$| $$  \\ $$  /$$$$$$$| $$  \\ $$| $$$$$$$$| $$  \\__/
| $$      | $$  | $$| $$_  $$ | $$_____/| $$            | $$\\  $ | $$ /$$__  $$| $$  | $$ /$$__  $$| $$  | $$| $$_____/| $$
| $$      |  $$$$$$/| $$ \\  $$|  $$$$$$$| $$            | $$ \\/  | $$|  $$$$$$$| $$  | $$|  $$$$$$$|  $$$$$$$|  $$$$$$$| $$
|__/       \\______/ |__/  \\__/ \\_______/|__/            |__/     |__/ \\_______/|__/  |__/ \\_______/ \\____  $$ \\_______/|__/
                                                                                                    /$$  \\ $$
                                                                                                   |  $$$$$$/
                                                                                                    \\______/

", color: :cyan)

initial_buffer = prompt.keypress("Press any key to continue, resumes automatically in 3 seconds ...", timeout: 3)

while exit_app == false

    if logged_in == false


        welcome_screen = prompt.select('What would you like to do?', ['Login', 'Sign Up', "Exit"])

        if welcome_screen == "Sign Up"
            first_name = prompt.ask("First Name:", required: true) do |q|
                q.messages[:required?] = "You must enter in a first name"
            end
            last_name = prompt.ask("Last Name:", required: true) do |q|
                q.messages[:required?] = "You must enter in a last name"
            end
            password = prompt.mask("Create a Password:", required: true) do |q|
                q.messages[:required?] = "You must enter in a password"
            end

            existing_user = User.all.find{|user| user.first_name == first_name && user.last_name == last_name}

            if existing_user == nil
                role = prompt.select("Role:", ["Manager", "Dealer", "Player"])
                role_class = Role.all.find_by(name: role)

                initial_balance = prompt.ask("How much would you like to transfer as an initial amount to your account?", convert: :int) do |q|
                    q.convert(:int, "Sorry, but you can only deposit full dollar amounts")
                end

                current_user = User.create(first_name: first_name, last_name: last_name, password: password, role_id: role_class.id, account_balance: initial_balance) #&& user.password == password
                prompt.ok("Welcome to Virtual Poker, #{current_user.first_name}")
                logged_in = true
            else
                prompt.error("A user with that name already exists")
            end

        elsif welcome_screen == "Login"
            first_name = prompt.ask("Enter your First Name:", required: true, ) do |q|
                q.messages[:required?] = "You must enter in a first name"
            end
            last_name = prompt.ask("Enter your Last Name:", required: true) do |q|
                q.messages[:required?] = "You must enter in a last name"
            end
            password = prompt.mask("Enter your Password:", required: true) do |q|
                q.messages[:required?] = "You must enter in your password"
            end

            # role = prompt.select("What is your role?", ["Player", "Dealer", "Manager"])
            current_user = User.all.find{|user| user.first_name == first_name && user.last_name == last_name && user.password == password}
            # binding.pry
            if current_user
                prompt.ok("Welcome back, #{current_user.first_name}")
                logged_in = true
            else
                prompt.error("Incorrect log-in credentials. Please try again")
            end
        elsif welcome_screen == "Exit"
            prompt.ok("We hope you enjoyed the app!")
            exit_app = true
            # exit
        end

    elsif logged_in == true
        case current_user.role.name
        when "Manager"
            home_options = ["Create a tournament", "Manage tournaments", "All tournaments", "Register for a tournament", "My active tournaments", "My tournament history", "View Account Balance", "Logout"]
        when "Dealer"
            home_options = ["Create a tournament", "Manage tournaments", "All tournaments", "Register for a tournament", "My active tournaments", "My tournament history", "View Account Balance", "Logout"]
        when "Player"
            home_options = ["All tournaments", "Register for a tournament", "My active tournaments", "My tournament history", "View Account Balance", "Logout"]
        when "Banned"
            prompt.error("You have been banned from our application.")
        end

        home_screen = prompt.select("Please select from the following options", home_options)

        case home_screen
        when "Create a tournament"
            tournament_name = prompt.ask("Tournament name?", required: true) do |q|
                q.messages[:required?] = "You must enter in a tournament name"
            end
            tournament_datetime = prompt.ask("Date and time?", required: true) do |q|
                q.messages[:required?] = "You must enter in a date and time"
                # q.validate(\d{4}-\d{2}-\d{2})
                # q.messages[:valid?] = "Wrong date format"
            end
            tournament_buy_in = prompt.ask("What's the buy-in for players?", required: true) do |q|
                q.messages[:required?] = "You must enter in a buy-in"
            end
            tournament_reentries = prompt.ask("How many reentries are players allowed?", required: true) do |q|
                q.messages[:required?] = "You must enter in a max number of reentries"
            end
            tournament_percent_paid = prompt.slider("What's the percent paid out at the end of the tournament?", min: 0, max: 100, step: 0.5, echo: false)

            # tournament_percent_paid = prompt.ask("What's the percent paid out at the end of the tournament?", required: true) do |q|
            #     q.messages[:required?] = "You must enter in a pay out"
            # end
            tournament_extra_prize = prompt.ask("What's the extra prizepool?", required: true) do |q|
                q.messages[:required?] = "Enter 0 if you wish to have no prize pool"
            end

            # Use Tournament.display_types to display tournament types with IDs
            # Here's how to create a tournament type
            new_tournament_type = TournamentType.create(name: tournament_name, buy_in: tournament_buy_in, max_reentries: tournament_reentries, percent_paid: tournament_percent_paid)

            # Here's how to create a tournament
            Tournament.create(date_and_time: tournament_datetime, type_id: new_tournament_type.id)

            prompt.ok("New tournament created! Check out your new tournament along all other active tournaments in the All Tournaments section.")
        when "Manage tournaments"
            exit_page = false
            while exit_page == false
                active_tournament_list = [Tournament.all.where(is_active: true)]
                active_tournament_list << "Go Back"
                selected_tournament = prompt.select("Select a tournament you'd like to manage", active_tournament_list, cycle: true)
                if selected_tournament == "Go Back"
                    exit_page = true
                else
                    prompt.say("You've selected:", color: :blue)
                    prompt.say("Tournament ID: #{selected_tournament.id}", color: :blue)
                    prompt.say("Tournament Name: #{selected_tournament.tournament_name}", color: :blue)
                    prompt.say("Tournament Date: #{selected_tournament.date_and_time}", color: :blue)
                    prompt.say("Total Players: #{selected_tournament.total_players}", color: :blue)
                    prompt.say("Remaining Players: #{selected_tournament.remaining_players}", color: :blue)
                    prompt.say("Total Prize Pool: #{selected_tournament.total_prizepool}", color: :blue)
                    answer = prompt.select("What would you like to do?", ["Manage players", "Close to new registrants", "End tournament", "Go Back"])

                    case answer
                    when "Close to new registrants"
                        if prompt.yes?("Are you sure you would like to close the tournament to new registrants??")
                            selected_tournament.close_registration
                            # prompt.ok("Registration has been closed for this tournament")
                        end
                    when "Manage players"
                        exit_players = false
                        while exit_players == false
                            tournament_registrants = [selected_tournament.players]
                            tournament_registrants << "Go Back"
                            selected_player = prompt.select("Select a player in this tournament", tournament_registrants, cycle: true)
                            if selected_player == "Go Back"
                                exit_players = true
                            else
                                exit_player = false
                                while exit_player == false
                                    prompt.say("You've selected:", color: :blue)
                                    prompt.say("Player ID: #{selected_player.id}", color: :blue)
                                    prompt.say("Player Name: #{selected_player.full_name}", color: :blue)
                                    current_ticket = selected_player.current_ticket(selected_tournament.id)
                                    player_action = prompt.select("What would you like to do?", ["Knock out player", "Penalize player", "Disqualify player", "Award Prize", "Go Back"])
                                    if player_action == "Knock out player"
                                        if prompt.yes?("Would you like to remove #{selected_player.first_name} from the tournament?")
                                            selected_tournament.knockout_player(selected_player.id)
                                            prompt.ok("#{selected_player.first_name} is no longer in the tournament.")
                                        end
                                    elsif player_action == "Penalize player"
                                    elsif player_action == "Award Prize"
                                        if prompt.yes?("Would you like to award the tournament prize to #{selected_player.first_name}?")
                                            selected_tournament.award_prize(selected_player.id, current_ticket)
                                            prompt.ok("#{selected_player.first_name} is the official winner of the tournament!")
                                        end
                                    elsif player_action == "Disqualify player"
                                        if prompt.yes?("Are you sure you want to disqualify #{selected_player.first_name}?")
                                            selected_tournament.disqualify(selected_player.id, current_ticket)
                                            prompt.ok("#{selected_player.first_name} has been disqualified from the tournament.")
                                        end
                                    elsif player_action == "Go Back"
                                        exit_player = true
                                    end
                                end
                            end
                        end
                    when "End tournament"
                        if prompt.yes?("Are you sure you would like to end the tournament??")
                            selected_tournament.is_active = false
                            prompt.ok("The tournament has officially ended.")
                        end
                    end
                end
            end
        when "All tournaments"
            tournament_list = Tournament.display_tournaments
            prompt.say(tournament_list, color: :blue)
        when "Register for a tournament"
            exit_page = false
            while exit_page == false
                registerable_tournaments = Tournament.all.filter { |tournament| tournament.is_reg_open == true}
                registerable_tournaments << "Go Back"
                selected_tournament = prompt.select("Please select a tournament for more details", registerable_tournaments, cycle: true)

                if selected_tournament == "Go Back"
                    exit_page = true
                elsif selected_tournament
                    prompt.say("You've Selected | ID: #{selected_tournament.id} | Date: #{selected_tournament.date_and_time} | #{selected_tournament.tournament_name} | Buy in : #{selected_tournament.buy_in} | Re-entries: #{selected_tournament.max_reentries} | Percent Paid #{selected_tournament.percent_paid}", color: :blue)

                    ticket = current_user.current_ticket(selected_tournament.id)
                    if ticket == nil
                        if prompt.yes?("Would you like to register for this tournament?")
                            current_user.register(selected_tournament.id)
                        end
                    elsif ticket.is_active == true
                        prompt.warn("You are already registered for this tournament")
                    elsif ticket.is_active == false
                        if prompt.yes?("Would you like to reenter this tournament?")
                            current_user.reenter(selected_tournament.id)
                        end
                    end

                    # if ticket.is_active == true
                    #     prompt.ok("You are already registered for this tournament")
                    # elsif ticket.is_active == false
                    #     if prompt.yes?("Would you like to reenter this tournament?")
                    #         current_user.reenter(selected_tournament.id)
                    #     end
                    # else
                    #     if prompt.yes?("Would you like to register for this tournament?")
                    #         current_user.register(selected_tournament_id)
                    #     end
                    # end
                end
            end
        when "My active tournaments"
            exit_page = false
            while exit_page == false
                user_ticket_list = current_user.view_active_tournaments
                user_ticket_list << "Go Back"
                selected_ticket = prompt.select("Select a tournament for more information", user_ticket_list, cycle: true)
                if selected_ticket == "Go Back"
                    exit_page = true
                else
                    # selected_tournament = Tournament.all.find(selected_ticket.tournament_id)
                    prompt.say("You've selected:", color: :blue)
                    prompt.say("Tournament ID: #{selected_ticket.tournament_id}", color: :blue)
                    prompt.say("Tournament Name: #{selected_ticket.tournament.tournament_name}", color: :blue)
                    prompt.say("Tournament Date: #{selected_ticket.tournament.date_and_time}", color: :blue)
                    answer = prompt.select("What would you like to do?", ["Withdraw from competition", "Go Back"])
                    #Cancel Registration not working right now
                    if answer == "Withdraw from competition"
                        current_user.cancel_registration(selected_ticket.tournament.id)
                        prompt.ok("You have successfully been withdrawn from this tournament")
                    end
                end
            end
        when "My tournament history"
            # view_past_tournaments not working for now
            past_tournaments_list = current_user.view_past_tournaments
            # past_tournaments_list = Ticket.all.filter { |ticket| ticket.is_active == false && ticket.player_id == current_user.id }
            if past_tournaments_list == []
                prompt.warn("You do not have any past tournaments to view")
            else prompt.ok(past_tournaments_list)
            end
        when "View Account Balance"
            exit_page = false
            while exit_page == false
                current_amount = current_user.balance
                prompt.say("You currently have $#{current_amount} in your account", color: :blue)
                account_transaction = prompt.select("What would you like to do?", ["Deposit", "Withdraw", "Back"])
                if account_transaction == "Deposit"
                    deposit_amount = prompt.ask("How much would you like to deposit?", convert: :int) do |q|
                        q.convert(:int, "Sorry, but you can only deposit full dollar amounts")
                    end
                    current_user.deposit(deposit_amount)
                    prompt.ok("Thank you for depositing $#{deposit_amount} into your account. Your current balance is now $#{current_user.account_balance}.")
                elsif account_transaction == "Withdraw"
                    withdraw_amount = prompt.ask("How much would you like to withdraw?", convert: :int) do |q|
                        q.convert(:int, "Sorry, but you can only withdraw full dollar amounts")
                    end
                    current_user.withdraw(withdraw_amount)
                    prompt.ok("Thank you for withdrawing $#{withdraw_amount} into your account. Your current balance is now $#{current_user.account_balance}.") if withdraw_amount <= current_user.account_balance
                else exit_page = true
                end
            end
        when "Logout"
            if prompt.yes?("Are you sure you would like to log out?")
                prompt.ok("You have been successfully signed out")
                logged_in = false
                current_user = nil
            end
        end

    end

end

prompt.say("
  /$$$$$$                            /$$ /$$                           /$$
 /$$__  $$                          | $$| $$                          | $$
| $$  \\__/  /$$$$$$   /$$$$$$   /$$$$$$$| $$$$$$$  /$$   /$$  /$$$$$$ | $$
| $$ /$$$$ /$$__  $$ /$$__  $$ /$$__  $$| $$__  $$| $$  | $$ /$$__  $$| $$
| $$|_  $$| $$  \\ $$| $$  \\ $$| $$  | $$| $$  \\ $$| $$  | $$| $$$$$$$$|__/
| $$  \\ $$| $$  | $$| $$  | $$| $$  | $$| $$  | $$| $$  | $$| $$_____/
|  $$$$$$/|  $$$$$$/|  $$$$$$/|  $$$$$$$| $$$$$$$/|  $$$$$$$|  $$$$$$$ /$$
 \\______/  \\______/  \\______/  \\_______/|_______/  \\____  $$ \\_______/|__/
                                                   /$$  | $$
                                                  |  $$$$$$/
                                                   \\______/

", color: :cyan)

