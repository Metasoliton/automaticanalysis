% This function is automagically generated by aa_build_standalone_1_pragmas
% This is a message pump for the worker

function aaworker_poll(obj,event)
%#function aamod_ANTS_EPIwarp aamod_ANTS_build_MMtemplate aamod_ANTS_build_template aamod_ANTS_struc2epi aamod_ANTS_struc2template aamod_ANTS_warp aamod_GLMdenoise aamod_LoAd aamod_LoAd2SPM aamod_LouvainCluster aamod_MP2RAGE aamod_MTI2MTR aamod_autoidentifyseries aamod_autoidentifyseries_siemens aamod_bet aamod_bet_epi_masking aamod_bet_epi_reslicing aamod_bet_freesurfer aamod_bet_premask aamod_biascorrect aamod_biascorrect_ANTS aamod_biascorrect_segment8 aamod_biascorrect_segment8_multichan aamod_binarizeimage aamod_binaryfromlabels aamod_brainmask aamod_brainmaskcombine aamod_checkparameters aamod_clusteringXValidation aamod_compSignal aamod_compareoverlap aamod_convert_diffusion aamod_convert_dmdx aamod_convert_epis aamod_convert_fieldmaps aamod_convert_specialseries aamod_convert_structural aamod_copy_image_orientation aamod_coreg_extended aamod_coreg_extended_1 aamod_coreg_extended_2 aamod_coreg_general aamod_coreg_noss aamod_coreg_structural2fa aamod_coreg_structural2template aamod_coregisterstructural2template aamod_dartel_createtemplate aamod_dartel_denorm aamod_dartel_normmni aamod_decodeDMLT aamod_denoiseANLM aamod_diffusion_bedpostx aamod_diffusion_dki_tractography_prepare aamod_diffusion_dkifit aamod_diffusion_dtifit aamod_diffusion_dtinlfit aamod_diffusion_eddy aamod_diffusion_eddycorrect aamod_diffusion_extractnodif aamod_diffusion_probtrackx aamod_diffusion_probtrackxsummarize_group aamod_diffusion_probtrackxsummarize_indv aamod_diffusion_roi_valid aamod_diffusion_topup aamod_diffusionfromnifti aamod_epifromnifti aamod_evaluatesubjectnames aamod_fconn_computematrix aamod_fconnmatrix_seedseed aamod_fieldmap2VDM aamod_fieldmapfromnifti aamod_firstlevel_contrasts aamod_firstlevel_model aamod_firstlevel_model_MVPaa aamod_firstlevel_modelspecify aamod_firstlevel_threshold aamod_freesurfer_autorecon aamod_freesurfer_deface aamod_freesurfer_deface_apply aamod_freesurfer_initialise aamod_freesurfer_register aamod_fsl_FAST aamod_fsl_FIRST aamod_fsl_reorienttoMNI aamod_fsl_robustFOV aamod_fslmaths aamod_fslmerge aamod_fslsplit aamod_garbagecollection aamod_get_dicom_ASL aamod_get_dicom_diffusion aamod_get_dicom_epi aamod_get_dicom_fieldmap aamod_get_dicom_specialseries aamod_get_dicom_structural aamod_get_tSNR aamod_ggmfit aamod_highpass aamod_highpassfilter_epi aamod_imcalc aamod_importfilesasstream aamod_input_staging aamod_listspikes aamod_make_epis_float aamod_mapstreams aamod_marsbar aamod_mask_fromsegment aamod_mask_fromstruct aamod_maths aamod_meanepitimecourse aamod_meg_average aamod_meg_convert aamod_meg_denoise_ICA_1 aamod_meg_denoise_ICA_2_applytrajectory aamod_meg_epochs aamod_meg_get_fif aamod_meg_grandmean aamod_meg_maxfilt aamod_meg_merge aamod_melodic aamod_mirrorandsubtract aamod_modelestimate aamod_movie aamod_moviecorr_meantimecourse aamod_moviecorr_summary aamod_newsubj_init aamod_norm_noss aamod_norm_vbm aamod_norm_write aamod_norm_write_dartel aamod_normalisebytotalgrey aamod_oneway_ANOVA aamod_pewarp_estimate aamod_pewarp_write aamod_possum aamod_ppi_model aamod_ppi_prepare aamod_realign aamod_realignunwarp aamod_reorientto aamod_reorienttomiddle aamod_reslice aamod_resliceROI aamod_reslice_rois aamod_roi_extract aamod_roi_valid aamod_rois_getvalues aamod_secondlevel_GIFT aamod_secondlevel_contrasts aamod_secondlevel_model aamod_secondlevel_randomise aamod_secondlevel_threshold aamod_seedConnectivity aamod_segment aamod_segment8 aamod_segmentvbm8 aamod_slicetiming aamod_smooth aamod_smooth_structurals aamod_split aamod_structural_overlay aamod_structuralfromnifti aamod_structuralstats aamod_study_init aamod_tSNR_EPI aamod_temporalfilter aamod_tensor_ica aamod_tissue_spectrum aamod_tissue_spectrum_summarize aamod_tissue_wavelets aamod_tissue_wavelets_summarize aamod_trimEPIVols aamod_tsdiffana aamod_unnormalise_rois aamod_unnormalise_rois2 aamod_unzipstream aamod_vois_extract aamod_waveletdespike aamod_MVPaa_brain_1st aamod_MVPaa_brain_SPM aamod_MVPaa_roi_1st aamod_MVPaa_roi_2nd aamod_template_session
global aaworker;
numretries=1; % Now retries are handling by master - better at reallocating in case of memory errors etc.
stop(aaworker.polltimer);
mastertaskpth=fullfile(aaworker.parmpath,'pendingtask.mat');
taskpth=aas_propagatefrom(aaworker.master.hostname,mastertaskpth,'worker');
if (exist(taskpth))
    for i=1:30
        try
            task=load(taskpth);
            task=task.task;
            aaworker.aap=task.aap;
            break;
        catch
            % assume it was a file propagation delay or locking problem and so try again
            taskpth=aas_propagatefrom(aaworker.master.hostname,mastertaskpth,'worker');
            fprintf('waiting for propagation %d\n',i);
            pause(5.0);
        end;
    end;
    fprintf('AAWORKER: Found task %s here %s\n',task.name,taskpth);
    tic;
    switch (task.name)
        case 'doprocessing'
            for i=1:length(aaworker.aap.internal.taskqueue)

                % If at first you don't succeed, try, and try again
                for jj=1:numretries
                    try
                        mytask=aaworker.aap.internal.taskqueue(i);
                        % allow full path of module to be provided
                        [stagepath stagename]=fileparts(aaworker.aap.tasklist.main.module(mytask.k).name);
                        stagetag=aas_getstagetag(aaworker.aap,mytask.k);
                        try
                            aaworker.aap.tasklist.currenttask.settings=aaworker.aap.tasksettings.(stagename)(aaworker.aap.tasklist.main.module(mytask.k).index);
                        catch
                            aaworker.aap.tasklist.currenttask.settings=[];
                        end;

                        switch(mytask.domain)
                            % now run current stage
                            case 'study'
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s RUNNING: %s',stagetag,mytask.description));
                                [aaworker.aap,resp]=feval(aaworker.aap.tasklist.main.module(mytask.k).name,aaworker.aap,mytask.task);
                                writedoneflag(aaworker,mytask.doneflag);
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s COMPLETED',stagetag));
                            case 'subject'
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s RUNNING: %s for %s',stagetag,mytask.description,aas_getsubjdesc(aaworker.aap,mytask.i)));
                                [aaworker.aap,resp]=feval(aaworker.aap.tasklist.main.module(mytask.k).name,aaworker.aap,mytask.task,mytask.i);
                                writedoneflag(aaworker,mytask.doneflag);
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s COMPLETED',aaworker.aap.tasklist.main.module(mytask.k).name));
                            case 'session'
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s RUNNING: %s for %s ',aaworker.aap.tasklist.main.module(mytask.k).name,mytask.description,aas_getsessdesc(aaworker.aap,mytask.i,mytask.j)));
                                [aaworker.aap,resp]=feval(aaworker.aap.tasklist.main.module(mytask.k).name,aaworker.aap,mytask.task,mytask.i,mytask.j);
                                writedoneflag(aaworker,mytask.doneflag);
                                aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s COMPLETED',aaworker.aap.tasklist.main.module(mytask.k).name));
                            case 'internal'
                                if ~mytask.i % need to setup loop variable
                                    [aaworker.aap,resp]=feval(aaworker.aap.tasklist.main.module(mytask.k).name,aaworker.aap,'parallelise');
                                    mkdir(mytask.doneflag);
                                    aas_propagateto(aaworker.master.hostname,mytask.doneflag);
                                    aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s PARALLELISED',stagetag));
                                else
                                    aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s RUNNING: %s',stagetag,mytask.description));
                                    [aaworker.aap,resp]=feval(aaworker.aap.tasklist.main.module(mytask.k).name,aaworker.aap,mytask.task,mytask.i);
                                    writedoneflag(aaworker,mytask.doneflag); % includes propagation
                                    aas_log(aaworker.aap,0,sprintf('\nAAWORKER %s COMPLETED',aaworker.aap.tasklist.main.module(mytask.k).name));
                                    doneflagpath=fileparts(mytask.doneflag);
                                    alldone=aas_checkinternaldomainprogress(doneflagpath);
                                    if alldone 
                                        writedoneflag(aaworker,fullfile(doneflagpath,'all.done'));
                                        aas_log(aaworker.aap,0,sprintf('\nALL %s SUBTASKS COMPLETED',aaworker.aap.tasklist.main.module(mytask.k).name));
                                    end
                                end
                        end;
                        jj=0;
                        % Flush diary to update
                        diary off
                        diary(aaworker.diaryname)
                        break;
                    catch;
                        % Flush diary to update
                        diary off
                        diary(aaworker.diaryname)
                        % make sure we're in the right directory
                        le=lasterror;
                        cd (aaworker.aap.internal.pwd);
                        aas_log(aaworker.aap,0,sprintf('AAWORKER WARNING: retrying as failed on attempt %d of %d with error:\n\t%s',jj,numretries,le.message));
                        for kk=1:length(le.stack)
                            aas_log(aaworker.aap,0,sprintf(' file %s name %s line %d',le.stack(kk).file,le.stack(kk).name,le.stack(kk).line));
                        end;
                    end;
                end; % next retry
                if (jj==numretries)
                    aas_log(aaworker.aap,1,sprintf('AAWORKER ERROR: %d retries did not suceed - see details above',numretries));
                end;
            end; % next task in queue
    end; % currently redundant
    try
        aaworker_setspmvisibility
        delete(taskpth);
        delete(mastertaskpth);
        timenow=now;
        boredfn=fullfile(aaworker.parmpath,'iambored.mat');
        save(boredfn,'timenow'); rehash
        aas_propagateto(aaworker.master.hostname,boredfn);
        aaworker.lastexcitement=clock;
    catch
        debugnow
        % Flush diary to update
        diary off
        diary(aaworker.diaryname)
    end;
else
    % Terminate worker if not used for 3 minutes
    if (etime(clock,aaworker.lastexcitement)>180)
        try
            aas_log(aaworker.aap,0,'There is nothing happening. I am out of here.\n');
            diary off
        catch
            % Flush diary to update
            diary off
            diary(aaworker.diaryname)
        end;
        % Now use recursive kill to finish self off, as this will get any
        % child processes
        aas_sackworker(aaworker.aap,aaworker.id);
        % bet you never get here
        exit;
    end;
end;
% Flush diary to update
diary off
diary(aaworker.diaryname)


start(aaworker.polltimer);

%%
function writedoneflag(aaworker,fn)
fid=fopen(fn,'w');
if (~fid) aas_log(aaworker.aap,1,['Error writing done flag ' fn]); end;
try fprintf(fid,'%f',toc);
catch
    keyboard
end
fclose(fid);
aas_propagateto(aaworker.master.hostname,fn);
return;


