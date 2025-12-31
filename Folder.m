classdef Folder < handle
    properties (Access = private)
        FolderName
        Path
        Exist
        
        WebFile
    end

    methods
         function obj = Folder(name)
            if nargin > 0
                obj.FolderName = name;
            else
                obj.FolderName = "Untitled";
            end
            fullPathToScript = mfilename('fullpath'); 
            [currentDir, ~, ~] = fileparts(fullPathToScript);
            obj.Path = currentDir;

            targetFullPath = fullfile(obj.Path, obj.FolderName);
            obj.Exist = isfolder(targetFullPath);
            obj.WebFile = [];
         end
         function delete(obj)
             %destructor function
         end
         function success = setWebFile(obj, members)
             if isempty(members)
                 disp("Empty data");
                 success = false;
                 return
             elseif iscolumn(members)
                 members = members';
             end
             members(isnan(members)) = [];
             obj.WebFile = members;
             success = true;
         end
         
         function folderName = getFolderName(obj)
             folderName = obj.FolderName;
         end
         function members = getWebFile(obj)
             if isempty(obj.WebFile)
                 disp("Web Member is empty!");
                 return
             end
             members = obj.WebFile;
         end
         function path = getPath(obj)
             if obj.Exist == true
                 path = fullfile(obj.Path, obj.FolderName);
             else
                 path = obj.Path;
             end
         end
         function list = getMissingFile(obj)
            filesName = arrayfun(@(num) sprintf("problem%05d.m", num), obj.getWebFile, "UniformOutput", false);
            list = filesName(cellfun(@(name) ~obj.isFileExist(name), filesName))';
            %return cell
         end
         function list = getCurrentFile(obj)
            filesName = arrayfun(@(num) sprintf("problem%05d.m", num), obj.getWebFile, "UniformOutput", false);
            list = filesName(cellfun(@(name) obj.isFileExist(name), filesName))';
            %return cell
         end

         function tf = isWebFile(obj, probNum)
             if isnumeric(probNum) == false
                 probNum = str2num(regexp(probNum, "\d{5}", "match", "once"));
             end
             tf = ismember(probNum, obj.WebFile);
         end
         function tf = isFolderExist(obj)
             tf = obj.Exist;
         end
         function tf = isFileExist(obj, fileName)
             if isnumeric(fileName)
                 fileName = sprintf("problem%05d.m", fileName);
             end
             pathFile = fullfile(obj.getPath, fileName);
             tf = isfile(pathFile);
         end
         

         function success = createFolder(obj)
             targetPath = fullfile(obj.getPath, obj.FolderName);

             if obj.Exist
                 warning('Folder "%s" existed.', obj.FolderName);
                 success = false;
                 return;
             end
             [status, msg] = mkdir(targetPath);

             if status == 1
                 obj.Exist = true;
                 fprintf('Folder has been created: %s\n', targetPath);
                 success = true;
             else
                 error('Error during create folder: %s', msg);
             end
         end
         function success = removeFolder(obj)
             targetPath = fullfile(obj.getPath);

             if ~obj.Exist
                 warning('Folder "%s" does not exist.', obj.FolderName);
                 success = false;
                 return;
             end
             currentFile = obj.getCurrentFile;
             for i = 1:length(currentFile)
                 movefile(fullfile(obj.getPath, currentFile{i}), currentFile{i})
                 fprintf("Đã di chuyển file %s ra ngoài folder %s", currentFile{i}, obj.getFolderName);
             end

             [status, msg] = rmdir(targetPath);

             if status == 1
                 obj.Exist = false;

                 fprintf('Folder has been deleted: %s\n', targetPath);
                 success = true;
             else
                 error('Error: %s.', msg);
             end
         end
         function success = moveFile(obj, fileName, overwrite)
             num = obj.changeInputType(fileName, "int");
             if obj.isWebFile(num) == false
                 success = false;
                 return
             end
             if obj.isFileExist(fileName) == true && overwrite == false
                 success = false;
                 warning(sprintf("File %s da ton tai, neu muon ghi de, hay them tham so overwrite = true", fileName));
                 return
             end
             %copy file
             [status, msg] = copyfile(fileName, obj.getPath, 'f');

             if status == false
                 success = false;
                 error(sprintf("Error %s\n", msg));
             else
                 fprintf("Đã chuyển file %s vào thư mục %s\n", fileName, obj.getPath);
                 success = true;
             end
         end
         function success = openFile(obj, fileName)
            fileName = obj.changeInputType(fileName, "string");
            if obj.isFileExist(fileName)
                edit(fullfile(obj.getFolderName, fileName));
                success = true;
            else
                success = false;
            end
         end

         function output = changeInputType(obj, input, outputType)
            if isnumeric(input)
                num = input;
                str = sprintf("problem%05d.m", input);
            elseif isstring(input) || ischar(input)
                str = input;
                num = regexp(input, "\d{5}", "match", "once");
            else
                error(sprintf("Input không hợp lệ (không phải string hoặc numeric)"));
            end

            if outputType == "int"
                output = num;
            elseif outputType == "string"
                output = str;
            else
                output = false;
                error(sprintf("Output Type không hợp lệ, chỉ chấp nhận int hoặc string"));
            end
        

         end
         function printProperties(obj)
             fprintf("Folder Name: %s\n", obj.getFolderName);
             fprintf("Path: %s\n", obj.getPath);
             fprintf("Exist : %d", obj.Exist);
             web_file = obj.getWebFile
         end
    end
end