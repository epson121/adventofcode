file = File.new("01.txt", "r")
while (line = file.gets)
    moves = line.split(",").map{|e| e.strip}
end

pos = [0, 0]
visited = []

map2 = {
    "N" => {
        "L" => [-1, 'W'],
        "R" => [1, 'E']
        },
    "S" => {
        "L" => [1, 'E'],
        "R" => [-1, 'W']
        },
    "E" => {
        "L" => [1, 'N'],
        "R" => [-1, 'S']
        },
    "W" => {
        "L" => [-1, 'S'],
        "R" => [1, 'N']
        }
}
duplicate = nil
facing = "N"
moves.each do |move|
    dir = move[0]
    len = move[1..move.length].to_i
    for i in 1..len
        if facing == "N" or facing == "S"
            l = [pos[0] + 1 * map2[facing][dir][0], pos[1]]
        else
            l = [pos[0], pos[1] + 1 * map2[facing][dir][0]]
        end
        if visited.include?(l)
            if duplicate == nil
                duplicate = l
            end
        end
        visited << l
        pos = l
    end
    facing = map2[facing][dir][1]
end

p "Easter bunny is away " + pos.map(&:abs).inject(&:+).to_s
p "Distance is " + duplicate.map(&:abs).inject(&:+).to_s
