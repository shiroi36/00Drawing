;this file will run once when the program starts.
;please do not edit. For custom actions on starting the program please create a file on_start.lsp.
;����͐}�ʂ�����p�X�ƈꏏ�ɂ����Ă����Ύ��R�ƌĂ�ł����

(setq cur_dir (getvar "dwgprefix"))
(setq path (strcat cur_dir "00_frame"))
(load path)
(setq path (strcat cur_dir "01_frame"))
(load path)
(setq path (strcat cur_dir "02_frame"))
(load path)
(setq path (strcat cur_dir "99_���ʎ���"))
(load path)


;�����on_start�ɏ������߂΁A���Ԃ�֐��Ăяo�����ł���B

(defun c:zumendwgtest ()

; �g�̊O���Q�Ƃ��o�C���h
(command "-layer" "u" "*" "" )

; �g�̊O���Q�Ƃ��o�C���h
(command "-xref" "b" "99_�g"  )

;�u���b�N�𕪉�
;(command "explode" "pro" "ty" "insert" ""  )

; �t�B�[���h�̃\���b�h���폜 (���C���[�Ŏ���)
(command "erase" "pro" "la" "Defpoints" "" ""   )
(command "erase" "pro" "la" "99_���C�A�E�g�g" "" ""   )
(command "erase" "pro" "la" "*adsk_constraints" "" ""   )

;�}���`�e�L�X�g�𕪉����g�ňꕔtext�R�}���h���g�p���Ă��镔���́A�ϊ�����Ȃ�
(command "explode" "pro" "ty" "mtext" "" )

; �t�B�[���h�̃\���b�h���폜 (�F�Ŏ���)
(command "erase" "pro" "c" "rgb:192,192,192" "" ""  )

;(command  "close" "n" )

(princ))

;�����on_start�ɏ������߂΁A���Ԃ�֐��Ăяo�����ł���B

(defun c:zumendwg ()

; �g�̊O���Q�Ƃ��o�C���h
(command "-layer" "u" "*" "" )

; �g�̊O���Q�Ƃ��o�C���h
(command "-xref" "b" "99_�g"  )

;�u���b�N�𕪉�
;(command "explode" "pro" "ty" "insert" ""  )

; �t�B�[���h�̃\���b�h���폜 (���C���[�Ŏ���)
(command "erase" "pro" "la" "Defpoints" "" ""   )
(command "erase" "pro" "la" "99_���C�A�E�g�g" "" ""   )
(command "erase" "pro" "la" "*adsk_constraints" "" ""   )

;�}���`�e�L�X�g�𕪉����g�ňꕔtext�R�}���h���g�p���Ă��镔���́A�ϊ�����Ȃ�
(command "explode" "pro" "ty" "mtext" "" )

; �t�B�[���h�̃\���b�h���폜 (�F�Ŏ���)
(command "erase" "pro" "c" "rgb:192,192,192" "" ""  )


(foreach n (layoutlist)
  (princ (vl-filename-base (getvar "dwgname")  ) )
  (if (= (vl-filename-base (getvar "dwgname") ) "00_�d�l���Ȃ�" ) 
    (progn
      (princ "00_�d�l���Ȃ�" ) 
      (setvar "ctab" n)
      (command "exportlayout"
        (strcat "99_dwg/99_" (vl-filename-base (getvar "dwgname")) (nth (- (read n) 1) pnum00)  )
       );command
      (command "y" )
    );progn
  );if
  (if (= (vl-filename-base (getvar "dwgname") ) "01_�����}" ) 
    (progn
      (princ "01_�����}" ) 
      (setvar "ctab" n)
      (command "exportlayout"
        (strcat "99_dwg/99_" (vl-filename-base (getvar "dwgname")) (nth (- (read n) 1) pnum01)  )
       );command
      (command "y" )
    );progn
  );if
  (if (= (vl-filename-base (getvar "dwgname") ) "02_���X�g����ѓS���ڍ�" ) 
    (progn
      (princ "02_���X�g����ѓS���ڍ�" ) 
      (setvar "ctab" n)
      (command "exportlayout"
        (strcat "99_dwg/99_" (vl-filename-base (getvar "dwgname")) (nth (- (read n) 1) pnum02)  )
       );command
      (command "y" )
    );progn
  );if
);for

;(command  "close" "n" )

(princ))



;;  Text1MtextJust.lsp [command name: T1MJ]

;;  TXT2MTXT command does not preserve all aspects of justification.  For
;;    one selected Text entity, retains horizontal component [except Aligned/
;;    Fit have Center imposed], but imposes Top for vertical component to
;;    all, regardless of Text entity's original justification.
;;  T1MJ converts each selected Text entity separately to Mtext with same or
;;    equivalent justification as original Text, including vertical component.
;;  "Equivalent" for Text-entity justifications not used with Mtext:
;;    Left/Center/Right become Bottom-Left/Bottom-Center/Bottom-Right;
;;    Middle becomes Middle-Center;
;;    Aligned/Fit become Bottom-Center with new insertion point half-way
;;      between original Text entity's baseline alignment/fit points, so that
;;      any positional change is minimized.
;;  Will sometimes result in slight positional change, depending on specific
;;    justification involved, text font, and/or whether text content includes
;;    characters extending above or below height of capital letters [e.g. lower-
;;    case letters with descenders, parentheses/brackets/braces, slashes, etc.].
;;  Fit-justified Text will retain original height, but lose width adjustment.
;;  Kent Cooper, 18 February 2014

(defun C:T1MJ ; = Text to 1-line Mtext, retaining Justification
  (/ *error* cmde tss inc tent tobj tins tjust)

  (defun *error* (errmsg)
    (if (not (wcmatch errmsg "Function cancelled,quit / exit abort,console break"))
      (princ (strcat "\nError: " errmsg))
    ); if
    (command "_.undo" "_end")
    (setvar 'cmdecho cmde)
    (princ)
  ); defun - *error*

  (setq cmde (getvar 'cmdecho))
  (setvar 'cmdecho 0)
  (command "_.undo" "_begin")
  (prompt "\nTo change Text to 1-line Mtext, preserving Justification,")
  (if (setq tss (ssget "_:L" '((0 . "TEXT"))))
    (repeat (setq inc (sslength tss))
      (setq
        tent (ssname tss (setq inc (1- inc)))
        tobj (vlax-ename->vla-object tent)
        tins (vlax-get tobj 'TextAlignmentPoint)
        tjust (vla-get-Alignment tobj)
      ); setq
      (cond
        ((= tjust 0) (setq tjust 7 tins (vlax-get tobj 'InsertionPoint))); Left
        ((< tjust 3) (setq tjust (+ tjust 7))); 1/2 [Center/Right] to 7/8/9
        ((= tjust 4) (setq tjust 5)); Middle to Middle-Center
        ((member tjust '(3 5)); Aligned/Fit
          (setq
            tjust 8 ; to Bottom-Center
            tins (mapcar '/ (mapcar '+ (vlax-get tobj 'InsertionPoint) tins) '(2 2 2))
              ; with new insertion point
          ); setq
        ); Aligned/Fit
        ((setq tjust (- tjust 5))); all vertical-horizontal pair justifications
      ); cond
      (command "_.txt2mtxt" tent ""); convert, then
      (setq tobj (vlax-ename->vla-object (entlast))); replace Text with new Mtext
      (vla-put-AttachmentPoint tobj tjust); original Text's justification [or equiv.]
      (vlax-put tobj 'InsertionPoint tins); original Text's insertion
    ); repeat
  ); if
  (command "_.undo" "_end")
  (setvar 'cmdecho cmde)
  (princ)
); defun -- T1MJ
(vl-load-com)
(prompt "\nType T1MJ to change Text to 1-line Mtext, preserving Justification.")