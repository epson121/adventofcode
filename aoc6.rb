

def stringify pos
    return pos[0].to_s + "x" + pos[1].to_s
end



def do_to_lights1 stuff, lights, res
    lights = lights.map.with_index { |e, i| i > 0 ? e.to_i : e}
    for i in lights[1]..lights[3]
        for j in lights[2]..lights[4]
            spos = stringify([i, j])
            if stuff == 2
                if res[spos]
                    if res[spos] == 0
                        res[spos] = 1
                    else
                        res[spos] = 0
                    end
                else
                    res[spos] = 1
                end
            else
                res[spos] = stuff
            end
        end
    end
    res
end

def do_to_lights2 stuff, lights, res
    lights = lights.map.with_index { |e, i| i > 0 ? e.to_i : e}
    for i in lights[1]..lights[3]
        for j in lights[2]..lights[4]
            spos = stringify([i, j])
            if !res[spos]
                res[spos] = 0
            end
            if stuff == 0
                if res[spos] > 0
                    res[spos] -= 1
                end
            elsif stuff == 1
                res[spos] += 1
            else
                res[spos] += 2
            end
        end
    end
    res
end

def process nums, res, stuff
    do_to_lights2 stuff, nums, res
end

res = {}
file = File.new("aoc6_input.txt", "r")
# file = File.new("aoc6_input.txt", "r")
while (line = file.gets)
    numbers = /(\d+),(\d+).+\s(\d+),(\d+)/.match(line).to_a
    if line.include?("off")
        stuff = 0
    elsif line.include?("toggle")
        stuff = 2
    else
        stuff = 1
    end
    process(numbers, res, stuff)
end
file.close

p res.reduce(0) {|k, v| v[1] >= 1 ? k + v[1] : k }
