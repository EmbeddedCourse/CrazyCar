# 
# Synthesis run script generated by Vivado
# 

set_param xicom.use_bs_reader 1
set_msg_config -id {HDL 9-1061} -limit 100000
set_msg_config -id {HDL 9-1654} -limit 100000
create_project -in_memory -part xc7a100tcsg324-1

set_param project.singleFileAddWarning.threshold 0
set_param project.compositeFile.enableAutoGeneration 0
set_param synth.vivado.isSynthRun true
set_msg_config -source 4 -id {IP_Flow 19-2162} -severity warning -new_severity info
set_property webtalk.parent_dir C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.cache/wt [current_project]
set_property parent.project_path C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.xpr [current_project]
set_property XPM_LIBRARIES {XPM_CDC XPM_MEMORY} [current_project]
set_property default_lib xil_defaultlib [current_project]
set_property target_language VHDL [current_project]
set_property board_part digilentinc.com:nexys4:part0:1.1 [current_project]
set_property ip_repo_paths c:/Users/mi3105is-s/Program/vga_blockdesign/project_2.ip_user_files/ip_repo [current_project]
add_files C:/Users/mi3105is-s/Program/vga_blockdesign/BigCar1.coe
add_files C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/ForegroundBRAM/ForegroundBRAM.bd
set_property used_in_implementation false [get_files -all c:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/ForegroundBRAM/ip/ForegroundBRAM_blk_mem_gen_0_0/ForegroundBRAM_blk_mem_gen_0_0_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/ForegroundBRAM/ForegroundBRAM_ooc.xdc]
set_property is_locked true [get_files C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/ForegroundBRAM/ForegroundBRAM.bd]

add_files C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/clk.bd
set_property used_in_implementation false [get_files -all c:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/ip/clk_clk_wiz_0_1/clk_clk_wiz_0_1_board.xdc]
set_property used_in_implementation false [get_files -all c:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/ip/clk_clk_wiz_0_1/clk_clk_wiz_0_1.xdc]
set_property used_in_implementation false [get_files -all c:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/ip/clk_clk_wiz_0_1/clk_clk_wiz_0_1_ooc.xdc]
set_property used_in_implementation false [get_files -all C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/clk_ooc.xdc]
set_property is_locked true [get_files C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/bd/clk/clk.bd]

read_vhdl -library xil_defaultlib {
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/ref_pack.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/Foreground_Address_Gen.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/imports/hdl/ForegroundBRAM_wrapper.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/VGA.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/Selector_backforth.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/Foreground_top.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/imports/hdl/clk_wrapper.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/Background.vhd
  C:/Users/mi3105is-s/Program/vga_blockdesign/project_2.srcs/sources_1/new/vga_ref.vhd
}
foreach dcp [get_files -quiet -all *.dcp] {
  set_property used_in_implementation false $dcp
}
read_xdc //puma.student.lth.se/mi3105is-s/Downloads/vga_constraints.xdc
set_property used_in_implementation false [get_files //puma.student.lth.se/mi3105is-s/Downloads/vga_constraints.xdc]

read_xdc dont_touch.xdc
set_property used_in_implementation false [get_files dont_touch.xdc]

synth_design -top vga_ref -part xc7a100tcsg324-1


write_checkpoint -force -noxdef vga_ref.dcp

catch { report_utilization -file vga_ref_utilization_synth.rpt -pb vga_ref_utilization_synth.pb }
