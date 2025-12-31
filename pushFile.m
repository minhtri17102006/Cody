function complete = pushFile(problemNum, overwrite)
    arguments
        problemNum
        overwrite = false;
    end
    if isnumeric(problemNum)
        fileName = sprintf("problem%05d.m", problemNum);
    else
        fileName = problemNum;
    end
    if isfile(fileName) == false
        complete = false;
        error(sprintf("File %s khong ton tai", fileName))
    end
    
    load data.mat listFolder
    success = arrayfun(@(obj) obj.moveFile(fileName, overwrite), listFolder);
    if all(success == false)
        fprintf("Khong tim thay folder hop le cho file %s\n", fileName)
        complete = false;
    else
        complete = true;
        delete(fileName);
        fprintf("Da delete file %s\n", fileName);
    end


end