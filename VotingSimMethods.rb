#VotingSimMethods.rb
module VotingSimMethods
	def get_input(prompt,options)
		valid_response = false
		until valid_response
			puts `clear`
			puts prompt
			answer = gets.chomp.downcase
			if options.include? answer
				valid_response = true
			else
				puts "I'm sorry, I didn't get that. Please press enter to try again."
				gets
			end
		end
		answer
	end

	def create(world)
		options=["person","politician"]
		choice = get_input("What would you like to create? Politician or Person",options)
		puts `clear`
		puts "What is the #{choice}'s name?"
		name = gets.chomp.downcase.capitalize
		if choice == "person"
			options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
			view = get_input("What is their political view? Liberal, Conservative, Tea Party, Socialist, or Neutral",options)
			world.add_person(Person.new(name,view, nil, false))
		else
			options = ["democrat", "republican"]
			party = get_input("Which party does the politician belong to? Democrat or Republican?",options)
			world.add_person(Person.new(name,nil, party, true))
		end
	end
	def change_name(updating)
		puts `clear`
		puts "Please enter their new name."
		choice = gets.chomp.downcase.capitalize
		updating.name = choice
	end
	def update(world)
		puts `clear`
		dont_list = false

		until dont_list
			puts "Who would you like to update? To see a list of all available people, type list"
			choice = gets.chomp.downcase.capitalize
			if choice == "List"
				world.list
				puts `clear`
			else
				dont_list = true
			end
		end

		found = false
		updating = nil
		until found
			[world.voters, world.politicians].each do |group|
				group.each do |person|
					if person.name == choice
						updating = person
						found = true
					end
				end
			end	

			unless found 
				puts "I'm sorry, I can't find that person. Please enter a different name."
				choice = gets.chomp.downcase.capitalize
			end
		end

		if updating.politician
			options = ["name","party","remove"]
			choice = get_input("What would you like to change? Name, party, remove.",options)
			if choice == "party"
				options = ["democrat","republican"]
				choice = get_input("Please enter their new party. Democrat or Republican",options)
				updating.party = choice
			end
		else
			options = ["name","political view","remove"]
			choice = get_input("What would you like to change? Name, political view, remove.",options)
			if choice == "political view"
				options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
				choice = get_input("Please enter their new political view. Liberal, Conservative, Tea Party, Socialist, or Neutral.",options)
				updating.view = choice
			end
		end

		world.remove_person(updating) if choice == "remove"
		change_name(updating) if choice == "name"
	end
end