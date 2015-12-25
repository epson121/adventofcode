# To continue, please consult the code grid in the manual.
# Enter the code at row 2978, column 3083.

counter = 1
row = 1
col = 1
c_row = 1
c_col = 1
prev_code = 0
while true
    if counter == 1
        current_code = 20151125
    else
        current_code = (prev_code * 252533)%33554393
    end
    if row == 2978 and col == 3083
        p current_code
        exit
    end
    # p "row: " + row.to_s
    # p "col: " + col.to_s
    col += 1
    row -= 1
    if row == 0
        c_row += 1
        c_col = 1
        row = c_row
        col = c_col
    end
    counter += 1
    prev_code = current_code
end

# 15506625
