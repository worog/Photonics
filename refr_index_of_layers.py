# -*- coding: utf-8 -*-
"""
Created on Wed Oct  5 15:24:04 2016
refractive index of setup of materials
@author: Wojciech Rogala
"""

# -*- coding: utf-8 -*-
#pract_multicapes
from pylab import *
def n_Ti(lamb):
  return sqrt(1+3.4*lamb**2/(lamb**2-25000))
def n_Mg(lamb):
  return sqrt(1+0.8*lamb**2/(lamb**2-1500))
def n_BK(lamb):
  return sqrt(1+1.315*lamb**2/(lamb**2-950))
def matr_lam(lamb,n,d):
  af=2*pi*n*d/lamb
  return [[cos(af), 1j/n*sin(af)], [1j*n*sin(af), cos(af)]]
def calcs_RT(mats,grs,lamb):
    M=eye(2)
    for im, item in enumerate(mats):
        if mats[im] == 'M':
            vn=n_Mg(lamb)
            L=matr_lam(lamb,vn,grs[im])
        elif mats[im] == 'T':
            vn=n_Ti(lamb)
            L=matr_lam(lamb,vn,grs[im])
        else:
            print("error d estructura")
    M=dot(M,L)
    ns=n_BK(lamb)
    vcol=array([[1],[ns]])
    vect_res = dot(M,vcol)
    B=vect_res[0]; C=vect_res[1]
    Ri=(B-C)/(B+C)
    R=abs(Ri)**2
    T=4*ns/abs(B+C)**2
    return R, T
  
if __name__ == "__main__":
    mats = ['M','M','T','M','T']
    grs = array([110, 0, 00, 0, 000])
    nlamb=31 # discretisation of wavelength spectrum
    x=linspace(400,700,nlamb) # Initialize wavelength range between 400 and 700 $\mu m$
    resR=empty(nlamb); resT=empty(nlamb) 
    for ix, item in enumerate(x):
        resR[ix], resT[ix]=calcs_RT(mats,grs,x[ix])
        figure()
        subplot(1,3,1), plot(x,resR), xlabel("Wavelength [$\mu m$]")
        subplot(1,3,2), plot(x,resT), xlabel("Wavelength [$\mu m$]")
        subplot(1,3,3), plot(x,resR,x,resT,x,resR+resT,'o'), xlabel("Wavelength [$\mu m$]")
        figure(); plot(x,resR,x,resT,x,resR+resT,'.'), xlabel("Wavelength [$\mu m$]")
