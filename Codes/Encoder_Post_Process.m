%% Post-process code for incremental rotary encoder

%Description: This code enables user to convert their A and B square waves
%into position data. 

% INPUT : A and B square wave signals

% OUTPUT : Angle in degree or radian

clear
clc
addpath('D:\Research Stuff\Choatic Pendulum Apparatus\Data\CP_Experiment_Data')
load('CP_12v_b1_a2_photogate3_30sec_500000Hz_v1')
%% set  a threshold for voltage value and convert analog signal to digital signal
threshold = 4 ;
CPR=10000;

for k=1:2
for i=1:length(t)
    if d(i,k)<4
        d_signal(i,k) = 0;
    else
        d_signal(i,k) = 1;
    end   
end
end

%% count edges

%initial state for a signal
a_Last_state = d_signal(1,2);
counter=0;
for i=1:length(t)
    a_State = d_signal(i,2);
    b_State = d_signal(i,1);
    
    if (a_State ~= a_Last_state)
       if (b_State ~= a_State)
           counter = counter +1;
       else
           counter = counter -1;
       end
    end
    a_Last_state = a_State;

% You can uncomment the following three lines to have resetting for the
% angle data in every full rotation.

%     if (mod(counter,2*CPR) == 0)
%         counter = 0;
%     end
 
    count(i) = counter;
    degree(i) = (count(i)/(2*CPR))*360;
    rad(i) = degree(i)*pi/180;
end
plot(t, rad)
% save('D:\Research Stuff\Choatic Pendulum Apparatus\Data\CP_Experiment_Data\CP_12v_b1_a2_photogate3_30sec_500000Hz_v1_Converted_toRad','rad','t')