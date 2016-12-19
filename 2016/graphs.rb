

class Node1

    def initialize(value, link)
        @value = value
        @next = link
    end

    def get_value
        @value
    end

    def get_next
        @next
    end

end

class Node

    def initialize(links, value)
        @links = links
        @neighbours = link
        @visited = false
    end

    def get_value
        @value
    end

    def get_neighbours
        @neighbours
    end

    def is_visited
        @visited
    end

    def set_visited
        @visited = true
    end

end

def cost(a, b)
    cost = nil
    if a.get_next == b
        cost = 1
    elsif a == b
        cost = 0
    end
    return cost
end

# traverse tree
current = head
while current != nil
    p current.get_value
    current = current.get_next
end


 # stack<node> s;
 # s.push(start);
 # while (s.empty() == false) {
 #  top = s.top();
 #  s.pop();

 #  if (top is not marked as visited) {
 #   check for termination condition (have we reached the node we want to?)

 #   mark top as visited;
 #   add all of top's neighbors to the stack.
 #  }
 # }
def dfs(node)
    stack = []
    while !stack.empty?
        top = stack.pop
        if !top.is_visited
            if top.get_value = 5
                return top;
            end
            stack.push(top.get_neighbours)
            top.set_visited
        end
    end
end