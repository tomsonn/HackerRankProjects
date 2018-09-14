function [gatInputBox] = gatherInput()

prompt = {'Prvy model', 'Druhy model', 'Ulozit ako'};
title = 'Nazvy suborov';
dims = [1 50];
defInput = {'model_3.ply', 'model_4.ply', 'fuzed.ply'};

gatInputBox = inputdlg(prompt, title, dims, defInput);

end

