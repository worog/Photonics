# -*- coding: utf-8 -*-
"""
Geometric optics HOMEWORK

"""
import matplotlib.pyplot as plt
import scipy as sci
import numpy as np

###############################################

"""

function for single diopter where input parameters are:
l- position of the object 'B',
R- radius of diopter
n1-refraction index of meduim outside the diopter,
n2-refraction index of diopter.
Output parameters are:
L- picture position of object 'B',
M- magnification of object 'B'.
"""

def diop_man(l,R,n1,n2):
    L=n2*l*R/(R*n1+l*(n2-n1)) #position of picture   
    M=n1*L/(n2*l) # magnification 
    return L, M

"""function for sphere simplified as a thin lense where input parameters are:
n1-refraction index of surrounding meduim,
n2-refraction index of lense
R1-radius of left surface of lense,
R2-radius of right lense surface,
l- position of the object 'A'.
and providing information about:
f- lenses power f,
L- picture position of object 'A',
M- magnification of object 'A'.
"""

def sphere(n1,n2,R1,R2,l):
    f=n1*R1*R2/((R2-R1)*(n2-n1))
    L=l*f/(f+l)
    M=L/l
    return f,L,M
    
##############################################################

l=10                       #    Position of example object in milimeters
ln=np.linspace(-1,-150,100)#    Position of object in milimetersm
R=40                       #    Radius of sphere in mm
n2=1.33                    #    Refraction index of sphere
n1=1                       #    Refraction index of air
R1=R                       #    Radius of first surface (from left)
R2=-R                      #    Radius of second surface, minus sign 
                           #    according to geometrical optics rules : 
                           #    central point of diopter is on the left of the surface.

#Calculations for example object
print("diopter-picture position:", diop_man(l,R,n1,n2)[0], ", magnification:", diop_man(l,R,n1,n2)[1])
print("spherical lense-power:",sphere(n1,n2,R1,R2,l)[0], ", picture position:",sphere(n1,n2,R1,R2,l)[1],", magnification:", sphere(n1,n2,R1,R2,l)[2])

#excersize 2, 3 and 4
lense=sphere(n1,n2,R1,R2,ln)
D=diop_man(ln,R,n1,n2)
plt.figure(1)
plt.subplot(2,2,1)
plt.plot(ln,D[0],'r.-')
plt.title('excersize 2 - position of image created by one diopter')
plt.ylabel('image position [cm]')
plt.xlabel('object position [cm]')
plt.grid()

plt.subplot(2,2,2)
plt.plot(ln,lense[1],'g.-')
plt.title('excersize 3 - position of image created by two diopters')
plt.ylabel('image position [cm]')
plt.xlabel('object position [cm]')
plt.grid()

plt.subplot(2,2,3)
plt.plot(ln,lense[2],'b.-')
plt.title('excersize 4 - magnification of object by two diopters')
plt.ylabel('Image magnification')
plt.xlabel('Object position [cm]')
plt.grid()
plt.show()







