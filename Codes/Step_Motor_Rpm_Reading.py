"""
Description: This code takes the saved photoelectric sensor data and computes
the rpm for step motor.

Required packages or codes: TDA-for-true-step-detection-in-PWC-signals (https://gitlab.msu.edu/TSAwithTDA/TDA-for-true-step-detection-in-PWC-signals)

"""
import pandas as pd
import sys,os
import math
import numpy as np
import matplotlib.pyplot as plt
import scipy.io as sio

#%% add paths of the data and the code used in determining the rpm
folderToLoad = os.path.join('D:'+os.path.sep,
                                    'Research Stuff',
                                    'Choatic Pendulum Apparatus',
                                    'Data',
                                    'CP_Experiment_Data',
                                           )
sys.path.insert(0,folderToLoad)

folderToLoad2 = os.path.join('D:'+os.path.sep,
                                    'Research Stuff',
                                    'Laser Tachometer',
                                    'TDA-for-true-step-detection-in-PWC-signals-master',
                                    'code',
                                    )
sys.path.insert(0,folderToLoad2)

pathofdata = os.path.join(folderToLoad, "CP_12v_b1_a2_photogate3_30sec_500000Hz_v1.mat")

#%% load the data
dataset = sio.loadmat(pathofdata)
measurement = dataset['d']
time =  dataset['t']

#%% Remove nan values if any

photogate = measurement[:,2]
photogate = photogate[~np.isnan(photogate)]

#compute rpm value of the stepper motor
from processPulseData import persistence_rpm
rpm = persistence_rpm(time[2:-1],photogate[2:-1])/2 # the obstacle passes through the photogate 2 times in one rotation of step motor 
print('RPM of Step Motor:{}'.format(rpm))



