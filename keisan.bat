@echo off
if not "%E_KEISAN%"=="" ( jruby -E utf-8 -W0 %E_KEISAN%\keisan.rb %1 %2 %3 %4 %52>&1 |%E_KEISAN%\nkf) else ( jruby -E utf-8 -W0 keisan.rb %1 %2 %3 %4 %5 2>&1 |nkf )


