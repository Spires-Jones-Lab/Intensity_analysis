function Intensity_analysis()

%%%%% Choose Mean or Max intensity (need to be changed in 3 lines (37, 50
%%%%% and 65.

%% Source Files
srcPath = uigetdir('Select the sequence path'); %Images Location
mkdir(srcPath, [filesep 'Intensity_results']);
srcFiles = strcat(srcPath,[filesep '*.tif']);  % the folder in which ur images exists
srcFiles = dir(srcFiles);
[x,y] = size(srcFiles);

% Prepare the table for results
Table1_combined  = cell2table(cell(0,3),'VariableNames',{'Case','MeanIntensity', 'Area'});

Table2_combined  = cell2table(cell(0,4),'VariableNames',{'Case','MeanIntensity', 'MedianIntensity', 'Area'});


%% The Analysis
    for Files=1:x
        
        if contains (srcFiles(Files).name, 'mask')
        
            disp(strcat('analysing',{' '}, srcFiles(Files).name))

            MASK = read_stackTiff(strcat(srcPath,'/',srcFiles(Files).name));
            MASK = MASK > 0;
            
            I= read_stackTiff(strcat(srcPath,filesep, (char(strrep(srcFiles(Files).name,'_mask.tif', '.tif')))));
            
            FileName=(char(srcFiles(Files).name));
            FileName=FileName (:,1:end-4);
            

            MASK=imcomplement(MASK);
            MASK_objects = bwconncomp(MASK,4); 
            
            % Intensity 2D.    
            if length(size(I))==2           
            Objects_meanintensity= regionprops(MASK_objects, I, 'MeanIntensity','Area'); % Change here for MaxIntensity or MeanIntensity           
            Summary_Case_Area= mean([Objects_meanintensity.Area]);
            Summary_Case_Mean_Intensity= mean([Objects_meanintensity.MeanIntensity]);
            Summary_Case_Median_Intensity= median([Objects_meanintensity.MeanIntensity]);              
            end
             
            % Intensity 3D.    
            if length(size(I))==3         
            Objects_meanintensity= regionprops(MASK_objects, I(:,:,:), 'MeanIntensity','Area'); % Change here for MaxIntensity or MeanIntensity          
            Summary_Case_Area= mean([Objects_meanintensity.Area]);
            Summary_Case_Mean_Intensity= mean([Objects_meanintensity.MeanIntensity]);
            Summary_Case_Median_Intensity= median([Objects_meanintensity.MeanIntensity]);               
            end    
     
            % Table all objects         
            Table1 = struct2table(Objects_meanintensity);
            Table1.Case(:)={FileName};   
            Table1 = Table1(:,[3 2 1]);
            Table1_combined =vertcat(Table1,Table1_combined);                    

            disp('saving results')
            % Save Excel export                   
            writetable (Table1_combined, (strcat(srcPath,[filesep 'Intensity_results' filesep 'All_objects_Intensity.csv'])));
            
            % Table Summary Case   
            Table.Case={FileName};
            Table.MeanIntensity = num2cell(Summary_Case_Mean_Intensity);
            Table.MedianIntensity = num2cell(Summary_Case_Median_Intensity);
            Table.Area = num2cell(Summary_Case_Area);               
            Table2=struct2table(Table);  
            Table2_combined =vertcat(Table2,Table2_combined);                    

            disp('saving results')
            % Save Excel export                   
            writetable (Table2_combined, (strcat(srcPath,[filesep 'Intensity_results' filesep 'Summary_Intensity.csv'])));
            
            
        end                  
    end
                    
         disp('Done - enjoy! :)')
    
    
    



