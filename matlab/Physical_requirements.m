clear, clc

duration = [0, 11, 15, 23, 28, 49, 55, 61, 85, 96, 117, 123, 134, 143, 155, 163, 178, 188, 195, 206, 210, 218, 223, 244, 250, 256, 280, 291, 312, 318, 329, 338, 350, 358, 373, 383, 390, 401, 405, 413, 418, 439, 445, 451, 475, 486, 507, 513, 524, 533, 545, 553, 568, 578, 585, 596, 600, 608, 613, 634, 640, 646, 670, 681, 702, 708, 719, 728, 740, 748, 763, 773, 780, 800, 806, 817, 827, 841, 891, 899, 968, 981, 1031, 1066, 1096, 1116, 1126, 1142, 1150, 1160, 1180];
speeds = [0 0 15 15 0 0 15 32 32 0 0 15 35 50 50 35 35 0 0 0 15 15 0 0 15 32 32 0 0 15 35 50 50 35 35 0 0 0 15 15 0 0 15 32 32 0 0 15 35 50 50 35 35 0 0 0 15 15 0 0 15 32 32 0 0 15 35 50 50 35 35 0 0 0 15 35 50 70 70 50 50 70 70 100 100 120 120 80 50 0 0];

avgSpeed = mean(speeds, "all");

%Constants
distance = 300;
cd = 0.3; af = 2; p = 1.2;
toMps = 0.2778;
toRpm = 9.5492968;
cycleTime = 1200/3600;
totalTime = cycleTime * distance / (avgSpeed * cycleTime);
r = 0.4/2;
m = 1478;
slope = 3/100;
g = 9.80665;
wheelRatio = 3.3;

%Calculating Variables
aeroFr = 1/2*p*af*cd*(avgSpeed * toMps)^2;
wheelFr = 70*4;
friction = aeroFr + wheelFr;
massForce = m*g*slope;
totalDragForce = friction+massForce;
pwr = totalDragForce * avgSpeed * toMps;
cap = pwr * totalTime;
fullCap = cap/0.7;
w = (avgSpeed * toMps / r) * wheelRatio;
n = w * toRpm;
t = pwr / w;

%Calculating Variables Seperate
aeroFrArray = 1/2*p*af*cd*(speeds * toMps).^2;
frictionArray = aeroFrArray+wheelFr;
totalDragForceArray = frictionArray+massForce;
force_motor = diff(speeds)./diff(duration) * m;
torque_motor = (force_motor-totalDragForceArray(2:end)) * r / wheelRatio;
pwrArray = force_motor.*speeds(2:end)*toMps;
wArray = (speeds*toMps/r)*wheelRatio;
nArray = wArray*toRpm;

%Drawing Plots
subplot(2,2,1)
plot(duration, speeds, 'r')
title('SPEED')
xlabel('Time (s)')
ylabel('Speed (km/h)')
grid on

subplot(2,2,2)
plot(duration(2:end), pwrArray, 'g')
title('POWER')
xlabel('Time (s)')
ylabel('Power(Watt)')
grid on

subplot(2,2,3)
plot(duration(2:end), torque_motor, 'b')
title('TORQUE')
xlabel('Time (s)')
ylabel('Torque (Nm)')
grid on

subplot(2,2,4)
plot(duration, nArray, 'm')
title('ROTATIONAL SPEED')
xlabel('Time (s)')
ylabel('Rotational Speed (RPM)')
grid on