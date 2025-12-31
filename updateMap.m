function updateMap()
    load data.mat listFolder

    excel = readtable("map.xlsx");
    names = excel.Properties.VariableNames;
    num = cellfun(@(name) (excel.(name))' , names, "UniformOutput", false);

    for i = 1:length(names)
        exist = arrayfun(@(obj) isequal(obj.getFolderName,names{i}), listFolder);
        if all(exist == 0)
            listFolder(end+1) = Folder(names{i});
            listFolder(end).createFolder
            listFolder(end).setWebFile(num{i});
        else
            if isequal(num{i}, listFolder(exist).getWebFile) == false
                listFolder(exist).setWebFile(num{i});
            end
        end 
    end

    for i = length(listFolder):-1:1
        exist = cellfun(@(name) isequal(listFolder(i).getFolderName, name), names);
        if all(exist == 0)
            listFolder(i).removeFolder
            listFolder(i) = [];
        end
    end
    fprintf("Đã cập nhật listFolder, size: %d", length(listFolder));
    save data.mat listFolder
end

