
def is_subset_sum arr, n, sum
    if sum == 0 and n == 0
        return true
    end
    if (n == 0 and sum != 0)
        return false
    end
    if arr[n-1].nil? || arr[n-1] > sum
        return is_subset_sum(arr, n-1, sum)
    end
    return is_subset_sum(arr, n-1, sum) ||
           is_subset_sum(arr, n-1, sum-arr[n-1])
end

def part a, n
    sum = a.inject(:+)
    if sum % 2 != 0
        return false
    end
    return is_subset_sum(a, n, sum/2)
end

def part2 a, n, sum
    # sum = a.inject(:+)
    if sum % 2 != 0
        return false
    end
    return is_subset_sum(a, n, sum/2)
end

a = [11, 5, 6]

# p part2(a, 4, 22)

arr = [1, 3, 5, 11, 13,17,19,23,29,31,37,41,43,47,53,59,67,71,73,79,83,89,97,101,103,107,109,113]

$rs = []
def split arr
    0.upto(arr.length-1) do |i|
        (i+1).upto(arr.length-1) do |j|
            (j+1).upto(arr.length-1) do |k|
                (k+1).upto(arr.length-1) do |l|
                    (l+1).upto(arr.length-1) do |m|
                                sum = arr[i] + arr[j] + arr[k] + arr[l] + arr[m]
                                if sum != 381
                                    next
                                else
                                    p "yes"
                                    p arr[i].to_s + " " + arr[j].to_s + " " + arr[k].to_s + " " + arr[l].to_s + " " + arr[m].to_s
                                end
                                new_arr = arr.clone
                                new_arr.delete(arr[i])
                                new_arr.delete(arr[j])
                                new_arr.delete(arr[k])
                                new_arr.delete(arr[l])
                                new_arr.delete(arr[m])
                                $rs << (arr - new_arr)
                    end
                end
            end
        end
    end
end

split(arr)

min = 99999999999999999999999999999999

p $rs

$rs.each do |e|
    p e
    if e.inject(:*) < min
        min = e.inject(:*)
    end
end

p min

#265031