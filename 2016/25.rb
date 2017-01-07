
lines = []

file = File.new("25.txt", "r")
while (line = file.gets)
    lines << line
end


def vm(lines, regs)
    a = []
    i = 0
    c = 0
    check = false
    while i < lines.length
        data = lines[i].split(" ")
        case
            when lines[i].include?("cpy")
                # p regs[data[1]]
                if regs[data[1]] != nil
                    regs[data[2]] = regs[data[1]]
                else
                    regs[data[2]] = data[1].to_i
                end
            when lines[i].include?("inc")
                    regs[data[1]] += 1
            when lines[i].include?("dec")
                    regs[data[1]] -=1
            when lines[i].include?("out")
                a << regs[data[1]]
            when lines[i].include?("jnz")
                if (regs[data[1]] != nil and regs[data[1]] != 0) or data[1].to_i != 0
                    if regs[data[2]] != nil
                        i += regs[data[2]]
                    else
                        i += data[2].to_i
                    end
                    next
                end
        end

        if (a.length == 10)
            if a == [0, 1]*5
                return true
            else
                return false
            end
        end
        i += 1
        c += 1
    end
end

a = 1
regs = {
    "a" => 1,
    "b" => 0,
    "c" => 0,
    "d" => 0
}
while !vm(lines, regs)
    a += 1
    regs["a"] = a
end

p a
