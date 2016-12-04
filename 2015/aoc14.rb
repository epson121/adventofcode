#Vixen can fly 19 km/s for 7 seconds, but then must rest for 124 seconds.


race = {}
stats = {}
file = File.new("aoc14_input.txt", "r")
while (line = file.gets)
    data = line.split(" ")
    name = data[0]
    speed = data[3].to_i
    stamina = data[6].to_i
    rest = data[13].to_i
    stats[name] = {"speed" => speed, "stamina"=> stamina, "rest"=> rest, "total" => stamina+rest}
    race[name] = {"real" => 0, "fake" => 0}
end
file.close
leaders = []
current_leader_points = 0
1.upto 2503 do |second|
    race.each do |reindeer, v|
        if (second % stats[reindeer]["total"] <= stats[reindeer]["stamina"] && second % stats[reindeer]["total"] > 0)
            race[reindeer]["fake"] += stats[reindeer]["speed"]
            if (race[reindeer]["fake"] > current_leader_points)
                current_leader_points = race[reindeer]["fake"]
                leaders = [reindeer]
            elsif race[reindeer]["fake"] == current_leader_points
                leaders << reindeer
            end
            p reindeer + " flying (fake - " + race[reindeer]["fake"].to_s + ")"
        else
            p reindeer + " resting"
        end
    end
    leaders.each do |leader|
        race[leader]["real"] += 1
    end
end

p race