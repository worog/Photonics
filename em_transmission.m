%function takes refrcation indexes of layers and calculates kx, ky,
%incident angle 'fi', and absorbtion coefficient 'a' checking on
%observation of evanescent waves


w=1e15; c=3e8;  k0=w/c;   
n=[1.6,1.45,1.3,1.15,1];
size =length(n)
k=zeros(1,size)
kx=zeros(1,size)

kz=zeros(1,size)
a=zeros(1,size)
kap=zeros(1,size)
fi_rad=zeros(1,size)
h=zeros(1,size)
fi=50
fi_rad(1,1)=fi*pi/180

for i=1:(size-1)
        h(1,i)=sin(fi_rad(1,i))*n(i)/n(i+1)
        kx(1,i)=k0*n(1,i)*sin(fi_rad(1,i))
    if h(1,i)>=1
        Q=k0.^2.*n(1,i+1).*kap(1,i+1); 
        P=k0.^2.*(n(1,i+1).^2-kap(1,i+1).^2);
        R=P-kx(1,i).^2; 
        k2z2=R./2+sqrt(R.^2+4.*Q.^2)/2;
        kz(i+1)=sqrt(k2z2);  
        k(i+1)=sqrt(kx(1,i).^2+kz(1,i+1).^2);
        fi_rad(i+1)=acos(kz(i+1)./k(i+1));
        kx(i+1)=k0*n(1,i)*sin(fi_rad(1,i+1))
        a(i+1)=sqrt(kx(i+1).^2+kz(i+1)-P)
    else
        fi_rad(1,i+1)=asin(sin(fi_rad(1,i))*n(i)/n(i+1))
    end
    
end

fi=fi_rad.*180./pi
