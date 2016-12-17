

def print_screen(screen)
    rs = []
    0.upto(screen.length-1) do |x_pos|
        p screen[x_pos].join("")
    end
end

def init_screen(y, x)
    res = []
    0.upto(x-1) do |x_pos|
        res[x_pos] = []
        0.upto(y-1) do |y_pos|
            res[x_pos] << "."
        end
    end
    return res
end

def rect(screen, y, x)
    0.upto(x-1) do |x_pos|
        0.upto(y-1) do |y_pos|
            screen[x_pos][y_pos] = "#"
        end
    end
    return screen
end

def rotate_row(screen, y, n)
    row = rotate(screen[y].reverse, n)
    screen[y] = row.reverse
    return screen
end

def rotate(row, n)
    while n > 0 do
        s = row.shift
        row << s
        n -= 1
    end
    return row
end

def rotate_column(screen, x, n)
    arr = []
    screen.map {|row| arr << row[x]}
    rot = rotate(arr.reverse, n).reverse
    screen.each_with_index.map  {|row, i| row[x] = rot[i]}
    return screen
end



screen = init_screen(7, 3)
# screen = rect(screen, 3, 2)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_column(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_column(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_column(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_row(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_row(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_row(screen, 0, 1)
# print_screen(screen)
# p "_-------------------"
# screen = rotate_row(screen, 0, 3)
# print_screen(screen)
# p "_-------------------"

def count(screen)
    c = 0
    0.upto(screen.length-1) do |x_pos|
        0.upto(screen[x_pos].length-1) do |y_pos|
            if screen[x_pos][y_pos] == "#"
                c+=1
            end
        end
    end
    c
end

def parse_rect(line)
    return line.split(" ")[1].split("x").map(&:to_i)
end

def parse_rotate(line)
    l = line.split(" ")
    x = l[2].split("=")[1].to_i
    y = l[4].to_i
    return [x, y]
end

file = File.new("08-test.txt", "r")
file = File.new("08.txt", "r")
screen = init_screen(7, 3)
screen = init_screen(50, 6)
while (line = file.gets)
    if /rect/.match(line)
        pos = parse_rect(line)
        screen = rect(screen, pos[0], pos[1])
    elsif /row/.match(line)
        pos = parse_rotate(line)
        screen = rotate_row(screen, pos[0], pos[1])
    else
        pos = parse_rotate(line)
        screen = rotate_column(screen, pos[0], pos[1])
    end
    print_screen(screen)
    p "___________________________"
end

p count(screen)