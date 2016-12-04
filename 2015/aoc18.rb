

file = File.new("aoc18_input.txt", "r")
# file = File.new("aoc18_input_small.txt", "r")

lights = []
while (line = file.gets)
    row = []
    line.gsub!("\n", "")
    line.each_char do |ch|
        row << ((ch === "#") ? 1 : 0)
    end
    lights << row
end
file.close


sizex = lights[0].length
sizey = lights.length

def get_neighbours lights, xpos, ypos
    ns = []
    if (xpos - 1 >= 0)
        ns << lights[xpos-1][ypos]
    else
        ns << 0
    end
    if (xpos + 1 < lights[xpos].length)
        ns << lights[xpos+1][ypos]
    else
        ns << 0
    end
    if (ypos - 1 >= 0 )
        ns << lights[xpos][ypos-1]
    else
        ns << 0
    end
    if (ypos + 1 < lights.length)
        ns << lights[xpos][ypos+1]
    else
        ns << 0
    end
    if (ypos -1 >= 0 and xpos - 1 >= 0)
        ns << lights[xpos-1][ypos-1]
    else
        ns << 0
    end
    if (ypos -1 >= 0 and xpos + 1 < lights[xpos].length)
        ns << lights[xpos+1][ypos-1]
    else
        ns << 0
    end
    if (ypos + 1 < lights.length and xpos - 1 >= 0)
        ns << lights[xpos-1][ypos+1]
    else
        ns << 0
    end
    if (ypos + 1 < lights.length and xpos + 1 < lights[xpos].length)
        ns << lights[xpos+1][ypos+1]
    else
        ns << 0
    end
    ns
end


# def get_next_state lights, ypos, xpos
#     neighbours_count = (get_neighbours(lights, xpos, ypos)).inject(:+)
# end

# 536
# 102
# 748

def graphical_representation arr, n
    0.upto n-1 do |x|
        0.upto n-1 do |y|
            if arr[x][y] == 1
                print "#"
            else
                print "."
            end
        end
        p ""
    end
end

def new_array n
    s = []
    r = []
    1.upto n do |x|
        1.upto n do |y|
            r << 0
        end
        s << r
        r = []
    end
    s
end

def how_many_lights arr, n
    c = 0
    0.upto n-1 do |x|
        0.upto n-1 do |y|
            if (arr[x][y] == 1)
                c += 1
            end
        end
    end
    c
end

1.upto 100 do |l|
    lights_copy = new_array(100)
    graphical_representation lights, 100
    sleep(0.1)
    system "clear"
    0.upto sizex-1 do |x|
        0.upto sizey-1 do |y|
            neighbours_count = (get_neighbours(lights, x, y)).inject(:+)
            # p "---------------------"
            # p "Neighbours for (#{x}, #{y}) " + neighbours_count.to_s
            # p lights[x][y]
            if lights[x][y] == 1 and (neighbours_count == 2 or neighbours_count == 3)
                # p "set to 1 first"
                lights_copy[x][y] = 1
            elsif lights[x][y] == 0 and neighbours_count == 3
                # p "set to 1"
                lights_copy[x][y] = 1
            else
                # p "set to 0"
                lights_copy[x][y] = 0
            end
            lights_copy[0][0] = 1
            lights_copy[0][99] = 1
            lights_copy[99][0] = 1
            lights_copy[99][99] = 1
        end
    end
    p "-----------------------"
    # p lights_copy
    lights = lights_copy
end
graphical_representation lights, 100
p how_many_lights lights, 100