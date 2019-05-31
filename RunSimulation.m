%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           RunSimulation.m                               %
%                           ---------------                               %
% copyright            : (C) 2013 by Jesus Garrido                        %
% email                : jesus.garrido@unipv.it                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                                         %
%   This script launchs the simulations of the granular layer model that  %
%   are described in Figure 10 of the paper:                              %
%                                                                         % 
%   Garrido JA, Ros E and D’Angelo E (2013) Spike timing regulation on the %
%   millisecond scale by distributed synaptic plasticity at the cerebellum%
%   input stage: a simulation study. Front. Comput. Neurosci. 7:64.       %
%   doi: 10.3389/fncom.2013.00064                                         %
%                                                                         %
%   Before running this script you have to install EDLUT simulator and    %
%   include the bin folder in your system path. More information,         %
%   installation instructions and the simulator itself are available at   %
%   http://edlut.googlecode.com.                                          %
%                                                                         %
%   Remaining weight configurations in the paper can be run just modying  %
%   the weight values to those indicated in the specific figure. If you   %
%   have any question/comments/feedback or you need some help or other    %
%   script to carry out data analysis of other figures, please, send me a %
%   mail to jesus.garrido@unipv.it                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Paths and file name settings
SimulationOutputFolder = './Records/Figure10A/';
SimulationLogFolder = [SimulationOutputFolder 'Log/'];
SimulationTempFolder = [SimulationOutputFolder 'Temp/'];
Output_Prefix = [SimulationOutputFolder 'IncTransmission'];
Log_Prefix = [SimulationOutputFolder 'LogIncTransmission'];
Input_File = [SimulationTempFolder 'input.dat'];
Weight_Prefix = [SimulationTempFolder 'Weights'];
Network_File = './netGoCGoCTD.cfg';

% Simulation time step (in seconds)
Simulation_TS = 1e-4;

% Number of cells in each layer
MF_Init = 0;
MF_Number = 350;
GC_Init = 350;
GC_Number = 4500;
GO_Init = 4850;
GO_Number = 27;

%% If you want to simulate other weight configurations, just comment the following weight settings,
%% and uncomment the ones you want to run.
%% Increasing transmission weight configuration
MFGRAMPA_Weights = 0.87; %% Control
MFGRNMDA_Weights = 0.087; %% Control
MFGO_Weights = 0.5; %% LTD
GRGO_Weights = 1.5; %% LTD
GOGR_Weights = 0.75; %% LTD
GOGO_Weights = 3; %% LTP
SCGO_Weights = 1; %% LTP
GRSC_Weights = 0.3; %% Unchanged: Not under study in this work

% %% Filtering weight configuration
% MFGRAMPA_Weights = 0.609; %% LTD
% MFGRNMDA_Weights = 0.062; %% LTD
% MFGO_Weights = 2; %% LTP
% GRGO_Weights = 3; %% Not relevant: Control
% GOGR_Weights = 0.75; %% LTP
% GOGO_Weights = 1; %% Not relevant: Control
% SCGO_Weights = 0.25; %% Not relevant: Control
% GRSC_Weights = 0.3; %% Unchanged: Not under study in this work
% 
% %% Maximize time precision weight configuration
% MFGRAMPA_Weights = 1.131; %% LTP
% MFGRNMDA_Weights = 0.114; %% LTP
% MFGO_Weights = 2; %% LTP
% GRGO_Weights = 6; %% LTP
% GOGR_Weights = 3; %% LTP
% GOGO_Weights = 3; %% LTP
% SCGO_Weights = 1; %% LTP
% GRSC_Weights = 0.3; %% Unchanged: Not under study in this work
% 
% %% Maximize bursting weight configuration
% MFGRAMPA_Weights = 1.131; %% LTP
% MFGRNMDA_Weights = 0.114; %% LTP
% MFGO_Weights = 0.5; %% LTD
% GRGO_Weights = 1.5; %% LTD
% GOGR_Weights = 0.75; %% LTD
% GOGO_Weights = 3; %% LTP
% SCGO_Weights = 1; %% LTP
% GRSC_Weights = 0.3; %% Unchanged: Not under study in this work

% Simulation parameters: Simulate 1 3-spike burst
Simulation_Time = 0.3;
SpikeTrainTime = 0.100;
IntraBurstFrequency = 100;
InterBurstFrequency = 1/0.6;
SpikesPerBurst = 3;
NumberOfBursts = 1;
SpikeTrainStd = 0.001;
SpikeProbability = 0.7;

% Noise parameters: 5Hz white noise
Init_Noise_Time = 0;
Duration_Noise_Time = Simulation_Time;
Noise_Frequency = 5;

% Creating output folders
mkdir(SimulationOutputFolder);
mkdir(SimulationTempFolder);
mkdir(SimulationLogFolder);


% Initialize random numbers generator
rand('state', sum(100*clock));
randn('state',sum(100*clock));
seedRand = rand('state');
seedRandn = randn('state');
save('SavedSeed','seedRand','seedRandn');

% load('SavedSeed');
% rand('state',seedRand);
% randn('state',seedRandn);

time = clock;

% Generate the input activity according to the parameters.
fprintf(1,'Generating noise matrix. Frequency: %fHz\n',Noise_Frequency);
clear NoiseMatrix;
NoiseMatrix(:,:)=GenerateSaltPepper(MF_Init,MF_Number,Init_Noise_Time,Duration_Noise_Time,Noise_Frequency);
fprintf(1,'Generating spike bursts\n',Noise_Frequency);
GenerateInputFileBurst(Input_File, MF_Init, MF_Number, SpikeTrainTime, IntraBurstFrequency, SpikeProbability, SpikeTrainStd, SpikesPerBurst, InterBurstFrequency, NumberOfBursts, NoiseMatrix)


% Simulate all the weights combinations that has been included in the
% weight settings.
TotalIndex = 1;
TotalIterations = length(MFGO_Weights)*length(GRGO_Weights)*length(GOGR_Weights)*length(GOGO_Weights)*length(SCGO_Weights);
IND = 1:TotalIterations;
s = [length(MFGO_Weights),length(GRGO_Weights),length(GOGR_Weights),length(GOGO_Weights),length(SCGO_Weights)];
[iindex,jindex,kindex,lindex,mindex] = ind2sub(s,IND);

for i=1:TotalIterations,
   

    MFGO = MFGO_Weights(iindex(i));
    GRGO = GRGO_Weights(jindex(i));
    GOGR = GOGR_Weights(kindex(i));
    GOGO = GOGO_Weights(lindex(i));
    SCGO = SCGO_Weights(mindex(i));

    % Generate weight file
    Weight_File = [Weight_Prefix num2str(i) '.dat'];
    GenerateWeightsFileGOGO(Weight_File, MFGRAMPA_Weights, MFGRNMDA_Weights, MFGO, GOGR, SCGO, GRGO, GRSC_Weights, 0, 0, GOGO);
    
    Output_File = [Output_Prefix 'MFGO' num2str(MFGO) '_GCGO' num2str(GRGO) '_GOGC' num2str(GOGR) '_GOGO' num2str(GOGO) '_SCGO' num2str(SCGO) '.dat'];
    Log_File = [Log_Prefix 'MFGO' num2str(MFGO) '_GCGO' num2str(GRGO) '_GOGC' num2str(GOGR) '_GOGO' num2str(GOGO) '_SCGO' num2str(SCGO) '.dat'];
    
    %% Run EDLUT simulation from Matlab. EDLUTKernel bin file must be included in the system path.
    param = 'EDLUTKernel ';
    param = cat(2,param, '-time ',num2str(Simulation_Time),' ');
    param = cat(2,param, '-nf ',Network_File,' ');
    param = cat(2,param, '-wf ', Weight_File,' ');
    param = cat(2,param, '-if ', Input_File,' ');
    %param = cat(2,param, '-logp ', Log_File,' ');
    param = cat(2,param, '-of ', Output_File,' ');
    param = cat(2,param, '-ts ', num2str(Simulation_TS),' ');
    
    dos(param);
    
    % Show simulation raster plot
    ShowRasterPlot(Output_File, MF_Number, GC_Number, GO_Number, SpikeTrainTime-1/IntraBurstFrequency, SpikeTrainTime+3/IntraBurstFrequency);
    
end

fprintf(1,'Simulation succesful..............\n');
beep;

                
        
    