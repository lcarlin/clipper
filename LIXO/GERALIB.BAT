@ echo off
del cs001.lib
clipper cs001 /m /n
IF NOT ERRORLEVEL = 1 lib cs001 cs001.obj+winclas.obj+popmenu.obj+msgclass.obj
IF NOT ERRORLEVEL = 1 COPY CS001.LIB C:\CLIPPER5\LIB
