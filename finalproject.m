% Design and analysis script for ME 4550 final design project
%
% Matthew Bonanni, Nicolas Iacovelli, Adrian Kombe, Ryan Loehr, Becca Sung

%% Parameters and Characteristics

% Gear diameters

d_A = 24;
d_C = 10;

% Load parameters

P_Angle = 20;
P_A = 600;

% Length parameters

OA = 20;
AB = 16;
BC = 10;

% Strength characteristics

n = 3;
Sy = 71000;
Sut = 85000;

%% Force balance

% Breaking P_A into components

A_y = P_A * cosd(P_Angle);
A_z = -P_A * sind(P_Angle);

% The torque generated by P_A

T = A_y * (d_A/2);

% Calculate P_C from torque balance

C_z = -T / (d_C / 2);
P_C = -C_z / cosd(P_Angle);
C_y = P_C * sind(P_Angle);

% Z Moment balance around B

O_y = -(A_y * AB + C_y * BC) / (OA + AB);
B_y = -O_y - A_y + C_y;

% Y Moment balance around B

O_z = -(A_z * AB + C_z * BC) / (OA + AB);
B_z = O_z - A_z + C_z;

% Moments at A

M_Ay = O_z * OA;
M_Az = -O_y * OA;
M_A_tot = sqrt((M_Ay^2) + (M_Az)^2);

% Moments at B

M_By = -C_z * BC;
M_Bz = C_y * BC;
M_B_tot = sqrt((M_By^2)+(M_Bz^2));

M_a = max(M_A_tot, M_B_tot);

% Critical point determined to be at B, where M_tot is largest

syms d   %symbolic shaft diameter

sigma_a = (32* M_a / (pi*d));
sigma_m = 0;
tao_a = 0;
tao_m = (16* M_a / (pi*d));

Kf = 1;
Kfs = 1;

% Fatigue failure conditions
Se_prime = Sut * .5;
ka_a = 1.34;
ka_b = -.265;
ka = (ka_a)*(Sut^ka_b);
kb = .85;   %guess for fist iteration
kc = 1;     %1 for combined loading

Se = (ka * kb * kc * Se_prime);