


def stringify pos
    return pos[0].to_s + "x" + pos[1].to_s
end

def move arrow, current
    arrows = {
        ">" => [1, 0],
        "v" => [0, -1],
        "<" => [-1, 0],
        "^" => [0, 1]
    }
    pos = current.split("x").map {|e| e.to_i};
    moved = pos.zip(arrows[arrow]).map {|sub| sub.inject(:+)}
    return stringify(moved)
end

def traverse path, robot=false
    # if robot
        current = ["0x0", "0x0"]
        presents_delivered = {"0x0" => 1}
        turn = 0
        path.each_char do |arrow|
                current[turn] = move(arrow, current[turn])
                if presents_delivered[current[turn]]
                    presents_delivered[current[turn]] += 1
                else
                    presents_delivered[current[turn]] = 1
                end
            if robot
                turn = turn == 0 ? 1 : 0
            else
                turn = 0
            end
        end
    # else
    #     current = "0x0";
    #     presents_delivered = {"0x0" => 1}
    #     path.each_char do |arrow|
    #         current = move(arrow, current)
    #         if presents_delivered[current]
    #             presents_delivered[current] += 1
    #         else
    #             presents_delivered[current] = 1
    #         end
    #     end
    # end
    presents_delivered
end

# file = File.new("3_arrows.txt", "r")
# paper_size = 0
# ribbon_length = 0
# while (line = file.gets)
#     result = traverse(line, true)
# end
# file.close

file = File.new("3_arrows.txt", "r")
paper_size = 0
ribbon_length = 0
while (line = file.gets)
    r1 = traverse(line)
    r2 = traverse(line, true)
end
file.close

# p result

p r1.reduce(0) {|k, v| v[1] >= 1 ? k + 1 : k }
p r2.reduce(0) {|k, v| v[1] >= 1 ? k + 1 : k }


