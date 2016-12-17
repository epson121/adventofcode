
discs = {}
needed = []
i = 1
file = File.new("15.txt", "r")
while (line = file.gets)
    data = line.split(" ")
    discs[i] = [data[3].to_i, data[11].gsub(".", "").to_i]
    needed << (data[3].to_i - i) % data[3].to_i
    i += 1
end

s = 1
while true
    p1 = (discs[1][1] + s) % discs[1][0]
    p2 = (discs[2][1] + s) % discs[2][0]
    p3 = (discs[3][1] + s) % discs[3][0]
    p4 = (discs[4][1] + s) % discs[4][0]
    p5 = (discs[5][1] + s) % discs[5][0]
    p6 = (discs[6][1] + s) % discs[6][0]
    p7 = (discs[7][1] + s) % discs[7][0]
    if [p1, p2, p3, p4, p5, p6, p7] == needed
        p s
        break
    end
    s += 1
end