rem shift-jis で保存しました　utf-8の場合は、chcp 65001 を先頭につけてください
rem キャレット^をつけて長い一文を改行しました

set path1=%ONEDRIVE%\00_25webclamp\00熊本戸島2\02設計資料
rem set path1=.
set year=%date:~0,4%
set month=%date:~5,2%
set day=%date:~8,2%

gswin64.exe -q -dNOPAUSE -sDEVICE=pdfwrite ^
-sOUTPUTFILE=%path1%\01_個別計算書_%year%年%month%月%day%日.pdf  ^
-dBATCH ^
%path1%\01_0章目次.pdf ^
%path1%\01_1章_建物概要および構造設計方針.pdf ^
%path1%\01_2章_荷重.pdf ^
%path1%\01_3章_鉄骨両端ピン大梁小梁の検討.pdf ^
%path1%\01_4章_柱脚、柱梁接合部の検討.pdf ^
%path1%\01_5章_一貫計算の補足検討.pdf ^
%path1%\01_6章_RC二次部材およびフーチングの検討.pdf ^
%path1%\01_7章_鉄骨二次部材の検討.pdf

