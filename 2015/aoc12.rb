

#p1
# file = File.new("aoc12_input.txt", "r")
# while (line = file.gets)
#     res = line.scan(/(-?\d+)/)
#     res =  res.map {|s| s[0].to_i}
#     res = res.inject(&:+)
#     p res
# end
# file.close
# 60708 incorrect - too low
# 75114 incorrect - wrong
#p2
file = File.new("aoc12_input.txt", "r")
# file = File.new("aoc12_input_small.txt", "r")
while (line = file.gets)
    c = 0
    while c < 1000
        c += 1
        redpos = line.index(/:\"red\"/)
        p redpos
        lp = false
        otherlp = []
        rp = false
        otherrp = []
        rectlp = []
        rectrp = []
        if !redpos
            next
        end
        p redpos
        (0..redpos).reverse_each do |i|
            p i
            if line[i] == "]"
                p "here4"
                rectlp << 1
            end
            if line[i] == "["
                p "here3"
                if rectlp.length == 0
                    break
                else
                    rectlp.pop
                end
            end
            if line[i] == "}"
                p "here2"
                otherlp << 1
            end
            if line[i] == "{"
                p "here1"
                if otherlp.length == 0
                    lp = i
                    break
                else
                    otherlp.pop
                end
            end
        end
        (redpos..line.length).each do |i|
            if line[i] == "["
                rectrp << 1
            end
            if line[i] == "]"
                if rectrp.length == 0
                    break
                else
                    rectrp.pop
                end
            end
            if line[i] == "{"
                otherrp << 1
            end
            if line[i] == "}"
                if otherrp.length == 0
                    rp = i
                    break
                else
                    otherrp.pop
                end
            end
        end
        # p "lp " + lp.to_s
        # p "rp " + rp.to_s
        r = ""
        if lp && rp
            while lp != rp+1
                r += line[lp]
                line[lp] = "X"
                lp += 1
            end
        else
            line[redpos] = "+++"
            line[redpos+1] = "+++"
            line[redpos+2] = "+++"
        end
        p r
    end
    p line
    res = line.scan(/(-?\d+)/)
    res =  res.map {|s| s[0].to_i}
    res = res.inject(&:+)
    p res
end
file.close