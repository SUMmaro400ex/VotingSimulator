#VoterSim.rb
require "./VotingSimMethods.rb"
require "./VotingSimClasses.rb"
include VotingSimMethods

time_to_vote=false
world = World.new
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
			puts "Sorry, there is no one available to update.\nPlease press enter to continue"
			gets
		else
			update(world)
		end
	when "vote"
		republican = democrat = false
		world.politicians.each do |politician|
			politician.party == "republican" ? republican = true : democrat = true
		end
		if republican && democrat
			world.vote
			time_to_vote = true
		else
			puts `clear` 
			puts "You must have atleast one republican and one democrat to run the simulation.\nPress enter to continue."
			gets
		end
	end
end


