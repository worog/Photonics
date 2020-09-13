% uk�ad r�wna� r�niczkowych
sigma = 10;
r = 28;
b = 8/3;
dy = @(t,y)[sigma*(y(2)-y(1));
            -y(1)*y(3)+r*y(1)-y(2);
            y(1)*y(2)-b*y(3)];
% rozwi�zanie uk�adu        
[t,y] = ode45(dy,[0 100],[0 0.5 1]);
% rysowanie wyniku
comet3(y(:,1),y(:,2),y(:,3))