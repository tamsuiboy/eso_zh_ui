@echo off

REM 老滚安装路径
set ESO_PATH=F:\Program Files (x86)\SteamLibrary\steamapps\common\Zenimax Online\The Elder Scrolls Online

REM 要合并的翻译文件，文件名不要有空格
set TRANSLATE_FILE=ESO_套装名_V0.3.xlsx


set /p datestr="请输入文件后缀: (例如: 20180204)"
echo %datestr%
mkdir ..\..\输出\更新翻译\
mkdir ..\..\输出\更新翻译\1_new\
mkdir ..\..\输出\更新翻译\2_diff\
mkdir ..\..\输出\更新翻译\4_old\
del /Q ..\..\输出\更新翻译\1_new\*
del /Q ..\..\输出\更新翻译\4_old\*

set MNF_PATH="%ESO_PATH%\depot\eso.mnf"
echo %MNF_PATH%
echo ###正在解压...
rem del /Q .\extract\*
rem EsoExtractData.exe %MNF_PATH% -a 0 .\extract
rem EsoExtractData.exe %MNF_PATH% -a 2 .\extract

echo ###正在复制...
copy extract\gamedata\lang\en.lang.csv ..\..\translation\lang\
copy extract\gamedata\lang\jp.lang.csv ..\..\translation\lang\
copy extract\esoui\lang\en_pregame.lua ..\..\translation\
copy extract\esoui\lang\en_client.lua ..\..\translation\

echo ###正在拆分...
cd ../../scripts
rem python split_lang_csv_by_id.py
rem python split_lang_csv_by_id.py -l jp

echo ###正在提取...
rem python prepare_lang.py --all
copy ..\translation\lang\en.*s.lang.xlsx ..\输出\更新翻译\1_new\

del /Q ..\translation\zh_translate.txt
python convert_lua_to_txt.py
python convert_txt_to_xls.py
copy ..\translation\zh_translate.xlsx ..\输出\更新翻译\1_new\
python rename_lang_xls.py %datestr% ../输出/更新翻译/1_new/

echo 完成，请把旧的文件拷贝到 4_old\ 中
cd ..\输出\更新翻译
explorer .

pause