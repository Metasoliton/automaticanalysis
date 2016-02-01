% Automatic analysis
% User master script based on
% github.com/rhodricusack/automaticanalysis/wiki/Manual:
% Example (aa version 4.*)
%
% Tibor Auer, MRC-CBSU
% 09-12-2013

%% INITIALISE
clear

SUBJ = {...
     'S01' 140905; ...
     'S02' 140910; ...
     'S03' 140913; ...
     'S04' 140928; ...
     'S05' 140931; ...
     };

aa_ver4

%% DEFINE SPECIFIC PARAMETERS
%  Default recipe without model
aap=aarecipe('aap_parameters_defaults.xml','aap_tasklist_structural.xml');
aap = aas_configforSPM12(aap);

% Modify standard recipe module selection here if you'd like
aap.options.wheretoprocess = 'qsub'; % queuing system	% typical value localsingle or qsub
aap.options.NIFTI4D = 1;
aap.options.email='';
aap.options.autoidentifyfieldmaps = 1;
aap.options.autoidentifystructural_chooselast = 1;
aap.options.autoidentifyt2=1;
aap.options.autoidentifyt2_chooselast = 1;

aap.tasksettings.aamod_segment8_multichan.writenormimg=0;
aap.tasksettings.aamod_dartel_normmni.fwhm=1;

%% STUDY
% Directory for analysed data
aap.acq_details.root = '/imaging'; 
aap.directory_conventions.analysisid = 'Structural'; 

% Add data
for s = 1:size(SUBJ,1)
   aap = aas_addsubject(aap,SUBJ{s,2},[]);
end

%% DO ANALYSIS
aa_doprocessing(aap);