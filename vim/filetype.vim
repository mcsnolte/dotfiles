if exists("did_load_filetypes")
	finish
endif

augroup filetypedetect
	au BufNewFile,BufRead *.t setf perl

	" Strip off .svn-base from file name for determining type
	" Taken from http://stackoverflow.com/questions/3324644/svn-diff-with-vim-but-with-the-proper-filetype
	autocmd! BufRead    *.svn-base execute 'doautocmd filetypedetect BufRead ' . expand('%:r')
	autocmd! BufNewFile *.svn-base execute 'doautocmd filetypedetect BufNewFile ' . expand('%:r')

    au BufNewFile,BufRead *.tt* setf tt2

    "TT2 and HTML"
    :let b:tt2_syn_tags = '\[% %] <!-- -->'

augroup END
