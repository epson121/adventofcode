require 'digest'

PATHS = []

def traverse(str, pos)
    
    md5 = Digest::MD5.hexdigest(str)
    allowed = ['b', 'c', 'd', 'e', 'f']

    if pos[0] < 0 or pos[1] < 0 or pos[0] > 3 or pos[1] > 3
        return
    end

    if pos == [3, 3]
        PATHS << str
        return
    end

    # if visited.include?(pos)
    #     return
    # else
    #     visited << pos
    # end


    if allowed.include?(md5[0])
        traverse(str + "U", [pos[0], pos[1]-1])
    end
    if allowed.include?(md5[1])
        traverse(str + "D", [pos[0], pos[1]+1])
    end
    if allowed.include?(md5[2])
        traverse(str + "L", [pos[0]-1, pos[1]])
    end
    if allowed.include?(md5[3])
        traverse(str + "R", [pos[0]+1, pos[1]])
    end
end

code = 'pvhmgsws'

traverse(code, [0, 0])

p PATHS.sort_by {|x| x.length}[-1].length - code.length