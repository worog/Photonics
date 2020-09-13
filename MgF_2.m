function n= MgF_2(lambda)
lambda = lambda.*1000;
n= sqrt(1+(0.9.*lambda.^2)./(lambda.^2-1500));
end