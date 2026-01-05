function ScanAndStash(folders)
table1 = struct2table(dir(fullfile(folders)));
load('SignatureData.mat','sigTable');
for i = size(table1,1):-1:1
    if ~ismember(table1.name{i}(1),'A':'Z') || strcmp(table1.name{i}(:),'README.txt')
        table1(i,:) = [];
    end
end
for i = 1:size(table1,1)
    problemName = table1.name{i};
    linkerPath = fullfile(folders,problemName);
    mFiles = dir(fullfile(linkerPath,'*.m'));
    alreadyCountedInThisProblem = false(height(sigTable),1);
    for j = 1:length(mFiles)
        fullFilePath = fullfile(mFiles(j).folder,mFiles(j).name);
        content = fileread(fullFilePath);
            for k = 1:height(sigTable)
                if contains(content,fullFilePath)
                 if ~alreadyCountedInThisProblem(k) && ~ismember(problemName,sigTable.Proceed{k})
                    sigTable.Count(k) = sigTable.Count(k) + 1;
                    sigTable.Proceed{k}{end+1} = problemName;
                    alreadyCountedInThisProblem(k) = true;
                    fprintf('Add 1 point\n');
                 end
                end
            end
        
    end
end
save('SignatureData.mat','sigTable');
disp('Stats completed');

end