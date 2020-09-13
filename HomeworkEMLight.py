import scipy as sci
import numpy as np
import matplotlib.patches as mpatches
import matplotlib.pyplot as plt

#loading data for complex refractive indexes in relation to wavelength of light
#column 1 contains wavelengths data
#column 2 contains real part of refractive index 
#column 3 contains imaginary part of refractive index
Au=np.loadtxt("Au.txt", unpack=True)
Ag=np.loadtxt("Ag.txt", unpack=True)
Cr=np.loadtxt("Cr.txt", unpack=True)

n1=complex(1,0)#complex refractive index of air

def reflectance(n1,Mat):
    R=[]
    for i in range(len(Mat[1])):    
       a=Mat[1][i]
       b=Mat[2][i]
       n2=complex(a,b) #setting data from file as a complex number
       r=abs((n1-n2)/(n1+n2))**2# Fresnel formula for normal incidence with magnetic permeabolity =1
       R.append(r)
    return R


plt.plot(Au[0],reflectance(n1,Au),'r-',Ag[0],reflectance(n1,Ag),'b-',Cr[0],reflectance(n1,Cr),'g-')
plt.axis([0.4, 0.7, 0, 1])
plt.ylabel('Reflectance')
plt.xlabel('wavelength [$\mu m$]')
plt.legend( ('Spectral Reflectance of Au', 'Spectral Reflectance of Ag', 'Spectral Reflectance of Cr'), loc='lower right')
plt.grid()
plt.show()