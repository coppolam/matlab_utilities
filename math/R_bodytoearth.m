function [ R ] = R_bodytoearth(roll,pitch,yaw)
%Rotation matrix from the body frame of reference (North-East-Down) to a fixed earth
%frame of reference

sr = sin(roll);
sp = sin(pitch);
sy = sin(yaw);

cr = cos(roll);
cp = cos(pitch);
cy = cos(yaw);

R11 = cp * cy;
R12 = cp * sy;
R13 = - sp;

R21 = sr * sp * cy - cr * sy;
R22 = sr * sp * sy + cr * cy;
R23 = sr * cp;

R31 = cr * sp * cy + sr * sy;
R32 = cr * sp * sy - sr * cy;
R33 = cr * cp;

R = [R11 R12 R13;
     R21 R22 R23;
     R31 R32 R33]; 

end