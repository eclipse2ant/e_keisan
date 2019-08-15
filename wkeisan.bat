@echo off
if not "%E_KEISAN%"=="" ( jruby -E utf-8 -W0 %E_KEISAN%\keisan.rb %1 %2 %3 %4 %5 >log.txt ) else ( jruby -E utf-8 -W0 keisan.rb %1 %2 %3 %4 %5 >log.txt )


