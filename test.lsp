(defun c:test ()

  (foreach n (layoutlist)
    (print n)
    (setvar "ctab" n)
    (command "exportlayout" (strcat "99_dwg/" 99_01�}�ʔԍ�04 "99_" n ) )
    
  )

(princ))