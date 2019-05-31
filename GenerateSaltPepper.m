%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GenerateSaltPepper.m                          %
%                           --------------------                          %
% copyright            : (C) 2013 by Jesus Garrido                        %
% email                : jesus.garrido@unipv.it                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function SpikesMatrix=GenerateSaltPepper(MFInit, MFNumber, TimeInit, Duration, Frequency)
    SpikesPerNeuron = floor(Frequency*Duration);
    Times = rand(SpikesPerNeuron,MFNumber)*Duration+TimeInit;
    Neurons = repmat(MFInit:(MFInit+MFNumber-1),1,SpikesPerNeuron);
    SpikesMatrix = [transpose(Times(:)); Neurons];
    
    SpikesMatrix = transpose(SpikesMatrix);