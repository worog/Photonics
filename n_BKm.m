
function n = n_BK(lamb)
    num=1.315*lamb^2;
    den=lamb^2-950;
    n=sqrt(1+num/den);
end