
require 'thread'

def is_wall?(x, y, map)
    map[x][y] == "#"
end

map = []
visited = []

file = File.new("24.txt", "r")
i = 0
while (line = file.gets)
    fields = line.split("")
    if fields.include?("0")
        visited << i
        visited << fields.index("0")
    end
    map << fields
    i += 1
end

def print_map(map)
    map.each_with_index do |level, i|
        p level.join("")
    end
end

def push_to_queue(q, vals, visited, map)
    vals.each do |val|
        if val[0][0] < 0 or val[0][1] < 0
            next
        end
        if val[0][0] > 41 or val[0][1] > 186
            next
        end
        if !visited.include?(val[0]) and !is_wall?(val[0][0], val[0][1], map)
            q.enq(val)
            visited << val[0]
        end
    end
    true
end

queue = Queue.new

DISTS = {}

def bfs(queue, visited, map, nodes)
    res = {}
    queue.enq([visited, 0])
    while res.length != nodes.length
        top = queue.deq()

        tx = top[0][0]
        ty = top[0][1]
        dist = top[1]
        if nodes.include?(map[tx][ty])
            res[map[tx][ty]] = [dist, [tx, ty]]
        end

        vals = [
            [[tx, ty-1], dist + 1],
            [[tx, ty+1], dist + 1],
            [[tx+1, ty], dist + 1],
            [[tx-1, ty], dist + 1]
        ]
        push_to_queue(queue, vals, visited, map)
    end
    res
end

DS = []

def perform(queue, visited, map, nodes, distance)

    if nodes.length == 0
        if P2
            home = bfs(queue, visited, map, ["0"])
            return distance + home["0"][0]
        else
            return distance
        end
    end

    res = []
    points = bfs(queue, visited, map, nodes)
    points.each do |point|
        nc = nodes.clone
        nc.delete(point[0])
        queue.clear
        res << perform(queue, point[1][1], map, nc, distance + point[1][0])
    end

    res.min
end

nodes = ["2", "4", "5"]
nodes = ["1", "2", "3", "4", "5", "6", "7"]
P2 = true
p perform(queue, visited, map, nodes, 0)