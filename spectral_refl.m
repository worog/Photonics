function [R, T, En] = spectral_refl(incident_angle, wavelength, mu_1, n_1, kap_1,mu_2, n_2, kap_2 )
            % specctral_refl calculates reflection and transmission of
            % semiinfinite material
            % on refractive index of material and 
            %Calculation of 
            
            eps_1=abs(n_1+i.*kap_1).^2;
            k_1=(2.*pi./wavelength ).*sqrt(eps_1.*mu_1);
            k_p=k_1.*sin(incident_angle);   
            
            eps_2 = (n_2+i.*kap_2).^2
            k_2=(2.*pi./wavelength ).*sqrt(eps_2.*mu_2); 
            % same as kx, wavevector parallel to the interface
            
            kz_1=sqrt(k_1.^2-k_p.^2); 
            kz_2=sqrt(k_2.^2-k_p.^2);
            Rs=(mu_2 .*kz_1-mu_1.*kz_2)./(mu_2.*kz_1+mu_1.*kz_2);
            Rp=(eps_2.*kz_1-eps_1.*kz_2)./(eps_2.*kz_1+eps_1.*kz_2)
            Ts=2.*mu_2.*kz_1./(mu_2.*kz_1+mu_1.*kz_2);
            Tp=(2.*eps_2.*kz_1./(eps_2.*kz_1+eps_1.*kz_2)).*sqrt(mu_2.*eps_1./mu_1./eps_2);
            En =Tp+Rp
            R=0.5.*(abs(Rs).^2+abs(Rp).^2)
            T=0.5.*(abs(Ts).^2+abs(Tp).^2)
end