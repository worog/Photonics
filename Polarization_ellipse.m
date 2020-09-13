

clear all; close all

function [psi chi ;x] = param_pol_Photonics(vJ)
    if (vJ(1)==0. && vJ(2)==0.), 
    psi=0;
    chi=0; aux=Inf;
    elseif (vJ(1)==0.), 
    psi=-pi/2;
    chi=0; aux=Inf;
    else
    aux=vJ(2)/vJ(1);
    tan2psi=2*real(aux)/(1-(abs(aux))^2);
    psi1=atan(tan2psi)/2;  psi2=psi1+pi/2;   psi3=psi1-pi/2;
    if (real(aux)>0 && psi1>0 && psi1>=-pi/2 && psi1<pi/2) psi=psi1; 
    end
    if (real(aux)>0 && psi2>0 && psi2>=-pi/2 && psi2<pi/2) psi=psi2; 
    end
    if (real(aux)>0 && psi3>0 && psi3>=- pi/2 && psi3<pi/2) psi=psi3; 
    end
    if (real(aux)<0 && psi1<0 && psi1>=-pi/2 && psi1<pi/2) psi=psi1; 
    end
    if (real(aux)<0 && psi2<0 && psi2>=-pi/2 && psi2<pi/2)
    psi=psi2; 
    end
    if (real(aux)<0 && psi3<0 && psi3>=-pi/2 && psi3<pi/2) psi=psi3; 
    end
    if (real(aux)==0 && abs(aux)>1) psi=-pi/2; 
    end
    if (real(aux)==0 && abs(aux)<1) psi=0; 
    end
    if (real(aux)==0 && abs(aux)==1) psi=0; 
    end
    sin2chi=2*imag(aux)/(1+(abs(aux))^2);
    chi=asin(sin2chi)/2; 
    end
end




J=[ [1; 0] [-1; 0] [1i; 0] [-1i; 0] [1; 1] [1; -1] [1; 1i] [1; -1i] [0; -1i] [0; 1i] ];
% J=[[1; .9] [.9; 1] [1; -.9] [-1i; .9] [.8; 1i] [.1; -1] [.1; 1i] [-.1; 1i] [1i; -.1] [.5; 1i]];
% J=[[.1-1i; .9] [.1+1i; .9] [-.1-1i; .9] [.8*1i; -.1*1i] [1.1*1i; 1i] ...
%     [1i; .1] [.1; 1i] [-.1; 1i] [1i; -.1] [.8; -.1*1i] ];
for i=1:length(J)
[psi, chi, aux] = param_pol_Photonics(J(:,i)); 
subplot(2,5,i), pinta(J(:,i))
title( { ['Jx=' num2str(J(1,i)) ', Jy=' num2str(J(2,i))] ['\psi=' num2str(psi*180/pi) ', \chi=' num2str(chi*180/pi)]  ['J_y/J_x=' num2str(aux) ]}) 
end
