# PDF-generating modes are:
# 1: pdflatex, as specified by $pdflatex variable (still largely in use)
# 2: postscript conversion, as specified by the $ps2pdf variable (useless)
# 3: dvi conversion, as specified by the $dvipdf variable (useless)
# 4: lualatex, as specified by the $lualatex variable (best)
# 5: xelatex, as specified by the $xelatex variable (second best)
$pdf_mode = 4;

# Treat undefined references and citations as well as multiply defined
# references as ERRORS instead of WARNINGS. This is only checked in the *last*
# run, since naturally, there are undefined references in initial runs.
$warnings_as_errors = 1;

# Show used CPU time
$show_time = 1;

# -file-line-error: Report file and line number for errors
# -halt-on-error: Stop processing at the first error
# -interaction=nonstopmode: Never prompt for user input
# -synctex=1: Enable SyncTeX for editor-PDF synchronization
set_tex_cmds('-file-line-error -halt-on-error -interaction=nonstopmode -synctex=1 %O %S');
