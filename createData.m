function createData()
    excel = readtable("map.xlsx");
    listFolder = Folder.empty;

    names = excel.Properties.VariableNames;
    names = string(names');

    for i = 1:length(names)
        listFolder(end+1) = Folder(names(i));
        listFolder(end).setWebFile(excel.(names(i)));
        listFolder(end).createFolder()
    end

    save data listFolder excel
end