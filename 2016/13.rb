
def is_wall?(x, y)
    sum = x*x + 3*x + 2*x*y + y + y*y + 1352
    ones = sum.to_s(2).count("1")
    return ones % 2 != 0
end

x = 50
y = 50

map = []
for i in 0.upto(x-1)
    temp = []
    for j in 0.upto(y-1)
        if (is_wall?(j, i))
            temp << "#"
        else
            temp << " "
        end
    end
    map << temp
    temp = []
end

def print_map(map)
    map.each_with_index do |level, i|
        p level.join("")
    end
end
# print_map(map)

def push_to_queue(q, vals, visited, distinct)
    vals.each do |val|
        if val[0][0] < 0 or val[0][1] < 0
            next
        end
        if !visited.include?(val[0]) and !is_wall?(val[0][0], val[0][1])
            q.enq(val)
            visited << val[0]
        end
    end
    true
end

queue = Queue.new
visited = [[1, 1]]

def bfs(queue, visited, init_dist, map)
    ds = 0
    distinct = [[[1, 1], 0]]
    queue.enq([[1, 1], init_dist])
    while !queue.empty?
        top = queue.deq()
        if top[0] == [31, 39]
            p top
            p ds
            return true
        end
        tx = top[0][0]
        ty = top[0][1]
        dist = top[1]
        vals = [
            [[tx, ty-1], top[1] + 1],
            [[tx, ty+1], top[1] + 1],
            [[tx+1, ty], top[1] + 1],
            [[tx-1, ty], top[1] + 1]
        ]
        push_to_queue(queue, vals, visited, distinct)
        if dist <= 50
            ds += 1
        end
    end
end

bfs(queue, visited, 0, map)
# print_map(map)