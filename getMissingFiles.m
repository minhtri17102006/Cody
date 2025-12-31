function getMissingFiles(folderName)
    arguments 
        folderName = {}
    end
    load data.mat listFolder
    if iscell(folderName) == false
        error(sprintf("input phải là cell\n"));
    end
    if isempty(folderName) == false
        for i = 1:length(folderName)
            found = false;
            for j = 1:length(listFolder)
                if folderName{i} == listFolder(j).getFolderName
                    found = true;
                    fprintf("Folder: %s\n", listFolder(j).getFolderName)
                    listFolder(j).getMissingFile
                end
            end
            if found == false
                warning(sprintf("Folder %s không tồn tại\n", folderName{i}));
            end
        end
    else
        for i = 1:length(listFolder)
            fprintf("Folder: %s\n", listFolder(i).getFolderName)
            listFolder(i).getMissingFile
        end
    end
end