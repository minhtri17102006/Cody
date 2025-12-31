function arrangeFiles()
    files = dir("*.m");
    file_name = {files.name};
    problem = file_name(cellfun(@(file) ~isempty(regexp(file, "problem\d{5}\.m", "once")), file_name));
    cellfun(@(file) pushFile(file, 1), problem);
end