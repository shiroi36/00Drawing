
@ECHO O
rem github��Drawing�ƂȂ����Ă���t�H���_�ł��B
set path2=%userprofile%\Documents\git\00Drawings\
set path1=%cd%
rem path2�ɐV���ɍ쐬����t�H���_���ł��B
set dname=���ĐV�O�F������

@ECHO OFF
 
:INPUT_START
ECHO +-------------------------------------------------------+
ECHO  git�ɃA�b�v���[�h����R�����g����͂��Ă��������B
ECHO +-------------------------------------------------------+
SET INPUT_STR=
SET /P INPUT_STR=
 
IF "%INPUT_STR%"=="" GOTO :INPUT_START
 
:INPUT_CONF
ECHO +-------------------------------------------------------+
ECHO  ���͂���������[%INPUT_STR%]�ł�낵���ł����H
ECHO �iY / N�j
ECHO +-------------------------------------------------------+
SET CONF_SELECT=
SET /P CONF_SELECT=
 
IF "%CONF_SELECT%"== SET CONF_SELECT=Y
IF /I NOT "%CONF_SELECT%"=="Y"  GOTO :INPUT_START


ECHO +----github�ɃA�b�v�f�[�g���鏈�����s���܂�-------------+
ECHO +----�R�����g��-----------------------------------------+
ECHO +----[%INPUT_STR%]----+

@ECHO ON


cd %path2%
git pull origin master
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

ECHO +-------------------�I�����܂���------------------------+


:INPUT_END
ECHO +-------------------------------------------------------+
ECHO  �������܂����B
ECHO +-------------------------------------------------------+
 
PAUSE
EXIT



