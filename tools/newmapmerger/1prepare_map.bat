SET z_levels=7
cd ../../_maps/map_files/ARFS

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy z0%%i.dmm z0%%i.dmm.backup
)

pause
