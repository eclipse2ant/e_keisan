@echo off
if not "%E_KEISAN%"=="" ( jruby -E utf-8 -W0 %E_KEISAN%\keisan.rb %1 >log.txt ) else ( jruby -E utf-8 -W0 keisan.rb %1 >log.txt )


