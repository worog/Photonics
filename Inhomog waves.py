# -*- coding: utf-8 -*-
"""
Created on Wed Sep 28 15:20:12 2016

@author: cube
"""

# calc_a_k_kx.py
from pylab import *

w=1e15; c=3e8; k0=w/c;
n2=1.5; kap2=0.001;
kx=linspace(0,3*k0,200)
Q=k0**2*n2*kap2; P=k0**2*(n2**2-kap2**2); R=P-kx**2;
k2z2=R/2+sqrt(R**2+4*Q**2)/2; k2z=sqrt(k2z2); k2=sqrt(kx**2+k2z**2);
fi=arccos(k2z/k2)
a2=sqrt(kx**2+k2z2-P)
fig, ax1 = plt.subplots()
ax1.plot(kx,a2,'--',label='$a_2$')
ax1.plot(kx,k2z,'-.',label='$k_2|_z$')
ax1.plot(kx,k2,label='$k_2$')
ax1.legend(loc=0,fontsize=16)
ax1.set_xlabel('$kx (m-1)$',fontsize=16)
ax1.set_ylabel('$k_2, k_2|_z, a_2 (m-1)$',fontsize=16)
ax2 = ax1.twinx()
ax2.plot(kx,fi*180/pi,'k:')
ax2.set_ylabel('$fi (deg)$',fontsize=16)