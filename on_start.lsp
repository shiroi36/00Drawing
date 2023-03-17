;this file will run once when the program starts.
;please do not edit. For custom actions on starting the program please create a file on_start.lsp.

(setq cur_dir (getvar "dwgprefix"))
(setq path (strcat cur_dir "00_frame"))
(load path)
(setq path (strcat cur_dir "01_frame"))
(load path)
(setq path (strcat cur_dir "02_frame"))
(load path)
(setq path (strcat cur_dir "99_ã§í éñçÄ"))
(load path)
