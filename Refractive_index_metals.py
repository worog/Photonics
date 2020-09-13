# -*- coding: utf-8 -*-
"""
Created on Mon Oct 17 12:37:33 2016

@author: cube
"""

import scipy as sci 
import matplotlib.pyplot as plt
import numpy as np

def dielectric(lam,plasm,gamma):
    c=float(3*10**8)
    o=[]
    com=[]
    com1=[]
    Re=[]
    Im=[]
    E=[]
    for i in range(sci.size(lam)):
        o=(2*sci.pi*c/lam)        
        a=np.complex(o[i]**2,2*o[i]*gamma)
        com.append(a)
        
    #    com1.append(sci.complex128(o[i]**2,-2*o[i]*gamma))
       # E.append(1-com1*plasm**2/(com*com1)) 
        E.append(1-plasm**2/com[i])
        Re.append(sci.real(E[i]))
        Im.append(sci.imag(E[i]))
    return E, Re, Im

l1=sci.linspace(10*10**-6,1*10**-8,10000)
pl=1.332*10*16
gamma=1.13*10**14

a=dielectric(l1,pl,gamma)

plt.plot(l1,a[1],'r-',l1,a[2],'b-')
plt.xlabel("wavelength [$\mu m$]")
plt.ylabel("refractive index")
plt.show()
