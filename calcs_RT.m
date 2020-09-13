function [R T] = calcs_RT(mats, grs, lamb)
    M=eye(2);
    for im=1:length(mats)
        switch mats(im)
            case 'M'
            vn=n_Mg(lamb);
            L=matr_lam(lamb,vn,grs(im));
            case 'T'
            vn=n_Ti(lamb);
            L=matr_lam(lamb,vn,grs(im));
        end
        M=M*L;
    end
    ns=n_BK(lamb);
    vect_res = M*[1; ns];
    B=vect_res(1); C=vect_res(2);
    Ri=(B-C)/(B+C);
    R=abs(Ri)^2;
    T=4*ns/abs(B+C)^2;
end