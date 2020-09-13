function M = matr_lam(lamb,n,d)
    af=2*pi*n*d/lamb;
    M=[cos(af) 1i/n*sin(af); 1i*n*sin(af) cos(af)];
end 