function output = filter_by_threshold(input, threshold)
%{

Input:
Output:
%}
for row = 1:size(input, 1)
    for col = 1:size(input, 2)
        if sum(input(row, col)) <= threshold
            input(row, col, 1) = 0;
            input(row, col, 2) = 0;
            input(row, col, 3) = 0;
        end
    end
end
output = input;
end
