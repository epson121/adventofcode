goal = "ORnPBPMgArCaCaCaSiThCaCaSiThCaCaPBSiRnFArRnFArCaCaSiThCaCaSiThCaCaCaCaCaCaSiRnFYFArSiRnMgArCaSiRnPTiTiBFYPBFArSiRnCaSiRnTiRnFArSiAlArPTiBPTiRnCaSiAlArCaPTiTiBPMgYFArPTiRnFArSiRnCaCaFArRnCaFArCaSiRnSiRnMgArFYCaSiRnMgArCaCaSiThPRnFArPBCaSiRnMgArCaCaSiThCaSiRnTiMgArFArSiThSiThCaCaSiRnMgArCaCaSiRnFArTiBPTiRnCaSiAlArCaPTiRnFArPBPBCaCaSiThCaPBSiThPRnFArSiThCaSiThCaSiThCaPTiBSiRnFYFArCaCaPRnFArPBCaCaPBSiRnTiRnFArCaPRnFArSiRnCaCaCaSiThCaRnCaFArYCaSiRnFArBCaCaCaSiThFArPBFArCaSiRnFArRnCaCaCaFArSiRnFArTiRnPMgArF"

# goal = "HOHOHO"

# file = File.new("aoc19_input.txt", "r")
file = File.new("aoc19_input_small.txt", "r")

replacements = {}
while (line = file.gets)
    data = line.split(" ")
    if replacements[data[0]]
        replacements[data[0]] << data[2]
    else
        replacements[data[0]] = [data[2]]
    end
end
file.close

res = []
replacements.each do |k, v|
    a = (0 ... goal.length).find_all { |i| goal[i,k.length] == k }
    a.each do |occ|
        v.each do |val|
            g = goal.clone
            g[occ...occ+k.length] = val
            if !res.include? g
                res << g
            end
        end
    end
end

# p res
# p res.length


input = open("aoc19_input.txt").readlines.map!(&:split)

replacements = Hash.new(Array.new)
mirrorreplacements = Hash.new(Array.new)

compound = goal
input = input[0..-3]

input.each do |line|
    replacements[line[0]] = (replacements[line[0]] + [line[2]]) 
    mirrorreplacements[line[2]] = (mirrorreplacements[line[2]] + [line[0]]) 
end

compounds = []

replacements.each do |key, value|
    count = compound.scan(key).length
    pieces = compound.split(key)

    value.each do |replacement|
        fillers = Array.new(count){key}
        count.times do |index|
            subs = fillers.dup
            subs[index] = replacement
            compounds << pieces.zip(subs).flatten.join 
        end
    end
end

puts "Part 1:"
puts compounds.uniq.length

subcount = 0
while compound.length > 1
    max, bestcount, bestkey, bestreplacement = 0, 0, "", ""

    mirrorreplacements.keys.each do |key|
        count = compound.scan(key).length
        difference = (count * key.length) - (count * mirrorreplacements[key].length)
        if (count != 0) and ((difference/count) > max)
            max, bestcount, bestkey = difference, count, key
            bestreplacement = mirrorreplacements[key][0]
        end
    end

    subcount += bestcount
    compound = compound.gsub(bestkey, bestreplacement)
end

puts "Part 2"
puts subcount