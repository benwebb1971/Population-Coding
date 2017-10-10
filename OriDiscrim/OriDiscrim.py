import scipy.io as sio
import time
from psychopy import *
import numpy as np

# GUI parameters
params = {'Observer': 'bsw', 'nReps': 10, 'nSteps': 9, 'RangeShift': 90, 'StepSize' : 1}
paramsDlg = gui.DlgFromDict(dictionary=params,title='Orientation Discrimination',fixed=[])


# *******Set up trial structure*********
# Number of trials
params['nTrials'] = params['nReps']*params['nSteps']

#Levels of Method of constant stimuli
maxDir= params['RangeShift']+(params['StepSize']*(params['nSteps']/2))
minDir= params['RangeShift']-(params['StepSize']*(params['nSteps']/2))
params['Levels'] = np.arange(minDir,  maxDir+params['StepSize'],  params['StepSize'])

if len(params['Levels']) !=params['nSteps']:
    params['Levels']=params['Levels'][0:params['nSteps']]    
    
# Empty arrays for appending trials, orientations and responses 
params['trials'] = np.zeros([params['nTrials']]) 
params['oris'] = np.zeros([params['nTrials']]) 
params['resp'] = np.zeros([params['nTrials']]) 

# nReps of constant stimuli levels 
params['oris'] = np.repeat(params['Levels'], params['nReps']) 
np.random.shuffle(params['oris'])  # Shuffle orientations
# **********************************

# Additional parameters 
params['date'] = time.strftime("%b_%d_%H%M_%S", time.localtime())
params['sf'] = 0.06
params['size'] = 200
params['eccentricity']=200


print len(params['Levels'])
# Create window to draw stimuli
DEBUG=True 
if DEBUG:
    winSize=(1024,768)
    Win = visual.Window(size=winSize, monitor='testMonitor',
    units='pix',bitsMode=None,
    allowGUI=True, winType='pyglet')	
else:
    winSize=(1024,768)
    Win = visual.Window(size=winSize, monitor='testMonitor',
    units='pix',bitsMode=None, allowGUI=False, winType='pyglet', fullscr=True)	

# set Gamma of the monitor
Win.setGamma([2.665, 2.665, 2.665])

# Generate fixation Cross
fixation1 = visual.GratingStim(Win,color=-1,sf=0,size=(2,20))
fixation2 = visual.GratingStim(Win,color=-1,sf=0,size=(20,2))

# Generate Gabor
gabor = visual.GratingStim(Win, units='pix', tex="sin",mask="gauss", texRes=256, size=params['size'], pos=[params['eccentricity'], 0], sf=params['sf'], ori = 0)

# Key error message
KeyError = visual.TextStim(Win,text="Key Error: Press 1 or 3",pos=(0, 0), color=[-1.0,-1,1],units='pix', ori=0, height = 50.0, font='Comic Sans MS' )

# Function for collecting responses (called below)
def checkCorrect(keys):
    for key in keys:		
        if key=='escape':
            Win.close()
            core.quit()
        elif key in ['3','num_3']:
            return 1
        elif key in  ['1','num_1']:
            return 0
        else: 
           KeyError.draw()
           Win.flip()
           event.waitKeys()

# Draw fixation cross and wait for key press
fixation1.draw()
fixation2.draw()
Win.flip()
event.waitKeys()

# Loop through trials
for trials in range(params['nTrials']):
    
    # Set Gabor orientation for next trial 
    gabor.setOri(params['oris'][trials]-90) 
    
     # draw fixation cross and Gabor
    for nFrames in range(10):
        fixation1.draw()
        fixation2.draw()
        gabor.draw()
        Win.flip()
    
        for thisKey in event.getKeys():
            if thisKey in ['q', 'escape']:
                Win.close()
                core.quit()   
                
    for nFrames in range(10):
        fixation1.draw()
        fixation2.draw()
        Win.flip()
        
        for thisKey in event.getKeys():
            if thisKey in ['q', 'escape']:
                Win.close()
                core.quit()           
   
    #if no response yet wait for one
    resp = None
    while resp is None:
        resp = checkCorrect(event.waitKeys())
        fixation1.draw()
        fixation2.draw()
        Win.flip()
        
    #record response
    params['trials'] = trials+1
    params['resp'][trials] = resp 
    
    for nFrames in range(10):
        fixation1.draw()
        fixation2.draw()
        Win.flip()
        
#trials finished 
Win.close()
sio.savemat(params['Observer']+'_'+'OriDiscrim'+'_'+params['date']+'.mat', params, oned_as='row')
