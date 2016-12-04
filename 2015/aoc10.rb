
# put = 1113222113;

# slow as fuck
# p input
# cn = 3
# count = 0
# 4.times do
#     res = ""
#     subres = []
#     while input > 0
#         num = input % 10
#         if num == cn
#             count += 1
#         else
#             res += cn.to_s + count.to_s
#             count = 1
#             cn = num
#         end
#         # if subres.include? num
#         #     subres << num
#         # else
#         #     if subres.length>0
#         #         res += subres[0].to_s + subres.length.to_s
#         #     end
#         #     subres = [num]
#         # end
#         input = input / 10
#     end
#     res += cn.to_s + count.to_s
#     # r = ""
#     # res.each do |elem|
#     #     if elem.length > 0
#     #         r += elem[0].to_s + elem.length.to_s
#     #     end
#     # end
#     input = res.reverse.to_i
#     p input
# end=end

# p input.to_s.length




# much faster than 2 other ideas
input2 = "1113222113";
res_n = []
input2.each_char do |c|
    res_n << c.to_i
end

p res_n
50.times do
    cn = res_n[0]
    count = 0
    res = []
    res_n.each do |num|
        if num == cn
            count += 1
        else
            res << count
            res << cn
            count = 1
            cn = num
        end
    end
    res << count
    res << cn
    res_n = res
end
p res_n.length


# slow as fuck
# p input2
# 40.times do
#     cn = input2[0]
#     count = 0
#     res = ""
#     input2.each_char do |num|
#         if num == cn
#             count += 1
#         else
#             res += String(count) + cn
#             count = 1
#             cn = num
#         end
#     end
#     res += String(count) + cn
#     input2 = res
# end
# p input2.length

