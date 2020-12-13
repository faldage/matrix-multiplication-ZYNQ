onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/clk
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/rst
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/axi_receive_fifo_almost_empty_0
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/axi_receive_fifo_almost_full_0
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tdata
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tkeep
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tlast
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tready
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tvalid
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/axi_send_fifo_almost_empty_0
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/axi_send_fifo_almost_full_0
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/S_AXIS_Send_tdata
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/S_AXIS_Send_tkeep
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/S_AXIS_Send_tlast
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/S_AXIS_Send_tready
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/S_AXIS_Send_tvalid
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tdata_ff1
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tdata_ff2
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tvalid_ff1
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/M_AXIS_Recive_tvalid_ff2
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/flag
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/valid
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/eop
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/transmod
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/data
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/row
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/column
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/valid_o
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/eop_o
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/data_o
add wave -noupdate /SMVM_convert_tb/U_SMVM_convert/transmod_f1
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {284532 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 226
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 1
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ms
update
WaveRestoreZoom {59274 ps} {577541 ps}
