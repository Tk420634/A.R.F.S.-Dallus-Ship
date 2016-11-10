SET z_levels=7
cd 

FOR /L %%i IN (1,1,%z_levels%) DO (
  java -jar MapPatcher.jar -clean ../../_maps/map_files/CitadelStation/CitadelStation.0%%i.dmm.backup ../../_maps/map_files/CitadelStation/CitadelStation.0%%i.dmm ../../_maps/map_files/CitadelStation/CitadelStation.0%%i.dmm
)

pause