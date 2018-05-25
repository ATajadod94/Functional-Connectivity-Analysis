%   Converts PMU data (.ecg .ext .puls .resp) into single-column format, removing lead-in
%   SYNTAX: pmu_parser(input_directory, [output_directory])
%       if output_directory is not specified, data is written to the input
%       directory
%   The data must have been saved with a mz_ sequence or derivative, which puts in a '{time}SecToStart' marker
%   As it stands, the pmu data for each run should be in a separate directory
%   Simon Robinson 18.11.2008

function pmu_parser(varargin)

switch nargin
    case 1
        input_directory = char(varargin(1));
        output_directory = input_directory;
    case 2
        input_directory = char(varargin(1));
        output_directory = char(varargin(2));
    otherwise
        error('the input directory needs to be specified')
end

filters = {'*.ecg','*.ext','*.resp','*.puls'};

any_files_found = 'no';
for i=1:size(filters,2)
    filter = char(filters(i));
    switch filter
        case '*.resp'
            samp_freq = 50;
        case '*.puls'
            samp_freq = 50;
        case '*.ext'
            samp_freq = 200;
        case '*.ecg'
            samp_freq = 400;
    end
    file_listing = dir(fullfile(input_directory, filter));
    if isempty(char(file_listing.name))
        continue;
    end
    if size(file_listing,1) > 1
        error('more than one file of one type in directory');
    end
    pmu_file = fullfile(input_directory, file_listing.name);
    any_files_found = 'yes';
    disp([' * reading in ' pmu_file]);
    disp(['  - sampling frequency = ' num2str(samp_freq) ' Hz']);
    if exist(pmu_file) == 2
        processed_data = importdata(pmu_file, ' ');
        intro_string = char(processed_data.textdata(1));
        nseconds_tostart_string_start = strfind(intro_string, 'SecToStart');
        if isempty(nseconds_tostart_string_start)==0
            nseconds_b4_start = str2num(intro_string(nseconds_tostart_string_start-1));
        else
            error('SecToStart marker not found');
        end
        disp(['  - ' num2str(nseconds_b4_start) 'SecToStart string found']);
        %   Write to output file
        output_file = fullfile(output_directory, [strrep(filter, '*.', '') '.dat']);
        output_fp = fopen(output_file, 'w');
        start_sample = nseconds_b4_start*samp_freq;
        disp(['  - skipping ' num2str(start_sample) ' samples']);
        disp(['  - writing to ' output_file]);
        for j=start_sample:size(processed_data.data,2)
            fprintf(output_fp, '%i\n', processed_data.data(j));
        end
        fclose(output_fp);
    end
end
switch any_files_found
    case 'yes'
        fclose('all');
    case 'no'
        disp(['no .ecg .ext .puls or .resp files were found in ' input_directory]);
end
disp('*** Finished ***')

end