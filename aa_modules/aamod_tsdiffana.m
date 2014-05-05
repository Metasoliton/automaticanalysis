% AA module - tsdiffana - tool to assess time series variance
% [aap,resp]=aamod_tsdiffana(aap,task,i,j)
% Rhodri Cusack MRC CBU Cambridge Aug 2004
% Tibor Auer MRC CBU Cambridge 2012-2013

function [aap,resp]=aamod_tsdiffana(aap,task,subjInd,sessInd)

resp='';

switch task
    case 'domain'
        resp='session';   % this module needs to be run once per session
    case 'whentorun'
        resp='justonce';  % should this be run everytime or justonce?        
    case 'description'
        resp='Run tsdiffana';
    case 'summary'
        resp='Check time series variance using tsdiffana\n';
    case 'report' % Updated [TA]
        aap = aas_report_add(aap,subjInd,'<table><tr><td>');
        mriname = aas_prepare_diagnostic(aap, subjInd, sessInd);
        aap=aas_report_addimage(aap,subjInd,fullfile(aap.acq_details.root, 'diagnostics', [mfilename '__' mriname '_MP.jpeg']));     
        aap = aas_report_add(aap,subjInd,'</td></tr></table>');
    case 'doit'
        sesspath=aas_getsesspath(aap,subjInd,sessInd);

        aas_makedir(aap,sesspath);
        
        % imgs=spm_get('files',sesspath,[aap.directory_conventions.subject_filenames{i} '*nii']); % changed img to nii [djm160206]
 
        % added in place of previous line [djm 160206]...
            % get files in this directory
            imgs=aas_getimages_bystream(aap,subjInd,sessInd,'epi');
            
        tsdiffana(imgs,0);
        
        mriname = aas_prepare_diagnostic(aap, subjInd);
        print('-djpeg','-r150',fullfile(aap.acq_details.root, 'diagnostics', ...
            [mfilename '_' mriname '_' aap.acq_details.sessions(sessInd).name '.jpeg']));
        
%         % Now produce graphical check
%         try figure(spm_figure('FindWin', 'Graphics')); catch; figure(1); end;
%         print('-djpeg','-r75',fullfile(sesspath,'diagnostic_aamod_tsdiffana'));
     
        subjpth=aas_getsesspath(aap,subjInd,sessInd); 
        aap=aas_desc_outputs(aap,subjInd,sessInd,'tsdiffana',fullfile(subjpth,'timediff.mat')); 
    
    case 'checkrequirements'
        
    otherwise
        aas_log(aap,1,sprintf('Unknown task %s',task));
end;