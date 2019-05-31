%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           ShowRasterPlot.m                              %
%                           ---------------                               %
% copyright            : (C) 2013 by Jesus Garrido                        %
% email                : jesus.garrido@unipv.it                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function ShowRasterPlot(ResultFile, NumMFCells, NumGCCells, NumGoCells, InitInterval, FinishInterval)

%% Cells numbers
NeuronMF_MZ1 = 0;
NeuronGC_MZ1 = NeuronMF_MZ1+NumMFCells+1;
NeuronGO_MZ1 = NeuronGC_MZ1+NumGCCells+1;
NeuronSC_MZ1 = NeuronGO_MZ1+NumGoCells+1;

%% Load output file
Spikes = load(ResultFile);

% Plot MF activity
iref=find(Spikes(:,2)>=NeuronMF_MZ1);
SpikesRef = Spikes(iref,:);
iref=find(SpikesRef(:,2)<NeuronGC_MZ1);
SpikesRef = SpikesRef(iref,1:2);
figure;
plot(SpikesRef(:,1),SpikesRef(:,2),'.b');
axis([InitInterval FinishInterval NeuronMF_MZ1-1 NeuronGC_MZ1+1]);
title('Mossy Fibers');
xlabel('Time (s)');
ylabel('Cell Number');
    
% Plot GrC activity
iref=find(Spikes(:,2)>=NeuronGC_MZ1);
SpikesRef = Spikes(iref,:);
iref=find(SpikesRef(:,2)<NeuronGO_MZ1);
SpikesRef = SpikesRef(iref,1:2);
figure;
plot(SpikesRef(:,1),SpikesRef(:,2),'.r');
axis([InitInterval FinishInterval NeuronGC_MZ1-1 NeuronGO_MZ1+1]);
title('Granule Cells');
ylabel('Cell Number');
xlabel('Time (s)');

% Plot GoC activity
iref=find(Spikes(:,2)>=NeuronGO_MZ1);
SpikesRef = Spikes(iref,:);
iref=find(SpikesRef(:,2)<NeuronSC_MZ1);
SpikesRef = SpikesRef(iref,1:2);
figure;
plot(SpikesRef(:,1),SpikesRef(:,2),'.g');
axis([InitInterval FinishInterval NeuronGO_MZ1-1 NeuronSC_MZ1+1]);
title('Golgi Cells');
ylabel('Cell Number');
xlabel('Time (s)');

clear iref;
clear SpikesRef;