places = {};
distances = {};
ps = []
file = File.new("aoc9_input.txt", "r")
while (line = file.gets)
    input = line.split(" ")
    if !places[input[0]]
        places[input[0]] = ({input[2] => input[4]})
        ps << input[0]
    else
        places[input[0]].merge!({input[2] => input[4]})
    end
    if !places[input[2]]
        places[input[2]] = ({input[0] => input[4]})
        ps << input[2]
    else
        places[input[2]].merge!({input[0] => input[4]})
    end
end
file.close

# visited = []
# distance = 0
# ps.each do |p|
#     visited << p
#     neighbours = places[p]
#     while visited.length != ps.length
#         neighbours.each do |n|

#         end
#     end
# end


# 1.upto 6 do |n|
#     visited = []
#     start = n
#     distance = 0
#     current = ps[start]
#     visited << ps[start]
#     while visited.length != ps.length
#         print current + " -> "
#         neighbours = places[current]
#         shortest = 100000000000
#         shortest_key = 0
#         neighbours.each do |key, val |
#             if val.to_i < shortest && !visited.include?(key)
#                 shortest = val.to_i
#                 shortest_key = key
#             end
#         end
#         distance += shortest
#         current = shortest_key
#         visited << shortest_key
#     end
#     p ""
#     p distance
#     p "------------"
# end

permutations =  ps.permutation.to_a

smallest = 100000000
distances = []
c = 0
permutations.each do |p|
    s = 0
    for i in 0..p.length-2
        dist = places[p[i]][p[i+1]].to_i
        s += dist
    end
    distances << s
    s = 0
    c += 1
    # if c == 10000000
    #     break
    # end
end

p distances.max


# 0.upto 6 do |n|
# tried = {}
# tried[ps[0]] = []
# while tried[ps[0]].length != ps.length
#     visited = []
#     start = 0
#     distance = 0
#     current = ps[start]
#     visited << ps[start]
#     while visited.length != ps.length
#         p current
#         neighbours = places[current]
#         shortest = 100000000000
#         shortest_key = 0
#         neighbours.each do |key, val |
#             if !visited.include?(key) && !tried[current].include?(key)
#                 shortest = val.to_i
#                 shortest_key = key
#                 tried[current] << key
#             end
#         end
#         distance += shortest
#         current = shortest_key
#         visited << shortest_key
#         tried[current] = []
#     end
#     p ""
#     p distance
#     p "------------"
# end
# end

