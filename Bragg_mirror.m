clear all
close all
mats = ['T''M''M''T''M''T']
grs  = [100 100 0 00 0 000] 
nlamb=11;
x=linspace(600,700,nlamb);
for ix=1:nlamb
[R(ix) T(ix)]=calcs_RT(mats,grs,x(ix));
%  [R(ix) T(ix)]=calcs_RT_exam_set(mats,grs,x(ix));
end
figure
subplot(1,3,1), plot(x,R)
subplot(1,3,2), plot(x,T)
subplot(1,3,3), plot(x,R,x,T,x,R+T,'o')

[x' R' T']