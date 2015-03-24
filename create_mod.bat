@echo off

mkdir %1
cd %1

mkdir megafunctions
mkdir modules
mkdir simulation

cd simulation

echo library ieee; > %1_tb.vhd
echo use ieee.std_logic_1164.all; >> %1_tb.vhd
echo use ieee.numeric_std.all; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo entity %1_tb is >> %1_tb.vhd
echo end %1_tb; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo architecture behavioral of %1_tb is >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo component %1 is >> %1_tb.vhd
echo   port ( >> %1_tb.vhd
echo     clk_in                     : in  std_logic; >> %1_tb.vhd
echo     rst_n_in                   : in  std_logic >> %1_tb.vhd
echo   ); >> %1_tb.vhd
echo end component; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo   constant sysclk_period_c     : time      := 25 ns; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo   signal   sysclk              : std_logic := '0'; >> %1_tb.vhd
echo   signal   rst_n               : std_logic := '0'; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo begin  >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo   -- Erzeuge sysclk-Signal >> %1_tb.vhd
echo   system_clock : process >> %1_tb.vhd
echo   begin >> %1_tb.vhd
echo     sysclk ^<= '1'; >> %1_tb.vhd
echo     wait for sysclk_period_c/2; >> %1_tb.vhd
echo     sysclk ^<= '0'; >> %1_tb.vhd
echo     wait for sysclk_period_c/2; >> %1_tb.vhd
echo   end process; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo   -- Erzeuge rst_n-Signal >> %1_tb.vhd
echo   system_reset : process >> %1_tb.vhd
echo   begin >> %1_tb.vhd
echo     rst_n ^<= '1'; >> %1_tb.vhd
echo     wait for sysclk_period_c*10; >> %1_tb.vhd
echo     rst_n ^<= '0'; >> %1_tb.vhd
echo     wait for sysclk_period_c*10; >> %1_tb.vhd
echo     rst_n ^<= '1'; >> %1_tb.vhd
echo     wait; >> %1_tb.vhd
echo   end process; >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo socket_%1 : %1 >> %1_tb.vhd
echo   port map ( >> %1_tb.vhd
echo     clk_in                     =^> sysclk, >> %1_tb.vhd
echo     rst_n_in                   =^> rst_n >> %1_tb.vhd
echo   ); >> %1_tb.vhd
echo.  >> %1_tb.vhd
echo end behavioral; >> %1_tb.vhd

echo # wave-file > wave.do
echo onerror {resume} >> wave.do
echo quietly WaveActivateNextPane {} 0 >> wave.do
echo add wave -noupdate /%1_tb/rst_n >> wave.do
echo add wave -noupdate /%1_tb/sysclk >> wave.do
echo TreeUpdate [SetDefaultTree] >> wave.do
echo WaveRestoreCursors {{Cursor 1} {434356 ps} 0} >> wave.do
echo quietly wave cursor active 1 >> wave.do
echo configure wave -namecolwidth 150 >> wave.do
echo configure wave -valuecolwidth 100 >> wave.do
echo configure wave -justifyvalue left >> wave.do
echo configure wave -signalnamewidth 0 >> wave.do
echo configure wave -snapdistance 10 >> wave.do
echo configure wave -datasetprefix 0 >> wave.do
echo configure wave -rowmargin 4 >> wave.do
echo configure wave -childrowmargin 2 >> wave.do
echo configure wave -gridoffset 0 >> wave.do
echo configure wave -gridperiod 1 >> wave.do
echo configure wave -griddelta 40 >> wave.do
echo configure wave -timeline 0 >> wave.do
echo configure wave -timelineunits us >> wave.do
echo update >> wave.do
echo WaveRestoreZoom {0 ps} {1500 ns} >> wave.do

echo # run-file > run.do
echo.  >> run.do  
echo variable SimTime 1500ns >> run.do 
echo.  >> run.do
echo # Create and map the work library  >> run.do
echo vlib work  >> run.do
echo vmap work work  >> run.do
echo.  >> run.do
echo # Compile the VHDL files >> run.do
echo vcom -93 ../%1.vhd >> run.do
echo vcom -93 %1_tb.vhd >> run.do
echo.  >> run.do 
echo # Load the simulator with optimizations turned off >> run.do
echo vsim -novopt work.%1_tb >> run.do
echo.  >> run.do  
echo onerror {resume} >> run.do
echo quietly WaveActivateNextPane {} 0 >> run.do
echo add wave -noupdate /%1_tb/rst_n >> run.do
echo add wave -noupdate /%1_tb/sysclk >> run.do
echo TreeUpdate [SetDefaultTree] >> run.do
echo WaveRestoreCursors {{Cursor 1} {713066 ps} 0} >> run.do
echo quietly wave cursor active 1 >> run.do
echo configure wave -namecolwidth 150 >> run.do
echo configure wave -valuecolwidth 100 >> run.do
echo configure wave -justifyvalue left >> run.do
echo configure wave -signalnamewidth 0 >> run.do
echo configure wave -snapdistance 10 >> run.do
echo configure wave -datasetprefix 0 >> run.do
echo configure wave -rowmargin 4 >> run.do
echo configure wave -childrowmargin 2 >> run.do
echo configure wave -gridoffset 0 >> run.do
echo configure wave -gridperiod 1 >> run.do
echo configure wave -griddelta 40 >> run.do
echo configure wave -timeline 0 >> run.do
echo configure wave -timelineunits us >> run.do
echo update >> run.do
echo WaveRestoreZoom {0 ps} {2715648 ps} >> run.do
echo.  >> run.do
echo run $SimTime >> run.do 
echo.  >> run.do
echo wave zoomrange 0 $SimTime >> run.do
echo.  >> run.do
echo # End simulation >> run.do
echo #quit -sim >> run.do

cd ..

echo library ieee; > %1.vhd
echo use ieee.std_logic_1164.all; >> %1.vhd
echo use ieee.numeric_std.all; >> %1.vhd
echo.  >> %1.vhd
echo entity %1 is >> %1.vhd
echo   port (  >> %1.vhd
echo     clk_in                     : in  std_logic; >> %1.vhd
echo     rst_n_in                   : in  std_logic >> %1.vhd
echo   ); >> %1.vhd
echo end %1; >> %1.vhd
echo.  >> %1.vhd
echo architecture behavioral of %1 is >> %1.vhd
echo.  >> %1.vhd
echo begin  >> %1.vhd
echo.  >> %1.vhd
echo end behavioral; >> %1.vhd

cd ..
