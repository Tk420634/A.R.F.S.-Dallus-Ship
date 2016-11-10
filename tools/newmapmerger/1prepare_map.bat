SET z_levels=7
cd ../../_maps/map_files/CitadelStation

FOR /L %%i IN (1,1,%z_levels%) DO (
  copy CitadelStation.0%%i.dmm CitadelStation.0%%i.dmm.backup
)

pause
