
#1130 - too high
persons = []
preferences = {}
file = File.new("aoc13_input.txt", "r")
while (line = file.gets)
    line.gsub!(".", "")
    line = line.split(" ")
    p1 = line[0]
    p2 = line[10]
    state = line[2]
    points = line[3].to_i
    if state == "lose"
        points *= -1
    end
    pref = {p2 => points}

    if (!preferences[p1])
        preferences[p1] = pref
        persons << p1
        preferences[p1].merge!({"Luka" => 0})
        if !preferences["Luka"]
            persons << "Luka"
            preferences["Luka"] = {p1 => 0}
        else
            preferences["Luka"].merge!({p1 => 0})
        end
    else
        preferences[p1].merge! pref
    end
end

p preferences
# file.close

all_seatings = persons.permutation.to_a

max = 0
sp = 0
c = 0
all_seatings.each do |persons|
    curr = 0
    persons.each.with_index do |person, index|
        pb = index == 0 ? -1 : index - 1
        pa = index == persons.length-1 ? 0 : index+1
        curr += preferences[person][persons[pb]]
        curr += preferences[person][persons[pa]]
    end
    if curr > max
        max = curr
        sp = persons
    end
end
p preferences
p max
p sp