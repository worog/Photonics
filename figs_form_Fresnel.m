% figs_form_Fresnel
clear all
close all
c=3e8; lamb=633e-9; w=2*pi*c/lamb; 
% units SI
eps1 = 1.0; mu1=1.;
k1=w/c*sqrt(eps1*mu1);
eps2 = (2+1i*7)^2; mu2=1.;  
% 2+1i*7 is the refractive index of 2nd medium
% eps2 = (2)^2; mu2=1.;  
% 2 is the refractive index of 2nd medium
k2=w/c*sqrt(eps2*mu2); 
theta1g=linspace(0,90,31); 
% in degrees 
theta1=theta1g*pi/180;     
% in radians
kp=k1*sin(theta1);   
% same as kx, wavevector parallel to the interface
kz1=sqrt(k1^2-kp.^2); kz2=sqrt(k2^2-kp.^2);
rs=(mu2 *kz1-mu1 *kz2)./(mu2 *kz1+mu1 *kz2);
rp=(eps2*kz1-eps1*kz2)./(eps2*kz1+eps1*kz2);
ts=2*mu2 *kz1./(mu2 *kz1+mu1 *kz2);
tp=2*eps2*kz1./(eps2*kz1+eps1*kz2) * sqrt(mu2*eps1/mu1/eps2);
figure(1)
subplot(1,3,1), plot(theta1g,abs(rs),'-+', theta1g, abs(ts),'-o'), title( { ['n=' num2str(real(sqrt(eps2))) ', kap=' num2str(imag(sqrt(eps2))) 'abs, +=r o=t (TE)'] } )
subplot(1,3,2), plot(theta1g,angle(rs),'-+',theta1g,angle(ts),'-o'),title(['angle,  +=r o=t (TE)'])
subplot(1,3,3), plot(theta1g,angle(ts-rs),'-+',theta1g,abs(ts-rs),'-o'),title(['t-r, + angle, o abs (TE)'])
figure(2)
subplot(1,3,1), plot(theta1g,abs(rp),'-+',theta1g,abs(tp),'-o'), title( { ['n=' num2str(real(sqrt(eps2))) ', kap=' num2str(imag(sqrt(eps2))) 'abs, +=r o=t (TM)'] } )
subplot(1,3,2), plot(theta1g,angle(rp),'-+',theta1g,angle(tp),'-o'),title(['angle, +=r o=t (TM)'])
subplot(1,3,3), plot(theta1g,angle(tp-rp),'-+',theta1g,abs(tp-rp),'-o'), title(['t-r, + angle, o abs (TM)'])
figure(3)
subplot(1,3,1), polar(angle(rs),abs(rs)),title( { ['n=' num2str(real(sqrt(eps2))) ', kap=' num2str(imag(sqrt(eps2))) 'r (TE, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'] } )
subplot(1,3,2), polar(angle(ts),abs(ts)),title(['t (TE, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'])
subplot(1,3,3), compass(ts-rs), title(['t-r (TE, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'])
figure(4)
subplot(1,3,1), polar(angle(rp),abs(rp)), hold on, title({ ['n=' num2str(real(sqrt(eps2))) ', kap=' num2str(imag(sqrt(eps2))) 'r (TM, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'] } )   
subplot(1,3,2), polar(angle(tp),abs(tp)), hold on,
title(['t (TM, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'])
subplot(1,3,3), compass(tp-rp), hold on,title(['t-r (TM, th= ' num2str(theta1g(1)) ', ' num2str(theta1g(end)) ')'])
