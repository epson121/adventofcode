file = File.new("20-test.txt", "r")
file = File.new("20.txt", "r")
ranges = []
while (line = file.gets)
    ranges << line.split("-").map(&:to_i)
end


def parse(ranges, idx, lohi, overalls)

    if idx == ranges.length
        return overalls
    end

    if lohi.nil?
        lohi = ranges[idx]
        return parse(ranges, idx+1, lohi, overalls)
    end

    if ranges[idx][0] > lohi[1] + 1
        overalls += (ranges[idx][0] - lohi[1] - 1)
        lohi[1] = ranges[idx][1]
        return parse(ranges, idx+1, lohi, overalls)
    end

    if ranges[idx][0] <= lohi[1]+1 and ranges[idx][1] > lohi[1]
        lohi = [lohi[0], ranges[idx][1]]
    end

    return parse(ranges, idx+1, lohi, overalls)
end


a = ranges.sort_by {|x| x[0]}

p parse(a, 0, nil, 0)