a = 113383
b = 0
while a != 1
    b += 1
    if a % 2 == 0
        a /= 2
    else
        a *= 3
        a += 1
    end
    p a
    p b
end


#34