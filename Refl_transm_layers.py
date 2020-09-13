# -*- coding: utf-8 -*-
"""
Created on Sun Oct  9 17:24:53 2016
Reflectance and transmission of multilayer mirror
@author: cube
"""

# -*- coding: utf-8 -*-
#pract_multicapes
from pylab import *




def n_Ti(lamb):
    return sqrt(1+3.4*lamb**2/(lamb**2-25000))# refractive index for titanium
def n_Mg(lamb):
    return sqrt(1+0.8*lamb**2/(lamb**2-1500))#refractive index for magnesium
def n_BK(lamb): #refractive index for given  lambda and material  
    return sqrt(1+1.315*lamb**2/(lamb**2-950))
def matr_lam(lamb,n,d):
    af=2*pi*n*d/lamb # matrix 2x2 for each layer 
    return [[cos(af), 1j/n*sin(af)], [1j*n*sin(af), cos(af)]]
def calcs_RT(mats,grs,lamb): #refl and transmission
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
    
mats = ['T','M','T','M','T','M','T'] #materials
grs = array([89,45,110, 1, 10, 1, 1]) #thickness 
nlamb=31 # number of lambda 
x=linspace(400,700,nlamb) #lambda for given refractive indexes in functions n_Ti, n_Mg
resR=[]; resT=[]

for ix, item in enumerate(x):
    R=calcs_RT(mats,grs,x[ix])[0]
    T=calcs_RT(mats,grs,x[ix])[1]
    resR.append(R)
    resT.append(T)
    
figure()
subplot(1,3,1), plot(x,resR)
subplot(1,3,2), plot(x,resT)
subplot(1,3,3), plot(x,resR,'r',x,resT,'b',x,resR+resT,'o')
figure(); plot(x,resR,x,resT,x,resR+resT,'.')