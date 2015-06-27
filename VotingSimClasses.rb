# VotingSimClasses.rb
class World
	attr_accessor :voters, :politicians
	
	def initialize
		@voters = []
		@politicians = []
	end

	def add_person(person)
		person.politician ? @politicians << person : @voters << person
	end

	def remove_person(person)
		person.politician ? @politicians.delete(person) : @voters.delete(person)
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
			views = {"liberal" => 75, "socialist" => 90, "nuetral" => 50, "conservative" => 25, "tea party" =>10}
			(Random.new.rand(100) + 1) > views[voter.view] ? voter.vote = "republican" : voter.vote = "democrat"
			
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
		[@voters, @politicians].each do |group|
			group.each do |voter|
				voter.vote == "republican" ? republican_votes +=1 : democrat_votes +=1
			end
		end
		
		republican_winner = democrat_winner = nil
		while republican_winner.nil? || democrat_winner.nil?
			primaries = politicians.sample
			primaries.party == "republican" ? republican_winner = primaries : democrat_winner = primaries
		end

		if democrat_votes > republican_votes
			puts "#{democrat_winner.name} the Democrat wins!"
		else
			puts "#{republican_winner.name} the republican wins."
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