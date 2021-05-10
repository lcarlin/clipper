function browse         
parameters t, l, b, r
private n, move_chrs, force_rec, ntx_expr, ntx_eval, prev_rec, is_append, any_append, keystroke, e_field, get_data

if empty (fieldname (1))

   return .f.

endif

save screen

if pcount () < 4
   t = 1
   l = 0
   b = 23
   r = 79

else 

   @ m->t, m->l, m->b, m->r box 'ÕÍ¸³¾ÍÔ³'
   @ m->t + 3, m->l say 'Æ' 
   @ m->t + 3, m->r say 'µ' 


   t = m->t + 1
   l = m->l + 1
   b = m->b - 1
   r = m->r - 1

endif

private field_list [fcount ()]

for n = 1 to fcount ()

   field_list [m->n] = fieldname (m->n)

next


move_chrs = chr (24) + chr (5) + chr (3) + chr (18) + chr (31) + chr (30)

if eof ()
   goto top

endif


force_rec = .t.
is_append = .f.
any_append = .f.
prev_rec = 0

if lastrec () = 0

   keyboard chr (24)

endif

@ m->t, m->l say space (m->r - m->l + 1) 
dbedit (m->t + 1, m->l, m->b, m->r, m->field_list, 'xbrowse', 0, 0, ' Í', ' ')

restore screen
return .t.







function xbrowse        
parameters mode, f_script
private ret_val

ret_val = 1


keystroke = lastkey ()


e_field = field_list [m->f_script]

if m->prev_rec != recno ()

   prev_rec = recno ()
   force_rec = .t.

endif

do case

   case m->mode = 0


      if chr (m->keystroke) $ m->move_chrs .or. m->force_rec

         statline ()

      endif

   case m->mode = 1


      if m->is_append

         ret_val = iif (m->any_append, 2, 3)
         is_append = .f.
         any_append = .f.

      else 

         if ! eof ()

            @ m->t, m->r - 20 say pad (ltrim (str (recno ())) + '/' + ltrim (str (lastrec ())), 15) + ' <bof>' 


         endif
      endif

      force_rec = .t.

   case m->mode = 2


      if m->is_append


         if m->keystroke = 24 .and. ! eof ()

            ret_val = 3

         else 

            if m->keystroke = 30

               ret_val = iif (m->any_append, 2, 3)
               is_append = .f.
               any_append = .f.

            else 


               if m->force_rec

                  statline ()

               endif
            endif
         endif

      else 

         if m->keystroke = 24

            ret_val = 3
            is_append = .t.

         else 

            if ! eof ()

               @ m->t, m->r - 20 say pad (ltrim (str (recno ())) + '/' + ltrim (str (lastrec ())), 15) + ' <eof>' 


            endif
         endif
      endif

      force_rec = .t.

   case m->mode = 3


      if m->keystroke = 24

         ret_val = 3
         is_append = .t.
         force_rec = .t.

      else 

         statline ()

      endif

   case m->mode = 4


      do case

         case m->keystroke = 27

            ret_val = 0

         case m->keystroke = 7 .and. ! eof () .and. lastrec () != 0


            if deleted ()
               recall

            else 
               delete

            endif


            statline ()

         case m->keystroke = 13 .and. (m->is_append .or. ! eof () .and. lastrec () != 0)


            ntx_expr = indexkey (0)

            if ! empty (m->ntx_expr)

               ntx_eval = &ntx_expr

            endif

            set cursor on


            get_data = &e_field


            set key 5 to clear_gets
            set key 24 to clear_gets


            @ row (), col () get get_data picture get_pic (m->e_field)
            read
            keystroke = lastkey ()


            set key 5 to 
            set key 24 to 

            if m->keystroke != 27 .and. updated ()


               if m->is_append .and. eof ()

                  append blank 
                  any_append = .t.


                  statline ()

               endif


               replace &e_field with m->get_data

            endif

            set cursor off

            if ! empty (m->ntx_expr) .and. ! m->is_append


               if m->ntx_eval != &ntx_expr

                  ret_val = 2

               endif
            endif

            if m->ret_val != 2


               do case

                  case m->keystroke = 5


                     if m->is_append

                        ret_val = iif (m->any_append, 2, 3)
                        is_append = .f.
                        any_append = .f.

                     else 

                        keyboard chr (5)

                     endif

                  case m->keystroke = 18


                     if m->is_append

                        ret_val = iif (m->any_append, 2, 3)
                        is_append = .f.
                        any_append = .f.

                     else 

                        keyboard chr (5)

                     endif

                  case m->keystroke = 24

                     keyboard chr (24)

                  case m->keystroke = 3 .and. ! m->is_append

                     keyboard chr (24)

                  case m->keystroke = 13

                     keyboard chr (4)

               endcase
            endif
      endcase
endcase

return m->ret_val







function statline       
@ m->t, m->r - 27 say 'Record ' 
if lastrec () = 0 .and. ! m->is_append

   @ m->t, m->r - 20 say '<none>               ' 

else 

   if eof ()

      @ m->t, m->r - 40 say '         ' 
      @ m->t, m->r - 20 say '                ' + iif (m->is_append, '<new>', '<eof>') 


   else 

      @ m->t, m->r - 40 say iif (deleted (), '<Deleted>', '         ') 
      @ m->t, m->r - 20 say pad (ltrim (str (recno ())) + '/' + ltrim (str (lastrec ())), 21) 


   endif
endif


force_rec = .f.
return 0







function pad            
parameters string, length
return substr (string + space (length), 1, length)






procedure clear_gets    
parameters dummy1, dummy2, dummy3
clear gets 
return



















function get_pic        
parameters field
private pstring, s
do case

   case type (m->field) = 'C'

      pstring = '@KS' + ltrim (str (min (len (&field), 78)))

   case type (m->field) = 'N'

      s = str (&field)

      if '.' $ m->s

         pstring = replicate ('9', at ('.', m->s) - 1) + '.'
         pstring = pstring + replicate ('9', len (m->s) - len (m->pstring))

      else 

         pstring = replicate ('9', len (m->s))

      endif

   otherwise

      pstring = ''

endcase

return pstring







function ampm           
parameters cl_time
return iif (val (cl_time) < 12, cl_time + ' am', iif (val (cl_time) = 12, cl_time + ' pm', str (val (cl_time) - 12, 2) + substr (cl_time, 3) + ' pm'))

























function strzero        
parameters cl_num, cl_len, cl_dec
private cl_str

do case
   case pcount () = 3
      cl_str = str (cl_num, cl_len, cl_dec)

   case pcount () = 2
      cl_str = str (cl_num, cl_len)

   otherwise
      cl_str = str (cl_num)

endcase

if '-' $ cl_str

   return '-' + replicate ('0', len (cl_str) - len (ltrim (cl_str))) + substr (cl_str, at ('-', cl_str) + 1)

else 
   return replicate ('0', len (cl_str) - len (ltrim (cl_str))) + ltrim (cl_str)
endif













function days           
parameters cl_secs
return int (cl_secs / 86400)









function dbf            
return alias ()









function elaptime       
parameters cl_start, cl_end
return tstring (iif (cl_end < cl_start, 86400, 0) + secs (cl_end) - secs (cl_start))






function tstring        
parameters cl_secs
return strzero (int (mod (cl_secs / 3600, 24)), 2, 0) + ':' + strzero (int (mod (cl_secs / 60, 60)), 2, 0) + ':' + strzero (int (mod (cl_secs, 60)), 2, 0)









function secs           
parameters cl_time
return val (cl_time) * 3600 + val (substr (cl_time, 4)) * 60 + val (substr (cl_time, 7))









function fklabel        
parameters cl_1
return iif (cl_1 <= 40 .and. cl_1 > 0, 'F' + ltrim (str (cl_1)), '')









function fkmax          
return 40






function lennum         
parameters cl_number
return len (ltrim (str (cl_number)))











































function mod            
parameters cl_num, cl_base
private cl_result
cl_result = cl_num % cl_base
return iif (cl_base = 0, cl_num, iif (cl_result * cl_base < 0, cl_result + cl_base, cl_result))








function os             
return 'MS/PC-DOS'





























function readkey        
do case
   case lastkey () = 18
      return 6 + iif (updated (), 256, 0)
   case lastkey () = 3
      return 7 + iif (updated (), 256, 0)
   case lastkey () = 27
      return 12 + iif (updated (), 256, 0)
   case lastkey () = 23
      return 14 + iif (updated (), 256, 0)
   case lastkey () = 13
      return 15 + iif (updated (), 256, 0)
   case lastkey () = 31
      return 34 + iif (updated (), 256, 0)
   case lastkey () = 30
      return 35 + iif (updated (), 256, 0)
   case lastkey () >= 32
      return 15 + iif (updated (), 256, 0)
   otherwise
      return 0
endcase











function version        
return "Clipper, Summer '87"
