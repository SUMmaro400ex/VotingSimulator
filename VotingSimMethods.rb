#VotingSimMethods.rb
module VotingSimMethods
	#This method saved about 100 lines of code
	#This does all of the checking for proper user input
	def get_input(prompt,options)
		#loop until a valid response is entered
		valid_response = false
		until valid_response
			puts `clear`
			#Puts out the question
			puts prompt
			#gets the answer the user submitted and downcases it
			answer = gets.chomp.downcase
			#if the answer is one of the options in the options array then it is valid
			if options.include? answer
				valid_response = true
			else
				#if the answer is not in the options array, then tell the user to try again
				puts "I'm sorry, I didn't get that. Please press enter to try again."
				gets
			end
		end
		#returns the answer
		answer
	end

	def create(world)
		#Set up options array for user input
		options=["person","politician"]
		#set the answer returned from the get_input method to the choice variable
		choice = get_input("What would you like to create? Politician or Person",options)
		puts `clear`
		#Ask the user for the name of the person or politician
		puts "What is the #{choice}'s name?"
		#store the name entered
		name = gets.chomp.downcase.capitalize
		#checks if the user chose to create a person
		if choice == "person"
			#Set up options array for user input
			options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
			#set the answer returned from the get_input method to the view variable
			view = get_input("What is their political view? Liberal, Conservative, Tea Party, Socialist, or Neutral",options)
			#create the new person and add them to the world
			world.add_person(Person.new(name,view, nil, false))
		else
			#Set up options array for user input
			options = ["democrat", "republican"]
			#set the answer returned from the get_input method to the party variable
			party = get_input("Which party does the politician belong to? Democrat or Republican?",options)
			#create the new person and add them to the world
			world.add_person(Person.new(name,nil, party, true))
		end
	end

	#Changes the name of the voter or politician
	def change_name(updating)
		#ask for the new name
		puts `clear`
		puts "Please enter their new name."
		#update the name attribute for the person being updated
		updating.name = gets.chomp.downcase.capitalize
	end

	#This is called when the user chooses update on the main menu
	def update(world)
		puts `clear`
		#The user may want to see the list of everyone available to be updated, so we check for this.
		dont_list = false
		#Until the user no longer wants to see the list, loop through this prompt
		until dont_list
			#Ask the user for which person to update
			puts "Who would you like to update? To see a list of all available people, type list"
			#gets the user's inputs
			choice = gets.chomp.downcase.capitalize
			#if the user said list, then call the list method on the world object
			if choice == "List"
				world.list
				puts `clear`
			else
				#if the user doesnt want the list, then set dont_list to true to exit the loop
				dont_list = true
			end
		end

		#Need to test if the name the user entered is in the world object
		found = false
		updating = nil
		#Loop until the person is found
		until found
			#Searches through both the voters array and politicians array
			[world.voters, world.politicians].each do |group|
				#Searches through each person in the array
				group.each do |person|
					#if the name is found, then update found to true
					#Also set updating to the person object
					if person.name == choice
						updating = person
						found = true
					end
				end
			end	
			#If the person isn't found, tell the user the person wasnt found
			#Prompt the user to re-enter the name
			unless found 
				puts "I'm sorry, I can't find that person. Please enter a different name."
				choice = gets.chomp.downcase.capitalize
			end
		end

		#If the person is a politicia, then do the following
		if updating.politician
			#Sets up options array
			options = ["name","party","remove"]
			#Asks the user what they would like to change about the politician
			choice = get_input("What would you like to change? Name, party, remove.",options)
			#if the user wants to update the politicians party, then do the following
			if choice == "party"
				#Sets up options array
				options = ["democrat","republican"]
				#Update the politician's party with the new party
				updating.party = get_input("Please enter their new party. Democrat or Republican",options)
			end
		else #if the person is not a politician then do the following
			#Sets up options array
			options = ["name","political view","remove"]
			#Asks the user what they want to update about the voter
			choice = get_input("What would you like to change? Name, political view, remove.",options)
			#if they want to update the political view, then do the following
			if choice == "political view"
				#sets up options array
				options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
				#update the voters politicial view with the input from the user
				updating.view  = get_input("Please enter their new political view. Liberal, Conservative, Tea Party, Socialist, or Neutral.",options)
			end
		end
		#If the user chose to remove the voter/politician, then call the remove_person method of the world object
		world.remove_person(updating) if choice == "remove"
		#If the user chose to rename the voter/politician, then call the change_name
		change_name(updating) if choice == "name"
	end
end