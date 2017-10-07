myfunc = @(x)(x-1)*exp(-(x-1)^2);
dfunc1 = @(x) exp(-(x-1)^2)-exp(-(x-1)^2)*(2*x-2)*(x-1);
roots = zeros(1,5);
ea1 = zeros(1,5);
iterat = zeros(1,5);
for y = 1:5
    [roots(y),ea1(y),iterat(y)]=newtraph(myfunc,dfunc1,3, .0001,y);
end
disp('Iterations:');
disp(iterat);
disp('Roots:');
disp(roots);
disp('Approximate Error:');
disp(ea1);

clear;
clc;
