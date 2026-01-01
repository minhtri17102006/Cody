function updatePCNV()
    excel = readtable("Phan_cong_nhiem_vu.xlsx");
    
    minh = excel.Minh;
    excel.Complete1 = arrayfun(@isFileExist, minh);
    tu = excel.Tu;
    excel.Complete2 = arrayfun(@isFileExist, tu);
    nhat = excel.Nhat;
    excel.Complete3 = arrayfun(@isFileExist, nhat);
    writetable(excel, "Phan_cong_nhiem_vu.xlsx");
    
        function tf = isFileExist(num)
            load data.mat listFolder
            tf = any(arrayfun(@(i) listFolder(i).isFileExist(num), 1:length(listFolder)));
        end
end