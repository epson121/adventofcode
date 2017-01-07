
regs = {
    "a" => 12,
    "b" => 0,
    "c" => 0,
    "d" => 0
}

lines = []

file = File.new("23-test.txt", "r")
file = File.new("12.txt", "r")
file = File.new("23.txt", "r")
while (line = file.gets)
    lines << line
end

i = 0
c = 0
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
        # when lines[i].include?("mul")
        #     p "ok"
        #     regs[data[3]] = regs[data[2]] * regs[data[1]]
        #     regs[data[2]] = 0
        #     regs[data[1]] = 0
        when lines[i].include?("tgl")
            if regs[data[1]] != 0
                tmp = regs[data[1]] + i
                if tmp < lines.length and tmp >= 0
                    case
                    when lines[tmp].include?("cpy")
                        lines[tmp].gsub!("cpy", "jnz")
                    when lines[tmp].include?("inc")
                        lines[tmp].gsub!("inc", "dec")
                    when lines[tmp].include?("dec")
                        lines[tmp].gsub!("dec", "inc")
                    when lines[tmp].include?("tgl")
                        lines[tmp].gsub!("tgl", "inc")
                    when lines[tmp].include?("jnz")
                        lines[tmp].gsub!("jnz", "cpy")
                    end
                end
            end
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
    # p regs
    # p lines
    # p i
    # gets
    i += 1
    c += 1
    # if c % 10 == 0
    #     p regs
    #     p lines
    #     p i
    #     gets
    # end
end

p regs["a"]