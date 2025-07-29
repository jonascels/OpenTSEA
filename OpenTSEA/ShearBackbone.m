function [Vn, gst, Vu, gshf, Vf, gf] = ShearBackbone( ...
    fc, Ec, Es, fy, B, Ag, Asl, Asv, s, dw, d, Ls, N)

% Calculates the paramerters to calculate the shear backbone curve of a
% column according to the method set out by Sezen and Moehle 2004

Nu = fc*(Ag - Asl) + fy*Asl; % Axial load carrying capcity (ignoring effects like buckling, and considering only material strengths) (kN)
u = abs(N)/Nu; % Normalized axial load ratio
Eta = Es/Ec; % Modular ratio
ad = Ls/d; % Shear span to effective section depth ratio
rho_v = Asv/Ag; % Shear reinforcement ratio
k = 1.0; % Parameter depending on the curvature ductility demand: 1.0 assumes no strength degradation and displacement ductility less than 2
Theta = pi/4; % Shear angle - assumed to be 45 degrees

% Shear force: method set out by Sezen and Moehle 2004
Vc = 0.5*sqrt(fc)/ad * sqrt(1 + N/(0.5*sqrt(fc)*Ag)) * 0.8*Ag; % Concrete contribution
Vs = Asv*fy*d/s; % Steel contribution
Vn = k*Vc + Vs; % in this case k is only applied to concrete contribution as suggested by Mergos & Kappos 2012
Vu = Vn*1.001; 

GA = (Es*B*dw*rho_v*sin(Theta)^4*(1/tan(Theta)^2)) / (sin(Theta)^4 + Eta*rho_v);
gst = Vn/GA;

lambda1 = 1.0 - 2.5*min(0.40,u);
lambda2 = min(2.5,ad)^2.0;
omegak = Asv*fy/(B*s*abs(fc));
lambda3 = 0.31 + 17.8*min(omegak,0.08);
gshf = lambda1*lambda2*lambda3*gst;

Vf = Vn*0.3;
gf = gshf*1.01;
end