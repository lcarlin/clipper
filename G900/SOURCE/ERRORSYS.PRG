return





function expr_error     
parameters name, line, info, model, _1, _2, _3
set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', ' + m->info 


quit

return .f.






function undef_erro     
parameters name, line, info, model, _1
set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', ' + m->info + ' ' + m->_1 


quit

return .t.






function misc_error     
parameters name, line, info, model
set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', ' + m->info 




quit

return .f.






function open_error     
parameters name, line, info, model, _1
if neterr () .and. model == 'USE'
   return .f.
endif

set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', ' + m->info + ' ' + m->_1 + ' (' + ltrim (str (doserror ())) + ')' 

@ 0, 65 say 'Retry? (Y/N)' 

inkey (0)

do while ! chr (lastkey ()) $ 'YyNn'
   inkey (0)
enddo

if ! chr (lastkey ()) $ 'Yy'
   quit
endif

@ 0, 0 

return .t.






function db_error       
parameters name, line, info
set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', ' + m->info 




quit

return .f.






function print_erro     
parameters name, line
set device to screen
@ 0, 0 
@ 0, 0 say 'Proc ' + m->name + ' line ' + ltrim (str (m->line)) + ', printer not ready' 


@ 0, 65 say 'Retry? (Y/N)' 

inkey (0)

do while ! chr (lastkey ()) $ 'YyNn'
   inkey (0)
enddo

if ! chr (lastkey ()) $ 'Yy'
   quit
endif

@ 0, 0 

return .t.
