view wave 
wave clipboard store
wave create -driver freeze -pattern clock -initialvalue HiZ -period 100ps -dutycycle 50 -starttime 0ps -endtime 2000ps sim:/Diretorio/Clock 
WaveCollapseAll -1
wave clipboard restore
