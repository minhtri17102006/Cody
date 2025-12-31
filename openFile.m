function openFile(num) 
    load data.mat listFolder
    opened = false;
    for i = 1:length(listFolder)
        if listFolder(i).openFile(num) == true
            opened = true;
        end
    end
    if opened == false
        warning(sprintf("File problem%05d.m không tồn tại\n", num));
    end
end