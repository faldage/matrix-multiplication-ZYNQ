// SMVM_convert.v
module SMVM_convert(
    input   wire                  clk                            ,
    (*mark_debug = "true"*) input   wire                  rst                            ,
    // receive fifo
    input   wire                  axi_receive_fifo_almost_empty_0,
    input   wire                  axi_receive_fifo_almost_full_0 ,
    (*mark_debug = "true"*) input   wire    [  31:   0]   M_AXIS_Recive_tdata            ,
    (*mark_debug = "true"*) input   wire    [   3:   0]   M_AXIS_Recive_tkeep            ,
    (*mark_debug = "true"*) input   wire                  M_AXIS_Recive_tlast            ,
    (*mark_debug = "true"*) output  wire                  M_AXIS_Recive_tready           ,
    (*mark_debug = "true"*) input   wire                  M_AXIS_Recive_tvalid           ,
    // send fifo
    input   wire                  axi_send_fifo_almost_empty_0   ,
    input   wire                  axi_send_fifo_almost_full_0    ,
    (*mark_debug = "true"*) output  wire    [  31:   0]   S_AXIS_Send_tdata              ,
    (*mark_debug = "true"*) output  wire    [   3:   0]   S_AXIS_Send_tkeep              ,
    (*mark_debug = "true"*) output  wire                  S_AXIS_Send_tlast              ,
    (*mark_debug = "true"*) input   wire                  S_AXIS_Send_tready             ,
    (*mark_debug = "true"*) output  wire                  S_AXIS_Send_tvalid             
);

(*mark_debug = "true"*) reg     [  31:   0]   data_use  ; 
(*mark_debug = "true"*) reg                   valid_use ; 

assign M_AXIS_Recive_tready = (axi_receive_fifo_almost_full_0 || ~S_AXIS_Send_tready) ? 1'b0 : 1'b1 ;

always @ (posedge clk) begin
    if (M_AXIS_Recive_tready) begin
        data_use <= M_AXIS_Recive_tdata;
        valid_use <= M_AXIS_Recive_tvalid;
    end
    else begin
        data_use <= 32'b0;
        valid_use <= 1'b0;
    end
end

(*mark_debug = "true"*) reg         flag     ;
(*mark_debug = "true"*) reg         valid    ; // 输入有效信号
(*mark_debug = "true"*) wire        eop      ; // 本次传输最后一个数据
(*mark_debug = "true"*) reg         transmod ; // 为1时表示传输向量，为0时传输矩阵
(*mark_debug = "true"*) reg  [31:0] data     ; // 传输数据
(*mark_debug = "true"*) reg  [11:0] row      ; // 当前传输非0数据所在行
(*mark_debug = "true"*) reg  [11:0] column   ; // 当前传输非0数据所在列
(*mark_debug = "true"*) wire [75:0] data_o   ; // 输出数据
(*mark_debug = "true"*) wire        valid_o  ;
(*mark_debug = "true"*) wire        eop_o    ;

(*mark_debug = "true"*) reg [31:0] data_use_r;
(*mark_debug = "true"*) reg valid_use_r;

(*mark_debug = "true"*) reg [31:0] data_use_f1;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_use_f1 <= 32'b0;
    end
    else begin
        data_use_f1 <= data_use;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        flag <= 1'b0;
    end
    else if (valid_use) begin
        flag <= ~flag;
    end
    else begin
        flag <= flag;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        data_use_r <= 32'b0;
    end
    else if (valid_use&(~flag)) begin
        data_use_r <= data_use;
    end
    else begin
        data_use_r <= data_use_r;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_use_r <= 1'b0;
    end
    else if (valid_use&(~flag)) begin
        valid_use_r <= 1'b1;
    end
    else begin
        valid_use_r <= 1'b0;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid <= 1'b0;
    end
    else if (valid_use_r&&{data_use_r,data_use}!=64'b0) begin
        valid <= 1'b1;
    end
    else begin
        valid <= 1'b0;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        row <= 12'b0;
        column <= 12'b0;
        data <= 32'b0;
    end
    else if (flag&valid_use_r) begin
        row <= {data_use_r[3:0],data_use_r[15:8]};
        column <= {data_use_r[19:16],data_use_r[31:24]};
        data <= {data_use[7:0],data_use[15:8],data_use[23:16],data_use[31:24]};
    end
    else begin
        row <= 12'b0;
        column <= 12'b0;
        data <= 32'b0;
    end
end

// assign eop = (data_use_r==32'h11111111&&data_use!=32'h11111111&&data_use_f1!=32'h11111111)||data_use_r==32'h3f0a400a;
assign eop = 1'b0;

always @(posedge clk or posedge rst) begin
    if (rst) begin
        transmod <= 1'b1;
    end
    else if (data_use_r==32'hffffffff||data_use_r==32'h00000000) begin
        transmod <= 1'b1;
    end
    else begin
        transmod <= 1'b0;
    end
end

SMVM U_SMVM(
    .clk                  (clk                    ), //input   wire               
    .rst                  (rst                    ), //input   wire               
    .valid                (valid                  ), //input   wire                // 输入有效信号
    .eop                  (eop                    ), //input   wire                // 本次传输最后一个数据
    .transmod             (transmod               ), //input   wire                // 为1时表示传输向量，为0时传输矩阵
    .data                 (data                   ), //input   wire signed [31:0]  // 传输数据
    .row                  (row                    ), //input   wire        [11:0]  // 当前传输非0数据所在行
    .column               (column                 ), //input   wire        [11:0]  // 当前传输非0数据所在列
    .valid_o              (valid_o                ), //output  reg                 // 输出有效信号
    .eop_o                (eop_o                  ), //output  reg                 // 本次传输最后一个数据
    .data_o               (data_o                 )  //output  reg  signed [75:0]  // 输出数据
);

(*mark_debug = "true"*) reg valid_o_f1;
(*mark_debug = "true"*) reg eop_o_f1;
(*mark_debug = "true"*) reg [31:0] data_o_f1;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_o_f1 <= 1'b0;
        eop_o_f1  <= 1'b0;
        data_o_f1  <= 32'b0;
    end
    else begin
        valid_o_f1 <= valid_o;
        eop_o_f1  <= eop_o;
        data_o_f1  <= data_o[31:0];
    end
end
assign S_AXIS_Send_tlast = eop_o_f1|eop_o;
assign S_AXIS_Send_tvalid = valid_o_f1|valid_o;
assign S_AXIS_Send_tkeep = S_AXIS_Send_tvalid? 4'b1111: 4'b0;
assign S_AXIS_Send_tdata = valid_o?{data_o[39:32],data_o[47:40],data_o[55:48],data_o[63:56]}:{data_o_f1[7:0],data_o_f1[15:8],data_o_f1[23:16],data_o_f1[31:24]};
 
endmodule
