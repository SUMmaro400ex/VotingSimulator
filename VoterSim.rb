#VoterSim.rb

class Person
	attr_accessor :name, :view, :party
	
	def initialize(name, view, party, politician)
		@name = name 
		@view = view
		@party = party
		@politician = politician
	end

end

# class Politcian < Person


# end

def unknown_response
	puts "I'm sorry. I didn't get that. Press enter to try again"
	gets
end

def create
	puts `clear`
	valid_response = false
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
		Person.new(name,view, nil, false)
	when "politician"

	else
		create
	end
	
end


def list

end

def update

end

def vote

end


time_to_vote=false
people = []

until time_to_vote
	puts `clear`
	puts "What would you like to do? Create, List, Update, or Vote"
	choice = gets.chomp.downcase

	case choice
	when "create"
		people << create
	when "list"
		list
	when "update"
		update
	when "vote"
		vote
		time_to_vote = true
	else
		unknown_response
	end

end

def test(people)
	p people
end
test (people)


