w=1e15; c=3e8;  k0=w/c;      
n2=1.5; kap2=0.0; 
kx=linspace(0,3*k0,200)
Q=k0.^2.*n2.*kap2; 
P=k0.^2.*(n2.^2-kap2.^2);
R=P-kx.^2; 
k2z2=R./2+sqrt(R.^2+4.*Q.^2)/2;
k2z=sqrt(k2z2);  
k2=sqrt(kx.^2+k2z.^2);
fi=arccos(k2z./k2);
a2=sqrt(kx.^2+k2z2-P);
plot(kx,a2,'b',kx,k2,'r',kx,k2z,'g',kx,fi,'m')
legend('a2')