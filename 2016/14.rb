require 'digest'

salt = "abc"
salt = "jlmsuwbz"

def get_triplet(str)
    if str =~ /(.)\1\1/
        return $1
    end
    nil
end

def check5(str, outstanding, i, res)
    fives = []
    0.upto(str.length-5) do |idx|
        if str[idx] == str[idx+1] and str[idx] == str[idx+2] and str[idx] == str[idx+3] and str[idx] == str[idx+4]
            fives << str[idx]
        end
    end

    fives.each do |five|
        if outstanding[five] != nil
            outstanding[five].each do |triplet|
                if triplet > (i-1000)
                    if !res.include?(triplet)
                        res << triplet
                    end
                end
                triplet = 0
            end
        end
    end
    res
end

cache = {}

def stretched(str)
    md5 = Digest::MD5.hexdigest(str).downcase
    2016.times { md5 = Digest::MD5.hexdigest(md5) }
    md5
end

beginning_time = Time.now
outstanding3 = {}
res = []
i = 0
while res.length < 64
    #p1
    #md5 = Digest::MD5.hexdigest(salt + i.to_s).downcase
    #p2
    md5 = stretched(salt+i.to_s)
    res = check5(md5, outstanding3, i, res)
    
    triplet = get_triplet(md5)
    
    if triplet == nil
        i += 1
        next
    end

    (outstanding3[triplet] ||= []) << i
    
    i += 1
end

p res.sort[0..63]
end_time = Time.now
puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"