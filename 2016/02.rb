
buttons = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

#part 2
buttons = [
    [0, 0, 1, 0, 0],
    [0, 2, 3, 4, 0],
    [5, 6, 7, 8, 9],
    [0, "A", "B", "C", 0],
    [0, 0, "D", 0, 0]
]

movs = {
    "U" => [-1, 0],
    "D" => [1, 0],
    "L" => [0, -1],
    "R" => [0, 1]
}

pos = [1, 1]

file = File.new("02.txt", "r")
# file = File.new("02-test.txt", "r")
while (line = file.gets)
    moves = line.split("").map{|e| e.strip}
    moves.each do |move|
        if move == ""
            next
        end
        new_pos = [pos[0] + movs[move][0], pos[1] + movs[move][1]]
        if new_pos[0] >= 0 and new_pos[0] < 5 #3
            if new_pos[1] >= 0 and new_pos[1] < 5 #3
                #part 1
                # pos = new_pos
                # part 2
                if buttons[new_pos[0]][new_pos[1]] != 0
                    pos = new_pos
                end
            end
        end
    end
    p buttons[pos[0]][pos[1]]
end