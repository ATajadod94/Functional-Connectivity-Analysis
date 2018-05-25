function files = Getting_labels(type,subject,label) 
    switch type 
        case 'label'
            files = get_labels(subject,label);
        case 'structure'
            files = get_structure(subject,label);
        case 'function'
            files = get_functional(subject,label);
        case 'motion'
            files = get_motion(subject,label);
    end
end 
function labels = get_labels(subject , label)

%data_dir = 'H:\myStudies\phdThesisData\Data'; %% windows 
data_dir = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data';
switch label
    case 'glasser'
         labels = fullfile(data_dir,'glasser_label', sprintf('%02d',subject),'HCPMMP1.nii.gz');
    case 'kastner'
         folder = fullfile(data_dir,'PreProcess',strcat('Subject_', ...
                  sprintf('%02d',subject)),'Kastner_Label');
         myfiles = dir(folder);
         label_names = {};
         labels = {};
         for i=3:length(myfiles)
             if (((myfiles(i).name(1) == 'l') || (myfiles(i).name(1) == 'r')) && myfiles(i).name(end) == 'i')
                 label_names(length(label_names)+1) = cellstr(myfiles(i).name);
             end             
         end
         label_names(length(label_names)+1)  = cellstr('Kastner_maxprob_vol_rh.nii');
         label_names(length(label_names)+1)  = cellstr('Kastner_maxprob_vol_lh.nii');
         
         for i=1:length(label_names)
             labels(length(labels)+1) = cellstr(fullfile(folder,label_names{i}));
         end
    case 'griffis'
         folder = fullfile(data_dir,'griffisV1_zx',sprintf('%02d',subject));
         label_names = dir(folder);
         label_names = label_names(3:end);
         labels = {};
         for i=1:length(label_names)
             labels(length(labels)+1) = cellstr(fullfile(folder,label_names(i).name));
         end
    case 'MTL'
        folder = fullfile(data_dir,'FreeSurfer_ROIs',sprintf('%02d',subject),'Ali_ROIs');
        label_names = dir(folder);
         label_names = label_names(3:end-2);
         labels = {};
         for i=1:length(label_names)
             labels(length(labels)+1) = cellstr(fullfile(folder,label_names(i).name));
         end
end
         

end

function files = get_structure(subject,label)

%data_dir = 'H:\myStudies\phdThesisData\Data'; %% windows 
data_dir = '/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess';
switch label
    case  'Structural'
         f_name = dir(fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy','s*.img'));
         files = fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy', f_name.name);
    case  'Grey'
         f_name = dir(fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy','c1*.img'));
         files = fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy', f_name.name);
     case 'White'
         f_name = dir(fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy','c2*.img'));
         files = fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy', f_name.name);
    case  'CSF'
         f_name = dir(fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy','c3*.img'));
         files = fullfile(data_dir, strcat('Subject_',sprintf('%02d',subject)), 'Anatomy', f_name.name);

end
end

function files = get_functional(subject,label)
subject_file = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess','/Subject_', sprintf('%02d',subject));  
%subject_file = strcat('H:\myStudies\phdThesisData\Data\PreProcess','\Subject_', sprintf('%02d',subject));  
switch label
       case 'runs'
           fundir = strcat(subject_file,'/preencoding_rest/');
           funfiles = dir([fundir,'ra*.img']);
           files{1} = [repmat(fundir,[181,1]),strvcat(funfiles(1:181).name)];
           fundir = strcat(subject_file,'/post_encoding_rest_fam/');
           funfiles = dir([fundir,'ra*.img']);
           files{2} = [repmat(fundir,[181,1]),strvcat(funfiles(1:181).name)];
           fundir = strcat(subject_file,'/post_encoding_rest_nonfam/');
           funfiles = dir([fundir,'ra*.img']);
           files{3} = [repmat(fundir,[181,1]),strvcat(funfiles(1:181).name)];
           fundir = strcat(subject_file,'/thinkback/');
           funfiles = dir([fundir,'ra*.img']);
           files{4} = [repmat(fundir,[181,1]),strvcat(funfiles(1:181).name)];    
           fundir = strcat(subject_file,'/thinkahead/');
           funfiles = dir([fundir,'ra*.img']);
           files{5} = [repmat(fundir,[181,1]),strvcat(funfiles(1:181).name)];    
        case 'tasks'
%            fundir = strcat(subject_file,'/encoding_fam1/');
%            funfiles = dir([fundir,'ra*.img']);
%            files{1} = [repmat(fundir,[287,1]),strvcat(funfiles(1:287).name)];
           fundir = strcat(subject_file,'/encoding_fam2/');
           funfiles = dir([fundir,'ra*.img']);
           files{1} = [repmat(fundir,[287,1]),strvcat(funfiles(1:287).name)];
%            fundir = strcat(subject_file,'/encoding_nonfam1/');
%            funfiles = dir([fundir,'ra*.img']);
%            files{3} = [repmat(fundir,[287,1]),strvcat(funfiles(1:287).name)];
%            fundir = strcat(subject_file,'/encoding_nonfam2/');
%            funfiles = dir([fundir,'ra*.img']);
%            files{4} = [repmat(fundir,[287,1]),strvcat(funfiles(1:287).name)];    
       case 'res'
           fundir = strcat(subject_file,'/firstlevelAnalysis_Native/');
           funfiles = dir([fundir,'Res*.img']);
           files{1} = [repmat(fundir,[287,1]),strvcat(funfiles(1:287).name)];
           fundir = strcat(subject_file,'/firstlevelAnalysis_Native/');
           funfiles = dir([fundir,'ResI_*.img']);
           files{2} = [repmat(fundir,[287,1]),strvcat(funfiles(288:574).name)];
           fundir = strcat(subject_file,'/firstlevelAnalysis_Native/');
           funfiles = dir([fundir,'ResI_*.img']);
           files{3} = [repmat(fundir,[287,1]),strvcat(funfiles(576:862).name)];
           fundir = strcat(subject_file,'/firstlevelAnalysis_Native/');
           funfiles = dir([fundir,'ResI_*.img']);
           files{4} = [repmat(fundir,[287,1]),strvcat(funfiles(862:1148).name)];
    end
end

function files = get_motion(subject,label)
%subject_file = strcat('H:\myStudies\phdThesisData\Data\PreProcess','\Subject_', sprintf('%02d',subject));  
subject_file = strcat('/Volumes/Ryan3T1/myStudies/phdThesisData/Data/PreProcess','/Subject_', sprintf('%02d',subject));  

switch label
       case 'runs'
           fundir = strcat(subject_file,'/preencoding_rest/');
           funfiles = dir([fundir,'*txt']);
           files{1} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];

           fundir = strcat(subject_file,'/post_encoding_rest_fam/');
           funfiles = dir([fundir,'*txt']);
           files{2} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
            
           fundir = strcat(subject_file,'/post_encoding_rest_nonfam/');
           funfiles = dir([fundir,'*txt']);
           files{3} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
           
           fundir = strcat(subject_file,'/thinkback/');
           funfiles = dir([fundir,'*txt']);          
           files{4} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
   
        
           fundir = strcat(subject_file,'/thinkahead/');
           funfiles = dir([fundir,'*txt']);
           files{5} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
           files = files';
        
        case 'tasks'

%            fundir = strcat(subject_file,'/encoding_fam1/');
%            funfiles = dir([fundir,'*txt']);
%            files{1} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];

               fundir = strcat(subject_file,'/encoding_fam2/');
               funfiles = dir([fundir,'*txt']);
               files{1} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
%             
%            fundir = strcat(subject_file,'/encoding_nonfam1/');
%            funfiles = dir([fundir,'*txt']);
%            files{3} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
%            
%            fundir = strcat(subject_file,'/encoding_nonfam2/');
%            funfiles = dir([fundir,'*txt']);          
%            files{4} = [repmat(fundir,[1,1]),strvcat(funfiles(1:1).name)];
%   
	end
     
end

