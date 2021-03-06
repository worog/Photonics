% Digital Holography
clear all

d=12000 %distance between images in microns
lambda = 0.633; % WaveLength in microns
pixelS = 5;    % Sampling distance in microns

%Read the first image to be propagated
[filename, pathname] = ...
 uigetfile({'*.*';'*.bmp';'*.tif'},'Select the image');
 file1 = fullfile(pathname, filename);
img = imread(file1);
[N, M]  = size(img)
N2      = 2*N;
Nm      = N/2;
imagen = ones(N2,N2);
imagen(Nm:Nm+N-1, Nm:Nm+N-1) = img;


%Read the second image to be propagated
[filename, pathname] = ...
uigetfile({'*.*';'*.bmp';'*.tif'},'Select the image');
file1 = fullfile(pathname, filename);
img = imread(file1);
imagen2 = ones(N2,N2);
imagen2(Nm:Nm+N-1, Nm:Nm+N-1) = img;


figure(1) 
subplot(1,2,1)
imagesc(imagen); % Show the image 1
colormap(gray)
title('Loaded image letras1')
axis equal tight
subplot(1,2,2)
imagesc(imagen2); % Show the image 2
colormap(gray)
title('Loaded image letras2')
axis equal tight

L = N2*pixelS;


 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 %%%%%%%%%%%%%%%%%     
 %%%%%%%%%%%%%%%%%           1. Propagation              %%%%%%%%%%%%%%%%%%%

%propagation of first image
imagen1=Propagation(imagen,L,lambda,d);

%interference of two images
imagen3=imagen2.*imagen1;

%propagation of interfeered pattern
imagen4=Propagation(imagen3,L,lambda,d);

figure(2)
    subplot(1,2,1)
    imagesc(abs(imagen3)); 
    colormap(gray)
     title('image "letras2" and propagated by 12000 \mumeters image "letras1" ')
    axis equal tight
     subplot(1,2,2)
    imagesc(abs(imagen4)); 
    colormap(gray)
    title('image "letras2" propagated by 12000 \mumeters and propagated by 24000 \mumeters image "letras1" ')
    axis equal tight
 
    
%amplitude calculation  of phase shifted images 
A=max(max(abs(imagen4)));
phi=[0 pi()/2 pi() 3*pi()/2];       % phase shifts 0, pi/2, pi, 3/2 pi

F1=A*exp(1i*phi(1,1));
F2=A*exp(1i*phi(1,2));
F3=A*exp(1i*phi(1,3));
F4=A*exp(1i*phi(1,4));
WE1=(abs(imagen4+F1)).^2;
WE2=(abs(imagen4+F2)).^2;
WE3=(abs(imagen4+F3)).^2;
WE4=(abs(imagen4+F4)).^2;

 figure(3) 
      subplot(2,2,1)
      imagesc(WE1); 
      colormap(gray)
      title('Propagated images of letras1 and letras2 with phase shift 0')
      axis equal tight
      subplot(2,2,2)
      imagesc(WE2); 
      colormap(gray)
      title('Propagated images of letras1 and letras2 with phase shift \pi /2')
      axis equal tight
      subplot(2,2,3)
      imagesc(WE3); 
      colormap(gray)
       title('Propagated images of letras1 and letras2 with phase shift \pi')
      axis equal tight
      subplot(2,2,4)      
      imagesc(WE4); 
      colormap(gray)
      title('Propagated images of letras1 and letras2 with phase shift 3/2 \pi')
      axis equal tight
  
      
%introducing Gaussian white noise in N2x N2 matrix
Noise=wgn(N2,N2,0.1);%white gaussian noise

WE11=WE1+Noise;
WE22=WE2+Noise;
WE33=WE3+Noise;
WE44=WE4+Noise;

% Signal with noise introduced
figure(4) 
      subplot(2,2,1)
      imagesc(real(WE11)); 
      colormap(gray)
      title(['phase 0  with noise']);
      axis equal tight
      subplot(2,2,2)
      imagesc(abs(WE22));
      colormap(gray)
      title(['phase \pi /2  with noise']);
      axis equal tight
      subplot(2,2,3)
      imagesc(abs(WE33)); 
      colormap(gray)
      title(['phase \pi  with noise']);
      axis equal tight
      subplot(2,2,4)
      imagesc(abs(WE44)); 
      colormap(gray)
      title(['phase  3/2 \pi with noise']);
      axis equal tight
      
      
      
 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
 %%%%%%%%%%%%%%%%%     
 %%%%%%%%%%%%%%%%%          2. Reconstruction             %%%%%%%%%%%%%%%%%%

% Calculation of phase and absolute value of front wave

Phase_clear=atan2(abs(WE2-WE4),abs(WE1-WE3));%clear signal
Phase_noise=atan2(abs(WE22-WE44),abs(WE11-WE33));%noised signal

% introducing Phase to signal 

y_clear=sqrt(abs(WE1)).*exp(1i*Phase_clear); %clear signal
y_noise=sqrt(abs(WE11)).*exp(1i*Phase_noise); %noised signal


for z=0:(-2*d/50):-100*d/50
    
    
      Y_clear= Propagation(y_clear,L,lambda,z);
      Y_noise= Propagation(y_noise,L,lambda,z);
   
      figure(5) 
            subplot(1,2,1)
            imagesc(abs(Y_clear)); 
            colormap(gray)
            title(['amplitude backpropagated by' num2str(z) '\mumeters.']);
            axis equal tight
            subplot(1,2,2)
            imagesc(abs(Y_noise)); 
            colormap(gray)
            title(['noised amplitude backpropagated by' num2str(z) '\mumeters.']);
            axis equal tight

      
      % stops propagation at z=-d  and waits for user reaction
      if z == -d
         
          %acustic signal generator 
          amp=10 ;
          fs=1000  ;
          duration=1;
          freq=100;
          values=0:1/fs:duration;
          a=amp*sin(2*pi* freq*values);
          sound(a)
          
          fprintf(1,'Press any button to continue');  
          
          waitforbuttonpress 
      
      else
          continue
      end
   
      
      pause(0.1)
end
% 
% 



