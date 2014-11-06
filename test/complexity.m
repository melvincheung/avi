function complexity(n)
% compute different complexities of input n
% may amend to output a struct of diffenent complexities results
n_log_n = n*log2(n);
n_square = n^2;
n_cube = n^3;
fprintf('n*log(n) = %f\n', n_log_n);
fprintf('n^2 = %f\n', n_square);
fprintf('n^3 = %f\n', n_cube);
