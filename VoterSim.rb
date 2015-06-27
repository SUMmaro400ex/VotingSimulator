#VoterSim.rb

class World
	attr_accessor :voters, :politicians
	
	def initialize
		@voters = []
		@politicians = []
	end

	def add_person(person)
		if person.politician
			@politicians << person
		else
			@voters << person
		end
	end

	def remove_person(person)
		if person.politician
			@politicians.delete(person)
		else
			@voters.delete(person)
		end
	end

	def list
		@voters.each do |voter|
			puts "Voters: #{voter.name}, #{voter.view}" 
		end
		@politicians.each do |politician|
			puts "Politicians: #{politician.name}, #{politician.party}"
		end
		puts "Press enter to continue."
		gets
	end

	def vote
		@voters.each do |voter|
			puts "#{voter.name} listened to #{@politicians.sample.name}'s speach."
			vote_num = Random.new.rand(100) + 1
			views = {"liberal" => 75, "socialist" => 90, "nuetral" => 50, "conservative" => 25, "tea party" =>10}
			vote_num > views[voter.view] ? voter.vote = "republican" : voter.vote = "democrat"

			if (voter.view == "liberal" || voter.view == "socialist") && voter.vote == "republican"
				puts "#{voter.name} changed their mind."
			elsif (voter.view == "conservative" || voter.view == "tea party") && voter.vote == "democrat"
				puts "#{voter.name} changed their mind."
			end

			puts "#{voter.name} will be voting for the #{voter.vote}."
		end
		
		@politicians.each do |politician|
			speaker = politicians.sample
			while speaker == politician
				speaker = politicians.sample
			end
			puts "#{politician.name} listened to #{speaker.name}'s speach.\n#{politician.name} says that #{speaker.name} is unfit for office."
			politician.vote = politician.party
		end	

		republican_votes = democrat_votes = 0

		@politicians.each do |politician|
			if politician.vote == "republican"
				republican_votes +=1
			else
				democrat_votes +=1
			end
		end

		@voters.each do |voter|
			if voter.vote == "republican"
				republican_votes +=1
			else
				democrat_votes +=1
			end
		end
		
		republican_primary_winner = politicians.sample
		while republican_primary_winner.party != "republican"
			republican_primary_winner = politicians.sample
		end

		democrat_primary_winner = politicians.sample
		while democrat_primary_winner.party != "democrat"
			democrat_primary_winner = politicians.sample
		end

		if democrat_votes > republican_votes
			puts "#{democrat_primary_winner.name} the Democrat wins!"
		else
			puts "#{republican_primary_winner.name} the republican wins."
		end
	end

end


class Person
	attr_accessor :name, :view, :party, :politician, :vote
	
	def initialize(name, view, party, politician)
		@name = name 
		@view = view
		@party = party
		@politician = politician
	end

end

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
	voting_pool = [world.voters, world.politicians]
	until found
		voting_pool.each do |group|
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
		case choice
		when "remove"
			world.remove_person(updating)
		when "name"
			puts `clear`
			puts "Please enter their new name."
			choice = gets.chomp.downcase.capitalize
			updating.name = choice
		else
			options = ["democrat","republican"]
			choice = get_input("Please enter their new party. Democrat or Republican",options)
			updating.party = choice
		end

	else
		options = ["name","political view","remove"]
		choice = get_input("What would you like to change? Name, political view, remove.",options)
		case choice
		when "remove"
			world.remove_person(updating)
		when "name"
			puts `clear`
			puts "Please enter their new name."
			choice = gets.chomp.downcase.capitalize
			updating.name = choice
		else
			options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
			choice = get_input("Please enter their new political view. Liberal, Conservative, Tea Party, Socialist, or Neutral.",options)
			updating.view = choice
		end
	end
end

time_to_vote=false
world = World.new

def test_people(world)
	world.add_person(Person.new("Jon","liberal",nil,false))
	world.add_person(Person.new("Bill",nil,"democrat",true))
	world.add_person(Person.new("George",nil,"republican",true))

end

test_people(world)

until time_to_vote
	options=["create","list", "update", "vote"]
	choice = get_input("What would you like to do? Create, List, Update, or Vote", options)
	case choice
	when "create"
		create(world)
	when "list"
		world.list
	when "update"
		if world.voters.empty? && world.politicians.empty?
			puts "Sorry, there is no one available to update.
				\rPlease press enter to continue"
			gets
		else
			update(world)
		end
	when "vote"
		republican = democrat = false
		world.politicians.each do |politician|
			if politician.party == "republican"
				republican = true
			else
				democrat = true
			end
		end
		if republican && democrat
			world.vote
			time_to_vote = true
		else
			puts `clear` 
			puts "You must have atleast one republican and one democrat to run the simulation.
				\rPress enter to continue."
			gets
		end
	end
end


