
floor1 = [0, 1, 1, 1, 1, 1]
floor2 = [2, 4, 6, 8]
floor3 = [3, 5, 7, 9]
floor4 = []

floors = [
    floor1,
    floor2,
    floor3,
    floor4
]

steps = 0
length = floors.length
floors.each_with_index do |floor, index|
    steps += 2 * floor.length
    if index < 2
        floor.length.times do |a|
            floors[index+1] << 1
        end
    end
    p floor
end

p steps - 3