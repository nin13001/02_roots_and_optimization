epsilon = 0.039; 
epsilon = epsilon*6.9477e-21; 
epsilon = epsilon*1e18; 


sigma = 2.934; 
sigma = sigma*0.10;

lennard_jones = @(x,sigma,epsilon) 4*epsilon*((sigma./x).^12-(sigma./x).^6);
[x,E,ea,its] = goldmin(@(x) lennard_jones(x,sigma,epsilon),3.2,3.5)

figure(1)
parabolic(3.2,3.5)

epsilon = 0.039; 
epsilon = epsilon*6.9477e-21;
sigma = 2.934; 
sigma = sigma*0.10; 
x=linspace(2.8,6,200)*0.10; 
ex = lennard_jones(x,sigma,epsilon);

[xmin,emin] = goldmin(@(x) lennard_jones(x,sigma,epsilon),0.28,0.6)

figure(2)
plot(x,ex,xmin,emin,'o')
ylabel('Lennard Jones Potential [aJ/Atom]')
xlabel('Bond Length [nm]')
title('LJ Potential vs Bond Length');

e_total = @(dx,F) lennard_jones(xmin+dx,sigma,epsilon)-F.*dx;

N=30;
warning('off')
dx = zeros(1,N);
F_applied=linspace(0,0.0022,N);
for i=1:N
    optmin=goldmin(@(dx) e_total(dx,F_applied(i)),-0.001,0.035);
    dx(i)=optmin;
end

plot(dx,F_applied)
xlabel('dx [nm]')
ylabel('Force [nN]')
title('Force vs dx')

dx_full = linspace(0,0.06,N);
F = @(dx) 4*epsilon*6*(sigma^6./(xmin+dx).^7-2*sigma^12./(xmin+dx).^13)
plot(dx_full,F(dx_full),dx,F_applied)

[K,SSE_min] = fminsearch(@(K) sse_of_parabola(K,dx,F_applied),[1,1]);
fprintf('\n Nonlinear spring constants = K1=%1.2f nN/nm and K2=%1.2f nN/nm^2\n',K)
fprintf('The mininum sum of squares error = %1.2e \n',SSE_min)

plot(dx,F_applied,'o',dx,K(1)*dx+1/2*K(2)*dx.^2)