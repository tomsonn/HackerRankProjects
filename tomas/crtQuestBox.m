function [] = crtQuestBox()

quest = 'Sedia absolutne suradnice skenov?';
title = 'BROB';
btn1 = 'Ano';
btn2 = 'Nie';
btn3 = 'Cancel';
default = btn3;
questdlg(quest, title, btn1, btn2, btn3, default);

end

