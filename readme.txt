
This is the readme for the model associated with the publication:

1. Garrido JA, Ros E and D’Angelo E (2013) Spike timing regulation on the millisecond scale
by distributed synaptic plasticity at the cerebellum input stage: a simulation study. Front. 
Comput. Neurosci. 7:64. doi: 10.3389/fncom.2013.00064

The way long-term synaptic plasticity regulates neuronal spike patterns is not completely 
understood. This issue is especially relevant for the cerebellum, which is endowed with 
several forms of long-term synaptic plasticity and has been predicted to operate as a 
timing and a learning machine. Here we have used a computational model to simulate the 
impact of multiple distributed synaptic weights in the cerebellar granular-layer network. 
In response to mossy fiber (MF) bursts, synaptic weights at multiple connections played a 
crucial role to regulate spike number and positioning in granule cells. The weight at MF to
granule cell synapses regulated the delay of the first spike and the weight at MF and parallel 
fiber to Golgi cell synapses regulated the duration of the time-window during which the 
first-spike could be emitted. Moreover, the weights of synapses controlling Golgi cell 
activation regulated the intensity of granule cell inhibition and therefore the number of 
spikes that could be emitted. First-spike timing was regulated with millisecond precision and 
the number of spikes ranged from zero to three. Interestingly, different combinations of 
synaptic weights optimized either first-spike timing precision or spike number, efficiently 
controlling transmission and filtering properties. These results predict that distributed 
synaptic plasticity regulates the emission of quasi-digital spike patterns on the millisecond 
time-scale and allows the cerebellar granular layer to flexibly control burst transmission 
along the MF pathway.

Usage:

Before simulating this model you have to install EDLUT simulator. Detailed instructions and 
the last version of this simulator can be found at its official website: 
http://edlut.googlecode.com. Once the simulator has been compiled, include the bin directory 
in your system’s path.

After getting EDLUT simulator installed, just download and extract the archive. Then, run the 
matlab script RunSimulation.m. It will generate all the files that will be need and run the 
simulations.

Once the simulation has run, it will show 3 figures with the raster plots of the mossy fibers, 
granule cells, and Golgi cells as shown in Figure 10A of the papers.
 
Files included in this zip:

The following files are included:
- RunSimulation.m: The main script to run the simulation.
- GenerateInputFileBurst.m: Matlab function to generate the input bursts according to the 
proposed protocol.
- GenerateSaltPepper.m: Matlab function to produce the background noise in the stimulation.
- GenerateWeightsFileGOGO.m: Matlab function to build the weight file for EDLUT simulator 
according to the selected weight values.
- ShowRasterPlot.m: Matlab function to show MF, GrC and GoC raster plots from the EDLUT output
 files.
- netGoCGoCTD.cfg: The network description file for EDLUT simulator.
- _LIF_TD_NMDA_Golgi.cfg: The Golgi cell model parameters for EEDLUT simulator.
- _LIF_TD_NMDA_Granule.cfg: The granule cell model parameters for EDLUT simulator.
- _LIF_TD_NMDA_Interneuron.cfg: The interneuron model parameters for EDLUT simulator.
 
These model files were supplied by Jesús Garrido. If you have any question/comments/feedback, 
please send me an email to jesus.garrido@unipv.it.
