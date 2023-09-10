% MATLAB code for generating database of persian digits. It is a general
% purpose code and can be used for generating handwritten or typed chars DB
% the only one that you shoud do is to create a .png file with typed font
% on a withe background file for each digit X(or char) and name the file as
% the class label you want (for example name each digit X as X.png)
% Also, a JSON file is created at the end to be used in conjunction with
% deep learning methods.
clear,clc;
close all;
warning off;

%%
samplePerDigit=20;%the number of sample per digit

%%
folder='dataFolder';%for each class (here digits X) create a white background .png image that contains digit X with differnt fonts
addpath(folder);
ft =dir(fullfile([folder,'\','*.png']));

jsonstr='[';
ctr=1;
orderedFileNumber=0;%If orderedFileNumber==1 then the file name starts from 1.png,2.png,.... Else randNum1.png, randNum2.png,...
maxfileThatisCreated=10*samplePerDigit*2;
if orderedFileNumber
    fnum=1:maxfileThatisCreated;
else
    fnum=randperm(maxfileThatisCreated);
end
for i=1:numel(ft) %loop over each digit
    img=imread(ft(i).name); %read the X.png file containing digit X (Here, the file name is the digit)
    img=(imcomplement(im2bw(img))); 
    stats = regionprops('table',img,'BoundingBox');%find region of each font
    bb=table2array(stats);
    [~,digitSubfolder,~] = fileparts(ft(i).name);
    if (exist([folder,'/',digitSubfolder],'dir')==7) %check if subfolder X exists or not
        rmdir([folder,'/',digitSubfolder],'s'); %remove existing folder
    end
    mkdir([folder,'/'],digitSubfolder); %else create a folder for digit X
%     delete(sprintf('%s/%s/*.png',ft(i).folder,digitSubfolder));% remove existing files in folder X
    fprintf('Loop over digit: %s\n',digitSubfolder);
    for j=1:size(bb,1) %loop over each digit
        croppedImg=255*uint8(img(bb(j,2):bb(j,2)+bb(j,4)-1,(bb(j,1):bb(j,1)+bb(j,3)-1)));%crop a font
        numSamplePerFont=ceil(samplePerDigit/size(bb,1));%the number of sample per font
        for k=1:numSamplePerFont
            smp=croppedImg;
            % random change in each sample
            smp=imresize(smp,[floor(size(smp,1)*1.5),size(smp,2)]);%resize each font
            smp=imrotate(smp,randi([-5,5],1));%random rotation 
            backColor=randi([0,100],1);%random back color
            smp(smp==0)=backColor;
            [rsmp,csmp]=size(smp);
            paddsize=[floor(rsmp/9),floor(csmp/3)];%padd each font
            if (strcmp(digitSubfolder,'0')) % different padding for digit 0
                paddsize=ceil([rsmp,csmp]*.5);
            end
            smp = padarray(smp,paddsize,backColor);%padd with backColor
            if (rand()>0.6) %random noise
                smp=imnoise(smp,'salt & pepper',randi([3,6],1)/100);
                smp = imfilter(smp,fspecial('motion',randi([5,10],1),randi([10,360],1)),'replicate');
            end
            if (rand()>0.8)  %blurring
                smp=imgaussfilt(smp,3);
            end
            if (rand()>0.8)  %random noise
                smp=imnoise(smp,'salt & pepper',randi([1,3],1)/100);
            end
            smp=imgaussfilt(smp,randi([1,3],1)); %blurring
            smp=imresize(smp,[32,32]); %resize sample to 32*32
            [h,w]=size(smp);
            filename=sprintf('%d.png',fnum(ctr));
            str=sprintf('\n{\n"boxes": [\n{\n"width":%d,\n"top":%d,\n"label":%d.0,\n"left":%d,\n"height":%d\n}\n],\n"filename":"%s"\n},',w,0,str2num(digitSubfolder),0,h,filename);
            jsonstr=strcat(jsonstr,str);%jsonstr is an string to create the information of samples in json format mostly used by deep learning methods 
            imwrite(smp, sprintf('%s\\%s\\%d.png',ft(i).folder,digitSubfolder,fnum(ctr)),'png'); %write image as png image, you can use the mask property if imagewrite to create png with transparent background
            ctr=ctr+1; %increase file name counter
        end
    end
end
jsonstr(end)=']';
fid = fopen('digitStruct.json','wt');
fprintf(fid, '%s', jsonstr);
fclose(fid);
