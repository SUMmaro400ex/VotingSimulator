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
			changed = false
			random_num = Random.new
			vote_num = random_num.rand(100) + 1
			puts "#{voter.name} listened to #{@politicians.sample.name}'s speach."
			case voter.view
			when "liberal"
				if vote_num > 75
					voter.vote = "Republican"
					changed = true
				else
					voter.vote = "Democrat"
				end
			when "conservative"
				if vote_num > 75
					voter.vote = "Democrat"
					changed = true
				else
					voter.vote = "Republican"
				end
			when "tea party"
				if vote_num > 90
					voter.vote = "Democrat"
					changed = true
				else
					voter.vote = "Republican"
				end
			when "socialist"
				if vote_num > 90
					voter.vote = "Republican"
					changed = true
				else
					voter.vote = "Democrat"
				end		
			else
				if vote_num > 50
					voter.vote = "Republican"
					changed = true
				else
					voter.vote = "Democrat"
				end	
			end
			if changed
				puts "#{voter.name} changed their mind."
			end
			puts "#{voter.name} will be voting for the #{voter.vote}."
		end
		
		@politicians.each do |politician|
			speaker = politicians.sample
			while speaker == politician
				speaker = politicians.sample
			end
			puts "#{politician.name} listened to #{speaker.name}'s speach.
			\r#{politician.name} says that #{speaker.name} is unfit for office."
			politician.vote = politician.party
		end	

		democrat_votes = 0
		republican_votes = 0

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


def unknown_response
	puts "I'm sorry. I didn't get that. Press enter to try again"
	gets
end

def create(world)
	puts `clear`
	valid_response = false
	until valid_response
		puts "What would you like to create? Politician or Person"
		choice = gets.chomp.downcase
		case choice
		when "person"
			puts `clear`
			puts "What is the person's name?"
			name = gets.chomp.downcase.capitalize
			valid_response = false
			options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
			until valid_response
				puts `clear`
				puts "What is their political view? Liberal, Conservative, Tea Party, Socialist, or Neutral"
				view = gets.chomp.downcase
				if !options.include? view
					unknown_response
				else
					valid_response = true
				end
			end
			person = Person.new(name,view, nil, false)
			world.add_person(person)
		when "politician"
			puts `clear`
			puts "What is the politician's name?"
			name = gets.chomp.downcase.capitalize
			valid_response = false
			options = ["democrat", "republican"]
			until valid_response
				puts `clear`
				puts "Which party does the politician belong to? Democrat or Republican"
				party = gets.chomp.downcase
				if !options.include? party
					unknown_response
				else
					valid_response = true
				end
			end
			person = Person.new(name,nil, party, true)
			world.add_person(person)
		else
			unknown_response
			puts `clear`
		end
	end
end

def update(world)
	puts `clear`
	check = false

	until check
		puts "Who would you like to update? To see a list of all available people, type list"
		choice = gets.chomp.downcase.capitalize

		if choice == "List"
			world.list
			puts `clear`
		else
			check = true
		end
	end

	found = false
	updating = nil
	
	until found
		world.voters.each do |person|
			if person.name == choice
				updating = person
				found = true
			end
		end
		world.politicians.each do |person|
			if person.name == choice
				updating = person
				found = true
			end
		end	
		
		unless found 
			puts "I'm sorry, I can't find that person. Please enter a different name."
			choice = gets.chomp.downcase.capitalize
		end
	end

	if updating.politician
		puts `clear`
		valid_response = false
		until valid_response
			puts `clear`
			puts "Would you like to change their name or their party?"
			choice = gets.chomp.downcase
			case choice
			when "name"
				puts `clear`
				puts "Please enter their new name."
				choice = gets.chomp.downcase.capitalize
				updating.name = choice
				valid_response = true
			when "party"
				until valid_response
					puts `clear`
					puts "Please enter their new party. Democrat or Republican."
					options = ["democrat", "republican"]
					choice = gets.chomp.downcase
					if options.include? choice
						updating.party = choice
						valid_response = true
					else
						unknown_response
					end
				end
			else
				unknown_response
			end
		end

	else
		puts `clear`
		valid_response = false
		until valid_response
			puts `clear`
			puts "Would you like to change their name or their political view?"
			choice = gets.chomp.downcase
			case choice
			when "name"
				puts `clear`
				puts "Please enter their new name."
				choice = gets.chomp.downcase.capitalize
				updating.name = choice
				valid_response = true
			when "political view"
				until valid_response
					puts `clear`
					puts "Please enter their new political view. Liberal, Conservative, Tea Party, Socialist, or Neutral."
					options = ["liberal", "conservative", "tea party", "socialist", "neutral"]
					choice = gets.chomp.downcase
					if options.include? choice
						updating.view = choice
						valid_response = true
					else
						unknown_response
						valid_response = false
					end
				end
			else
				unknown_response
			end
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
	puts `clear`
	puts "What would you like to do? Create, List, Update, or Vote"
	choice = gets.chomp.downcase

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
	else
		unknown_response
	end

end

# def test(people)
# 	p people
# end
# test (people)


