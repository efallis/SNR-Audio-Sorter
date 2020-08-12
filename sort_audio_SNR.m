clc;
clear;
close all;

% Navigate to location of all files
cd ''

% Defines
CLIP_NUM = 20;

categories = {'Human', 'Mechanical', 'Music', 'Nature'};

for i = 1:length(categories)
    clip_list = zeros(CLIP_NUM, 2);
    for j = 1:CLIP_NUM
        path = char(strcat('original/',categories(i),'/',categories(i),int2str(j),'.wav'));
        [y,Fs] = audioread(path);
        y = y(:,1);

        %env = envelope(y, 1000, 'peak');
        snr_clip = snr(y,Fs);
        clip_list(j, 1) = j;
        clip_list(j, 2) = mean(snr_clip);
        
        sorted = sortrows(clip_list, 2);
%         figure
%         plot(y);
%         hold on 
%         plot(env)
%         hold off

        
    end
    disp(sorted)
    
    copy_source = char(strcat('original/', categories(i),'/', categories(i), int2str(sorted(end, 1)), '.wav'));
    copy_dest = char(strcat('sorted_snr/', '_clean.wav'));

    copyfile(copy_source, copy_dest);
    
%     for j = 1:CLIP_NUM
%         copy_source = char(strcat('original/', categories(i),'/', categories(i), int2str(sorted(j, 1)), '.wav'));
%         copy_dest = char(strcat('sorted/', categories(i), int2str(j), '.wav'));
%         
%         copyfile(copy_source, copy_dest);
%     end
end
