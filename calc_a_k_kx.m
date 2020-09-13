% calc_a_k_kx.m
w=1e15; c=3e8;  k0=w/c;      
n2=1.5; kap2=0; 
kx=linspace(0,3*k0,200);
pre=n2^2-kap2^2-(kx/k0).^2;
pim=2*n2*kap2;
k2z=k0*sqrt(0.5*(pre+sqrt(pre.^2+pim.^2)));
a2=k0*sqrt(0.5*(-pre+sqrt(pre.^2+pim.^2)));
k2=sqrt(k2z.^2+kx.^2);
fi=atan(kx./k2z);
figure
subplot(2,1,1), plot(kx,k2z,kx,k2,kx,a2), ylabel('k,kz,a (m-1)'), xlabel('kx (m-1)')
title(['w=' num2str(w, '%10.2e\n') ' Hz, nE=' num2str(n2) ', kapE=' num2str(kap2)]), 
legend('k2z','k2','a2')
subplot(2,1,2), plot(kx,fi*90/pi*2),ylabel('fi (degrees)'), xlabel('kx (m-1)')