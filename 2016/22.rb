file = File.new("22.txt", "r")

nodes = []
while (line = file.gets)
    data = line.split(" ")
    x = data[0].split("-")[1].gsub("x", "").to_i
    y = data[0].split("-")[2].gsub("y", "").to_i
    size = data[1].gsub("T", "").to_i
    used = data[2].gsub("T", "").to_i
    avail = data[3].gsub("T", "").to_i
    percentage = data[4].gsub("T", "").to_i
    node = {
        :pos => [x, y],
        :size => size,
        :used => used,
        :avail => avail,
        :percentage => percentage
    }
    nodes << node
end

#part 1
viable = 0
nodes.each do |n1|
    if n1[:used] == 0
        next
    end
    nodes.each do |n2|
        if n1[:pos] != n2[:pos]
            if n1[:used] < n2[:avail]
                viable += 1
            end
        end
    end
end


#part 2
grid = []

nodes.each do |node|
    if !grid[node[:pos][0]]
        grid[node[:pos][0]] = []
    end

    if node[:pos][0] == 36 and node[:pos][1] == 0
        grid[node[:pos][0]][node[:pos][1]] = " G "
    elsif node[:pos][0] == 0 and node[:pos][1] == 0
        grid[node[:pos][0]][node[:pos][1]] = "(.)"
    elsif node[:percentage] > 95
        grid[node[:pos][0]][node[:pos][1]] = " # "
    elsif node[:used] == 0
        grid[node[:pos][0]][node[:pos][1]] = " _ "
    else
        grid[node[:pos][0]][node[:pos][1]] = " . "
    end
end

#solution 35 * 5 + 61 => by hand = 236