% Design and analysis script for ME 4550 final design project
%
% Matthew Bonanni, Nicolas Iacovelli, Adrian Kombe, Ryan Loehr, Becca Sung

d_A = 24;
d_C = 10;
n = 3;
Sy = 71000;
Sut = 85000;
P_Angle = 20;
P_A = 600;
OA = 20;
AB = 16;
BC = 10;

% Breaking P_A into components

A_y = P_A * cosd(P_Angle);
A_z = -P_A * sind(P_Angle);

% The torque generated by P_A

T = A_y * (d_A/2);

% Calculate P_C from torque balance

C_x = -T / (d_C / 2);
P_C = C_x / cosd(P_Angle);
C_y = P_C * sind(P_Angle);

% Z Moment balance around B

O_y;

B_y = -1 * ((OA * A_y) - (C_y * (OA + AB + BC))/(OA + AB));
O_y = -1 * (A_y - C_y + B_y);
B_z = ((-C_z * (OA + AB + BC)) + (A_z * OA)) / (OA + AB);
O_z = B_z - A_z + C_z;
M_ay = O_y * OA;
M_az = O_z * OA;
M_a_tot = sqrt((M_ay^2) + (M_az)^2);
M_by = C_y * BC;
M_bz = A_z * BC;
M_b_tot = sqrt((M_by^2)+(M_bz^2));

Ma = max(M_a_tot, M_b_tot);

% Critical point determined to be at B, where M_tot is largest

syms d   %symbolic shaft diameter

sigma_a = (32* Ma / (pi*d));
sigma_m = 0;
tao_a = 0;
tao_m = (16* Ma / (pi*d));

Kf = 1;
Kfs = 1;

% Fatigue failure conditions
Se_prime = Sut * .5;
ka_a = 1.34;
ka_b = -.265;
ka = (ka_a)*(Sut^ka_b);
kb = .85;   %guess for fist iteration
kc = 1;     %1 for combined loading

Se = (ka * kb * kc * Se_prime)
