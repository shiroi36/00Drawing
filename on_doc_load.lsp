;on_doc_load.lspだと、図面を開くたびに実行してくれないから、
;cir_dir が変わらない

(setq cur_dir (getvar "dwgprefix"))
(setq path (strcat cur_dir "00_frame"))
(load path)
(setq path (strcat cur_dir "01_frame"))
(load path)
(setq path (strcat cur_dir "02_frame"))
(load path)
(setq path (strcat cur_dir "99_共通事項"))
(load path)
