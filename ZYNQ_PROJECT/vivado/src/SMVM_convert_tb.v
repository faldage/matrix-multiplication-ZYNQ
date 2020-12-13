`timescale 1ns/1ps

module SMVM_convert_tb();

reg                   clk                            ; //
reg                   rst                            ; //
reg                   axi_receive_fifo_almost_empty_0; //
reg                   axi_receive_fifo_almost_full_0 ; //
reg     [  31:   0]   M_AXIS_Recive_tdata            ; 
reg     [   3:   0]   M_AXIS_Recive_tkeep            ; //
reg                   M_AXIS_Recive_tlast            ; //
wire                  M_AXIS_Recive_tready           ; 
reg                   M_AXIS_Recive_tvalid           ; 
reg                   axi_send_fifo_almost_empty_0   ; //
reg                   axi_send_fifo_almost_full_0    ; //
wire  signed  [  31:   0]   S_AXIS_Send_tdata              ; 
wire    [   3:   0]   S_AXIS_Send_tkeep              ; 
wire                  S_AXIS_Send_tlast              ; 
reg                   S_AXIS_Send_tready             ; //
wire                  S_AXIS_Send_tvalid             ; 

always #5 clk=~clk;

reg [63:0] send_r [38447:0];

integer fr, i, rd;
initial begin
    fr = $fopen("E:/workspace/Intelligent_Computing_Architectures/proj/SMVM_onboard/python/send.dat","r");
    i = 0;
    while (!$feof(fr)) begin
        rd = $fscanf(fr, "%h", send_r[i]);
        i = i + 1;
    end 
    $fclose(fr);
end

integer fw;
integer k;
initial begin
    fw = $fopen("E:/workspace/Intelligent_Computing_Architectures/proj/SMVM_onboard/sim_out.dat","w");
    clk <= 1'b1;
    rst <= 1'b1;
    axi_receive_fifo_almost_full_0 <= 1'b0;
    S_AXIS_Send_tready <= 1'b1;

    M_AXIS_Recive_tvalid <= 1'b0;
    M_AXIS_Recive_tdata <= 32'b0;
    # 100;
    rst <= 1'b0;
    for (k=0;k<38448;k=k+1) begin
        M_AXIS_Recive_tvalid <= 1'b1;
        M_AXIS_Recive_tdata <= {send_r[k][39:32],send_r[k][47:40],send_r[k][55:48],send_r[k][63:56]};
        # 10;
        M_AXIS_Recive_tvalid <= 1'b1;
        M_AXIS_Recive_tdata <= {send_r[k][7:0],send_r[k][15:8],send_r[k][23:16],send_r[k][31:24]};
        # 10;
    end
    M_AXIS_Recive_tvalid <= 1'b0;
    M_AXIS_Recive_tdata <= 32'b0;
    #500
    $fclose(fw);
    $stop;
end

reg  [31:0] wdata_h;
wire [31:0] wdata_l;
wire signed [63:0] wdata;
reg wflag;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        wflag <= 1'b0;
    end
    else if (S_AXIS_Send_tvalid) begin
        wflag <= ~wflag;
    end
    else begin
        wflag <= wflag;
    end
end
always @(posedge clk) begin
    if (S_AXIS_Send_tvalid&(~wflag)) begin
        wdata_h <= {S_AXIS_Send_tdata[7:0],S_AXIS_Send_tdata[15:8],S_AXIS_Send_tdata[23:16],S_AXIS_Send_tdata[31:24]};
    end
    else begin
        wdata_h <= wdata_h;
    end
end

assign wdata_l = S_AXIS_Send_tvalid&wflag?{S_AXIS_Send_tdata[7:0],S_AXIS_Send_tdata[15:8],S_AXIS_Send_tdata[23:16],S_AXIS_Send_tdata[31:24]}:32'b0;
assign wdata = {wdata_h,wdata_l};

always @(posedge clk) begin
    if (S_AXIS_Send_tvalid&wflag) begin
        $fwrite(fw,"%d\n",wdata);
    end
end

SMVM_convert U_SMVM_convert(
    .clk                            (clk                            ),
    .rst                            (rst                            ),
    .axi_receive_fifo_almost_empty_0(axi_receive_fifo_almost_empty_0),
    .axi_receive_fifo_almost_full_0 (axi_receive_fifo_almost_full_0 ),
    .M_AXIS_Recive_tdata            (M_AXIS_Recive_tdata            ),
    .M_AXIS_Recive_tkeep            (M_AXIS_Recive_tkeep            ),
    .M_AXIS_Recive_tlast            (M_AXIS_Recive_tlast            ),
    .M_AXIS_Recive_tready           (M_AXIS_Recive_tready           ),
    .M_AXIS_Recive_tvalid           (M_AXIS_Recive_tvalid           ),
    .axi_send_fifo_almost_empty_0   (axi_send_fifo_almost_empty_0   ),
    .axi_send_fifo_almost_full_0    (axi_send_fifo_almost_full_0    ),
    .S_AXIS_Send_tdata              (S_AXIS_Send_tdata              ),
    .S_AXIS_Send_tkeep              (S_AXIS_Send_tkeep              ),
    .S_AXIS_Send_tlast              (S_AXIS_Send_tlast              ),
    .S_AXIS_Send_tready             (S_AXIS_Send_tready             ),
    .S_AXIS_Send_tvalid             (S_AXIS_Send_tvalid             )
);

endmodule