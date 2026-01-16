
@ECHO O
rem githubのDrawingとつながっているフォルダです。
set path2=%userprofile%\Documents\git\00Drawings\
set path1=%cd%
rem path2に新たに作成するフォルダ名です。
set dname=川翔新三芳初期案

@ECHO OFF
 
:INPUT_START
ECHO +-------------------------------------------------------+
ECHO  gitにアップロードするコメントを入力してください。
ECHO +-------------------------------------------------------+
SET INPUT_STR=
SET /P INPUT_STR=
 
IF "%INPUT_STR%"=="" GOTO :INPUT_START
 
:INPUT_CONF
ECHO +-------------------------------------------------------+
ECHO  入力した文字は[%INPUT_STR%]でよろしいですか？
ECHO （Y / N）
ECHO +-------------------------------------------------------+
SET CONF_SELECT=
SET /P CONF_SELECT=
 
IF "%CONF_SELECT%"== SET CONF_SELECT=Y
IF /I NOT "%CONF_SELECT%"=="Y"  GOTO :INPUT_START


ECHO +----githubにアップデートする処理を行います-------------+
ECHO +----コメントは-----------------------------------------+
ECHO +----[%INPUT_STR%]----+

@ECHO ON


cd %path2%
git fetch origin master
git reset --hard origin/master
cd %path1%


mkdir %path2%%dname%
copy *.dwg %path2%%dname%\
copy *.lsp %path2%%dname%\
copy *.scr %path2%%dname%\
copy *.dsd %path2%%dname%\
copy *.bat %path2%%dname%\
xcopy /Y 99_PDF\*.pdf %path2%%dname%\99_PDF\
xcopy /Y 99_PDF\*.bat %path2%%dname%\99_PDF\

cd %path2%
git add .
git commit -m %INPUT_STR%
git push origin master
explorer %path2%%dname%

@ECHO OFF

ECHO +-------------------終了しました------------------------+


:INPUT_END
ECHO +-------------------------------------------------------+
ECHO  完了しました。
ECHO +-------------------------------------------------------+
 
PAUSE
EXIT



