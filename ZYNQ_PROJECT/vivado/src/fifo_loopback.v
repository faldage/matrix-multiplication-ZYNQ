// **************************************************************************
// COPYRIGHT(c) 2020, Xidian University
// All rights reserved.
//
// IP LIB INDEX :      
// IP Name      :      
// File name    :      
// Module name  :      
// Full name    :      
//
// Author       : Dong-Meng 
// Email        : Melvin_Dong@126.com 
// Data         : 2020-09-25 08:40:38
// Version      : V1.0 
// 
// Abstract     :  
// Called by    :  
// 
// Modification history
// -----------------------------------------------------------------
// 
// 
// 
// -----------------------------------------------------------------

// *******************
// TIMESCALE
// ******************* 
`timescale 1ns/1ps 

// *******************
// INFORMATION
// *******************

//*******************
//DEFINE(s)
//*******************
//`define UDLY 1    //Unit delay, for non-blocking assignments in sequential logic

//*******************
//DEFINE MODULE PORT
//*******************
module fifo_loopback(
    input clock,
    // receive fifo
    (*mark_debug = "true"*)input axi_receive_fifo_almost_empty_0,
    (*mark_debug = "true"*)input axi_receive_fifo_almost_full_0,
    (*mark_debug = "true"*)input  [31:0]M_AXIS_Recive_tdata,
    (*mark_debug = "true"*)input  [3:0]M_AXIS_Recive_tkeep,
    (*mark_debug = "true"*)input  M_AXIS_Recive_tlast,
    (*mark_debug = "true"*)output M_AXIS_Recive_tready,
    (*mark_debug = "true"*)input  M_AXIS_Recive_tvalid,

    // send fifo 
    (*mark_debug = "true"*)input axi_send_fifo_almost_empty_0,
    (*mark_debug = "true"*)input axi_send_fifo_almost_full_0,
    (*mark_debug = "true"*)output  [31:0]S_AXIS_Send_tdata,
    (*mark_debug = "true"*)output  [3:0]S_AXIS_Send_tkeep,
    (*mark_debug = "true"*)output  S_AXIS_Send_tlast,
    (*mark_debug = "true"*)input   S_AXIS_Send_tready,
    (*mark_debug = "true"*)output  S_AXIS_Send_tvalid
);





//*******************
//DEFINE LOCAL PARAMETER
//*******************
//Parameter(s)




//*********************
//INNER SIGNAL DECLARATION
//*********************
//REGS
reg   [31:0]M_AXIS_Recive_tdata_ff1;
reg   [3:0]M_AXIS_Recive_tkeep_ff1;
reg   M_AXIS_Recive_tlast_ff1;
reg   M_AXIS_Recive_tvalid_ff1;


//WIRES



//*********************
//INSTANTCE MODULE
//*********************






//*********************
//MAIN CORE
//********************* 

assign    M_AXIS_Recive_tready    =     (axi_receive_fifo_almost_full_0 || ~S_AXIS_Send_tready) ? 1'b0 : 1'b1   ;

always @ (posedge clock)begin
    if (M_AXIS_Recive_tready) begin
        M_AXIS_Recive_tdata_ff1 <= M_AXIS_Recive_tdata;
        M_AXIS_Recive_tkeep_ff1 <= M_AXIS_Recive_tkeep;
        M_AXIS_Recive_tlast_ff1 <= M_AXIS_Recive_tlast;
        M_AXIS_Recive_tvalid_ff1 <= M_AXIS_Recive_tvalid;
    end
    else begin
        M_AXIS_Recive_tdata_ff1 <= 32'b0;
        M_AXIS_Recive_tkeep_ff1 <= 4'b0;
        M_AXIS_Recive_tlast_ff1 <= 1'b0;
        M_AXIS_Recive_tvalid_ff1 <= 1'b0;
    end
end

assign    S_AXIS_Send_tdata    =    M_AXIS_Recive_tdata_ff1    ;
assign    S_AXIS_Send_tkeep    =    M_AXIS_Recive_tkeep_ff1    ;
assign    S_AXIS_Send_tlast    =    M_AXIS_Recive_tlast_ff1    ;
assign    S_AXIS_Send_tvalid    =    M_AXIS_Recive_tvalid_ff1    ;
//*********************
endmodule