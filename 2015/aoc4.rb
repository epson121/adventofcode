#ckczppom
require 'digest'

secret = "ckczppom"

def has_n_leading_zeros hash, n
    hash[0..n-1] == "0" * n ? true : false
end

p has_n_leading_zeros "00000123123sdae21das", 5


result = false
num = 1
while !result
    new_hash = Digest::MD5.hexdigest(secret + num.to_s)
    if has_n_leading_zeros(new_hash, 6)
        result = true
        p num
    else
        num += 1
    end
end