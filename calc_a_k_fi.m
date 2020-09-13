% calc_a_k_fi.m
w=1e15; c=3e8;  k0=w/c;      
n=1.6; kap=0; nc=n+1j*kap;
fi=linspace(0,pi/2-.04,100); afi=fi*180/pi;   
% fi entre 0 i quasi pi/2
cfi=cos(fi);
Q=k0^2*n*kap;   P=k0^2*(n^2-kap^2);    
t1=P^2.*cfi.^2;  t2=4*Q^2;  disc=t1+t2;
k2=P/2+sqrt(disc)./2./cfi;  k=sqrt(k2);  a=Q./cfi./k;
kx=k.*sin(fi); kz=k.*cfi;

plot(afi,a,'--',afi,kz,'-.',afi,k)
legend('a','kz','k'), 
xlabel('fi (degrees)'), ylabel('k, kz, a (m-1)')