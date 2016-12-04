def is_triangle(triangle)
    sorted = triangle.sort
    return sorted[0] + sorted[1] > sorted[2]
end

file = File.new("03.txt", "r")
# file = File.new("03-test.txt", "r")
sum_triangles = 0
t1 = []
t2 = []
t3 = []
i = 0
while (line = file.gets)
    i += 1
    triangle = line.split(" ").map{|e| e.strip.to_i}
    t1 << triangle[0]
    t2 << triangle[1]
    t3 << triangle[2]
    if i % 3 == 0
        sum_triangles += is_triangle(t1) ? 1 : 0
        sum_triangles += is_triangle(t2) ? 1 : 0
        sum_triangles += is_triangle(t3) ? 1 : 0
        t1 = []
        t2 = []
        t3 = []
    end
end


p sum_triangles

