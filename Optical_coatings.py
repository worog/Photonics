     """
    Created on Tue Oct 18 04:52:02 2016
    Homework 3 HR and AR coating 
    @author: cube
    """
    
    import scipy as sci 
    import matplotlib.pyplot as plt
    import numpy as np
     
     #refractive indexes for used materials, calculationsare done  regarding um 
    def nTi(lam):
        nTiO2=np.sqrt(5.913+0.2441/(lam**2 -0.0803))
        return nTiO2
        
    def nMg(lam):
        A0=0.9
        A1=0.0015
        nMgF2=np.sqrt(1+A0*lam**2/(lam**2-A1))
        return nMgF2
        
    def nBK7(lam):
        B=1.5046
        C=0.0042
        nBK7=B+C/lam**2
        return nBK7
        
    def broad(nTi,nMg):
        Dlam=0.7-0.4
        lam0=Dlam*np.pi/(4*np.arcsin((nTi-nMg)/(nTi+nMg)))
        return lam0, Dlam
    
    def HRcoat(N,n0,nMg,nTi,nBK7):
        R=((n0*nTi**(2*N)-nBK7*nMg**(2*N))/(n0*nTi**(2*N)+nBK7*nMg**(2*N)))
        return R
        
    def thick(n,lam0):
        d=lam0/(4*n)
        return d
    
        
    def matr_lam(lam,n,d):
        a=2*np.pi*n*d/lam             # matrix 2x2 for each layer 
        return [[np.cos(a), 1j/n*np.sin(a)], [1j*n*np.sin(a), np.cos(a)]]
        
    def Refl_Trans(materials,d,lam): #refl and transmission
        M=np.eye(2)
        for im, item in enumerate(materials):
            if materials[im] == 'Mg':
                vn=nMg(lam)
                D=d[1]
                L=matr_lam(lam,vn,D)
            elif materials[im] == 'Ti':
                vn=nTi(lam)
                D=d[0]
                L=matr_lam(lam,vn,D)
            M=np.dot(M,L)
        ns=refractive(lam)[0]
        vcol=np.array([[1],[ns]])
        vect_res = np.dot(M,vcol)
        B=vect_res[0]; C=vect_res[1]
        Ri=(B-C)/(B+C) 
        R=np.abs(Ri)**2
        T=4*ns/np.abs(B+C)**2
        return R, T
    
    materials = ['Ti','Mg','Ti','Mg','Ti'] #materials
    n0=1
    lam=np.linspace(0.1,1,1000)
    lam0=0.55
    d=[thick(nTi(lam),lam0),thick(nMg(lam),lam0)]
    
    #matthick = np.array([110, 10, 10, 10, 100]) #setting thickness of materials correspondenting to  'materials' vector
    # # wavelength in micrometers
    resR=[]; resT=[]
    
    
    for ix, item in enumerate(lam):
        R=Refl_Trans(materials,d,lam[ix])[0]
        T=Refl_Trans(materials,d,lam[ix])[1]
        resR.append(R)
        resT.append(T)
    
    n=[nBK7(lam),nTi(lam),nMg(lam)]
    #R=HRcoat(1,n0,n[2],n[1],n[0])
    
    plt.subplot(1,3,1)
    plt.plot(lam,n[0],'r-',lam,n[1],'b-',lam,n[2],'g-')    
    plt.axis([0.2, 0.9, 0, 8])
    plt.ylabel('refractive index')
    plt.xlabel('wavelength [$\mu m$]')
    plt.legend( ('Refractive index of $BK7$','Refractive index of $TiO_2$', 'Refractive index of $MgF_2$'), loc='upper right')
    plt.grid()
    
    
    
    plt.subplot(1,3,2)
    plt.plot(lam,resR,'r-')   
    plt.axis([0.4, 0.7, 0, 1])
    plt.ylabel('reflection')
    plt.xlabel('wavelength [$\mu m$]')
    #plt.legend( ('Refractive index of $BK7$','Refractive index of $TiO_2$', 'Refractive index of $MgF_2$'), loc='upper right')
    plt.grid()
    #
    #plt.subplot(1,3,3)
    #plt.plot(lam,resT,'r-')   
    #plt.axis([0.4, 0.7, 0, 1])
    #plt.ylabel('transmission')
    #plt.xlabel('wavelength [$\mu m$]')
    ##plt.legend( ('Refractive index of $BK7$','Refractive index of $TiO_2$', 'Refractive index of $MgF_2$'), loc='upper right')
    #plt.grid()
    
    plt.show()
