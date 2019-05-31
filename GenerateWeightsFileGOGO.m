%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                           GenerateWeightsFileGOGO.m                     %
%                           ---------------                               %
% copyright            : (C) 2013 by Jesus Garrido                        %
% email                : jesus.garrido@unipv.it                           %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function GenerateWeightsFileGOGO(FileName, MFGRAMPAWeight, MFGRNMDAWeight, MFGOWeight, GOGRWeight, SCGOWeight, GRGOWeight, GRSCWeight, SCCoupling, GOCoupling, GOGOWeight)
    fid=fopen(FileName,'w');
    fprintf(fid,'// Generated by GenerateWeightsFileNMDA\n');
    fprintf(fid,'// Mf-Gr AMPA connections\n');
    fprintf(fid,'15728 %f\n', MFGRAMPAWeight);
    fprintf(fid,'// Mf-Gr NMDA connections\n');
    fprintf(fid,'15728 %f\n', MFGRNMDAWeight);
    fprintf(fid,'// Mf-Go connections\n');
    fprintf(fid,'1350 %f\n', MFGOWeight);
    fprintf(fid,'// Gr-Go connections\n');
    fprintf(fid,'2700 %f\n', GRGOWeight);
    fprintf(fid,'// Gr-Sc connections\n');
    fprintf(fid,'30000 %f\n', GRSCWeight);
    fprintf(fid,'// Sc-Go connections\n');
    fprintf(fid,'1350 %f\n', SCGOWeight);
    fprintf(fid,'// Go-Gr connections\n');
    fprintf(fid,'18000 %f\n', GOGRWeight);
    fprintf(fid,'\n// Parallel Fibers\n');
    fprintf(fid,'// SC Electrical Coupling\n');
    fprintf(fid,'90 %f\n', SCCoupling);
    fprintf(fid,'// GO Electrical Coupling\n');
    fprintf(fid,'702 %f\n', GOCoupling);
    fprintf(fid,'// GO-GO connections\n');
    fprintf(fid,'270 %f\n', GOGOWeight);
    
    fclose(fid);