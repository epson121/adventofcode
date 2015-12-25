# p1
# clear the file
# sed 's/\\\\/_/g' aoc8_input.txt > atrimmed
# sed 's/\\x../_/g' atrimmed > atrimmed2
# sed 's/\\"/_/g' atrimmed2 > atrimmed3
# simply count

#orig code chars: 6488
#
# p2
# sed 's/\\/\\\\/g' aoc8_input.txt > aencoded
# sed 's/"/\\"/g' aencoded > aencoded2
# and count again
#

# file = File.new("aoc8_input.txt", "r")
file = File.new("aencoded2", "r")

in_code = 0
real = 0
while (line = file.gets)
    p line.gsub("\n", "").length+2
    in_code += line.gsub("\n", "").length+2
end
file.close

# file = File.new("atrimmed3", "r")
# # file = File.new("aoc6_input.txt", "r")

# while (line = file.gets)
#     # without newline char
#     # without 2 quotes and newline
#     p line.gsub("\n", "")
#     p line.gsub("\n", "").length
#     real += line.gsub("\n", "").length
# end
# file.close

p in_code
p real


# 2245
# 1645
# 2118 - too high
# 2117 solution