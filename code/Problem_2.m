Problem 2:

Bisect.m

function [root,fx,ea,iter]=bisect(func,xl,xu,es,maxit,varargin)
if nargin<3,error('Three Input Arguments Required'),end
test = func(xl,varargin{:})*func(xu,varargin{:});
if test>0,error('No Sign Change'),end
if nargin<4||isempty(es), es=0.0001;end
if nargin<5||isempty(maxit), maxit=50;end
iter = 0; xr = xl; ea = 100;
while (1)
  xrold = xr;
  xr = (xl + xu)/2;
  iter = iter + 1;
  if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
  test = func(xl,varargin{:})*func(xr,varargin{:});
  if test < 0
    xu = xr;
  elseif test > 0
    xl = xr;
  else
    ea = 0;
  end
  if ea <= es || iter >= maxit,break,end
end
root = xr; fx = func(xr, varargin{:})
end

FalsePos.m

function [root,fx,ea,iter]=falsepos(func,xl,xu,es,maxit,varargin)

if nargin < 3,error('Three Input Arguments Required'),end
test = func(xl,varargin{:})*func(xu,varargin{:});
if test>0,error('No Sign Change'),end
if nargin < 4||isempty(es), es=0.0001;end
if nargin < 5||isempty(maxit), maxit=50;end
iter = 0; xr = xl; ea = 100;
while (1)
  xrold = xr;
  xr=xu - (func(xu)*(xl-xu))/(func(xl)-func(xu));
  iter = iter + 1;
  if xr ~= 0,ea = abs((xr - xrold)/xr) * 100;end
  test = func(xl,varargin{:})*func(xr,varargin{:});
  if test < 0
    xu = xr;
  elseif test > 0
    xl = xr;
  else
    ea = 0;
  end
  if ea <= es || iter >= maxit,break,end
end
root = xr; fx = func(xr, varargin{:});
end

Mod_Secant.m;

function [root,ea,iter]=mod_secant(func,dx,xr,es,maxit,varargin)
if nargin<3,error('Three Input Arguments Required'),end
if nargin<4 || isempty(es),es=0.0001;end
if nargin<5 || isempty(maxit),maxit=50;end
iter = 0;
while (1)
  xrold = xr;
  dfunc=(func(xr+dx)-func(xr))./dx;
  xr = xr - func(xr)/dfunc;
  iter = iter + 1;
  if xr ~= 0
    ea = abs((xr - xrold)/xr) * 100;
  end
  if ea <= es || iter >= maxit, break, end
end
root = xr;
end


Function Problem 2

clear;
clc;
%Part A
cable= @(T) T/10.*cosh(10./T*30)+30-T/10-35;
[root,fx,ea,iter]=falsepos(cable,1E2,1E3,1E-5,1E4);
[root1,fx1,ea1,iter1]=bisect(cable,1E2,1E3,1E-5,1E4);
[root2,ea2,iter2]=mod_secant(cable,1E2,1E3,1E-5,1E4);


%Part B
disp('false pos: ',[root,fx,ea,iter],'bisect:',[root1,fx1,ea1,iter1],'Mod_Secant ',[root2,ea2,iter2]);



T=root2;
x=-10:50;
y=T/10.*cosh(10./T*x)+30-T/10;

%Part C: Plot
plot(x,y)
title('Powerline: Catenary Cable')
xlabel('Distance (m)')
ylabel('Height (m)')
print('Plot1','-dpng')

clear;
clc;
