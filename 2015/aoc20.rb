input = 36000000

c = 0
1.upto(10000000) do |house_number|

    x = house_number
    if (x % 2 != 0)
        next
    end

    twos = 0
    threes = {}
    prime = 0
    sum = 0
    while house_number % 2 == 0 do
        twos += 1
        house_number = house_number/2
    end

    # n must be odd at this point.  So we can skip one element (Note i = i +2)
    (3..Math.sqrt(house_number).ceil+1).step(2) do |i|
        #While i divides n, print i and divide n
        while house_number % i == 0 do
            if threes[i]
                threes[i] += 1
            else
                threes[i] = 1
            end
            house_number = house_number/i;
        end
    end

    # This condition is to handle the case whien n is a prime number
    # greater than 2
    prime = 1
    if (house_number > 2)
        prime = house_number
        if (threes == {})
            prime += 1
        end
    end

    sum1 = 0
    # p "-----s1-----"
    if twos > 0
        0.upto(twos) do |a|
            # p 2**a
            sum1 += 2**a
        end
    end

    # p "-----s2-----"
    sum2 = 1
    threes.each do |k, v|
        s = 0
        0.upto(v) do |b|
            # p k**b
            s += k**b
        end
        sum2 *= s
    end

    sum1 = (sum1 == 0) ? 1 : sum1
    sum2 = (sum2 == 0) ? 1 : sum2
    sum += sum1 * sum2 * prime
    n1 = x/50.0
    n2 = x/50
    if (n1 > n2)
        u = 1
        while u <= n1 do
        # 1.upto(k/2) do |k|
            if (x % u) == 0
                j += u
            end
            u += 1
        end
    else
        u = 1
        while u <= (n1-1) do
        # 1.upto(k/2) do |k|
            if x % u == 0
                j += u
            end
            u += 1
        end
    end
    c += 1
    sum -= j
    if c % 1000 == 0
        p sum * 11
    end
    if (sum * 11) > input
        p "House number"
        p x
        exit
    end
end
