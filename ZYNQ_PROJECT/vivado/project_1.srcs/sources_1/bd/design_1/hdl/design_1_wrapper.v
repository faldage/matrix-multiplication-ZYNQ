//Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
//Date        : Wed Nov 25 01:51:58 2020
//Host        : F534-Server running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (DDR_addr,
    DDR_ba,
    DDR_cas_n,
    DDR_ck_n,
    DDR_ck_p,
    DDR_cke,
    DDR_cs_n,
    DDR_dm,
    DDR_dq,
    DDR_dqs_n,
    DDR_dqs_p,
    DDR_odt,
    DDR_ras_n,
    DDR_reset_n,
    DDR_we_n,
    FCLK_CLK0_0,
    FCLK_RESET0_N,
    FIXED_IO_ddr_vrn,
    FIXED_IO_ddr_vrp,
    FIXED_IO_mio,
    FIXED_IO_ps_clk,
    FIXED_IO_ps_porb,
    FIXED_IO_ps_srstb,
    M_AXIS_Recive_tdata,
    M_AXIS_Recive_tkeep,
    M_AXIS_Recive_tlast,
    M_AXIS_Recive_tready,
    M_AXIS_Recive_tvalid,
    S_AXIS_Send_tdata,
    S_AXIS_Send_tkeep,
    S_AXIS_Send_tlast,
    S_AXIS_Send_tready,
    S_AXIS_Send_tvalid,
    axi_receive_fifo_almost_empty_0,
    axi_receive_fifo_almost_full_0,
    axi_send_fifo_almost_empty_0,
    axi_send_fifo_almost_full_0);
  inout [14:0]DDR_addr;
  inout [2:0]DDR_ba;
  inout DDR_cas_n;
  inout DDR_ck_n;
  inout DDR_ck_p;
  inout DDR_cke;
  inout DDR_cs_n;
  inout [3:0]DDR_dm;
  inout [31:0]DDR_dq;
  inout [3:0]DDR_dqs_n;
  inout [3:0]DDR_dqs_p;
  inout DDR_odt;
  inout DDR_ras_n;
  inout DDR_reset_n;
  inout DDR_we_n;
  output FCLK_CLK0_0;
  output FCLK_RESET0_N;
  inout FIXED_IO_ddr_vrn;
  inout FIXED_IO_ddr_vrp;
  inout [53:0]FIXED_IO_mio;
  inout FIXED_IO_ps_clk;
  inout FIXED_IO_ps_porb;
  inout FIXED_IO_ps_srstb;
  output [31:0]M_AXIS_Recive_tdata;
  output [3:0]M_AXIS_Recive_tkeep;
  output M_AXIS_Recive_tlast;
  input M_AXIS_Recive_tready;
  output M_AXIS_Recive_tvalid;
  input [31:0]S_AXIS_Send_tdata;
  input [3:0]S_AXIS_Send_tkeep;
  input S_AXIS_Send_tlast;
  output S_AXIS_Send_tready;
  input S_AXIS_Send_tvalid;
  output axi_receive_fifo_almost_empty_0;
  output axi_receive_fifo_almost_full_0;
  output axi_send_fifo_almost_empty_0;
  output axi_send_fifo_almost_full_0;

  wire [14:0]DDR_addr;
  wire [2:0]DDR_ba;
  wire DDR_cas_n;
  wire DDR_ck_n;
  wire DDR_ck_p;
  wire DDR_cke;
  wire DDR_cs_n;
  wire [3:0]DDR_dm;
  wire [31:0]DDR_dq;
  wire [3:0]DDR_dqs_n;
  wire [3:0]DDR_dqs_p;
  wire DDR_odt;
  wire DDR_ras_n;
  wire DDR_reset_n;
  wire DDR_we_n;
  wire FCLK_CLK0_0;
  wire FCLK_RESET0_N;
  wire FIXED_IO_ddr_vrn;
  wire FIXED_IO_ddr_vrp;
  wire [53:0]FIXED_IO_mio;
  wire FIXED_IO_ps_clk;
  wire FIXED_IO_ps_porb;
  wire FIXED_IO_ps_srstb;
  wire [31:0]M_AXIS_Recive_tdata;
  wire [3:0]M_AXIS_Recive_tkeep;
  wire M_AXIS_Recive_tlast;
  wire M_AXIS_Recive_tready;
  wire M_AXIS_Recive_tvalid;
  wire [31:0]S_AXIS_Send_tdata;
  wire [3:0]S_AXIS_Send_tkeep;
  wire S_AXIS_Send_tlast;
  wire S_AXIS_Send_tready;
  wire S_AXIS_Send_tvalid;
  wire axi_receive_fifo_almost_empty_0;
  wire axi_receive_fifo_almost_full_0;
  wire axi_send_fifo_almost_empty_0;
  wire axi_send_fifo_almost_full_0;

  design_1 design_1_i
       (.DDR_addr(DDR_addr),
        .DDR_ba(DDR_ba),
        .DDR_cas_n(DDR_cas_n),
        .DDR_ck_n(DDR_ck_n),
        .DDR_ck_p(DDR_ck_p),
        .DDR_cke(DDR_cke),
        .DDR_cs_n(DDR_cs_n),
        .DDR_dm(DDR_dm),
        .DDR_dq(DDR_dq),
        .DDR_dqs_n(DDR_dqs_n),
        .DDR_dqs_p(DDR_dqs_p),
        .DDR_odt(DDR_odt),
        .DDR_ras_n(DDR_ras_n),
        .DDR_reset_n(DDR_reset_n),
        .DDR_we_n(DDR_we_n),
        .FCLK_CLK0_0(FCLK_CLK0_0),
        .FCLK_RESET0_N(FCLK_RESET0_N),
        .FIXED_IO_ddr_vrn(FIXED_IO_ddr_vrn),
        .FIXED_IO_ddr_vrp(FIXED_IO_ddr_vrp),
        .FIXED_IO_mio(FIXED_IO_mio),
        .FIXED_IO_ps_clk(FIXED_IO_ps_clk),
        .FIXED_IO_ps_porb(FIXED_IO_ps_porb),
        .FIXED_IO_ps_srstb(FIXED_IO_ps_srstb),
        .M_AXIS_Recive_tdata(M_AXIS_Recive_tdata),
        .M_AXIS_Recive_tkeep(M_AXIS_Recive_tkeep),
        .M_AXIS_Recive_tlast(M_AXIS_Recive_tlast),
        .M_AXIS_Recive_tready(M_AXIS_Recive_tready),
        .M_AXIS_Recive_tvalid(M_AXIS_Recive_tvalid),
        .S_AXIS_Send_tdata(S_AXIS_Send_tdata),
        .S_AXIS_Send_tkeep(S_AXIS_Send_tkeep),
        .S_AXIS_Send_tlast(S_AXIS_Send_tlast),
        .S_AXIS_Send_tready(S_AXIS_Send_tready),
        .S_AXIS_Send_tvalid(S_AXIS_Send_tvalid),
        .axi_receive_fifo_almost_empty_0(axi_receive_fifo_almost_empty_0),
        .axi_receive_fifo_almost_full_0(axi_receive_fifo_almost_full_0),
        .axi_send_fifo_almost_empty_0(axi_send_fifo_almost_empty_0),
        .axi_send_fifo_almost_full_0(axi_send_fifo_almost_full_0));
endmodule
