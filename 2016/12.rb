
regs = {
    "a" => 0,
    "b" => 0,
    "c" => 0,
    "d" => 0
}

lines = []

file = File.new("12-test.txt", "r")
file = File.new("12.txt", "r")
while (line = file.gets)
    lines << line
end

i = 0
while i < lines.length
    data = lines[i].split(" ")
    case 
        when lines[i].include?("cpy")
            if regs[data[1]]
                regs[data[2]] = regs[data[1]]
            else
                regs[data[2]] = data[1].to_i
            end
        when lines[i].include?("inc")
            regs[data[1]] += 1
        when lines[i].include?("dec")
            regs[data[1]] -= 1
        when lines[i].include?("jnz")
            if regs[data[1]] != 0
                i += data[2].to_i
                next            
            end
    end
    i += 1
end
p regs["a"]