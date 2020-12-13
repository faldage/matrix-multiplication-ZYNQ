// SMVM.v
module SMVM(
    input   wire               clk      ,
    input   wire               rst      ,
    // 输入端
(*mark_debug = "true"*) input   wire               valid    , // 输入有效信号
(*mark_debug = "true"*) input   wire               eop      , // 本次传输最后一个数据
(*mark_debug = "true"*) input   wire               transmod , // 为1时表示传输向量，为0时传输矩阵
(*mark_debug = "true"*) input   wire signed [31:0] data     , // 传输数据
(*mark_debug = "true"*) input   wire        [11:0] row      , // 当前传输非0数据所在行
(*mark_debug = "true"*) input   wire        [11:0] column   , // 当前传输非0数据所在列
    // 输出端
(*mark_debug = "true"*) output  reg                valid_o  , // 输出有效信号
(*mark_debug = "true"*) output  reg                eop_o    , // 本次传输最后一个数据
(*mark_debug = "true"*) output  reg  signed [75:0] data_o     // 输出数据
);

(*mark_debug = "true"*) wire               wea          ; 
(*mark_debug = "true"*) wire        [11:0] addra        ; 
(*mark_debug = "true"*) wire signed [31:0] douta        ;
(*mark_debug = "true"*) wire signed [63:0] P            ; 
(*mark_debug = "true"*) reg         [11:0] addr_save    ; // 存储向量地址
(*mark_debug = "true"*) reg                valid_f1     ; 
(*mark_debug = "true"*) reg                valid_f2     ; 
(*mark_debug = "true"*) reg                valid_f3     ; 
(*mark_debug = "true"*) reg                valid_f4     ; 
(*mark_debug = "true"*) reg                eop_f1       ; 
(*mark_debug = "true"*) reg                eop_f2       ; 
(*mark_debug = "true"*) reg                eop_f3       ; 
(*mark_debug = "true"*) reg                transmod_f1  ; 
(*mark_debug = "true"*) reg                transmod_f2  ; 
(*mark_debug = "true"*) reg                transmod_f3  ; 
(*mark_debug = "true"*) reg  signed [31:0] data_f1      ; 
(*mark_debug = "true"*) reg         [11:0] row_f1       ; 
(*mark_debug = "true"*) reg         [11:0] row_f2       ; 
(*mark_debug = "true"*) reg         [11:0] row_f3       ; 
(*mark_debug = "true"*) reg         [11:0] row_f4       ; 
(*mark_debug = "true"*) reg  signed [75:0] temp_sum     ; // 一个数是32bit*32bit=64bit，最多有12bit的加起来，共76bit
(*mark_debug = "true"*) reg                need_out     ; 
(*mark_debug = "true"*) reg                eop_need_out ; 

always @(posedge clk or posedge rst) begin
    if (rst) begin
        addr_save <= 12'b0;
    end
    else if (wea&&addr_save!=12'd4095) begin
        // if (eop) begin
        //     addr_save <= 12'b0;
        // end
        // else begin
            addr_save <= addr_save + 1'b1;
        // end
    end
    else begin
        addr_save <= addr_save;
    end
end

assign wea = valid&transmod;
assign addra = transmod?addr_save:column-1'b1;

// 例化RAM存储向量
blk_mem_gen_0 U_blk_mem_gen_0(
    .clka  (clk   ), // input wire clka
    .wea   (wea   ), // input wire [0 : 0] wea
    .addra (addra ), // input wire [11 : 0] addra
    .dina  (data  ), // input wire [31 : 0] dina
    .douta (douta )  // output wire [31 : 0] douta
);

(*mark_debug = "true"*) reg [1:0] in_cnt;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        in_cnt <= 2'b0;
    end
    else if (valid) begin
        in_cnt <= 2'd3;
    end
    else if (in_cnt == 2'd0) begin
        in_cnt <= in_cnt;
    end
    else begin
        in_cnt <= in_cnt - 1'b1;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_f1    <= 1'b0;
        eop_f1      <= 1'b0;
        transmod_f1 <= 1'b1;
        data_f1     <= 32'b0;
        row_f1      <= 12'b0;
    end
    else if (valid) begin
        valid_f1    <= valid      ;
        eop_f1      <= eop        ;
        transmod_f1 <= transmod   ;
        data_f1     <= data       ;
        row_f1      <= row        ;
    end
    else if (in_cnt == 2'd2) begin
        valid_f1    <= 1'b0;
        eop_f1      <= 1'b0;
        transmod_f1 <= 1'b1;
        data_f1     <= 32'b0;
        row_f1      <= 12'b0;
    end
    else begin
        valid_f1    <= 1'b0       ;
        eop_f1      <= eop_f1     ;
        transmod_f1 <= transmod_f1;
        data_f1     <= data_f1    ;
        row_f1      <= row_f1     ;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_f2    <= 1'b0;
        eop_f2      <= 1'b0;
        transmod_f2 <= 1'b1;
        row_f2      <= 12'b0;
    end
    else if (valid_f1) begin
        valid_f2    <= valid_f1   ;
        eop_f2      <= eop_f1     ;
        transmod_f2 <= transmod_f1;
        row_f2      <= row_f1     ;
    end
    else if (in_cnt == 2'd1) begin
        valid_f2    <= 1'b0;
        eop_f2      <= 1'b0;
        transmod_f2 <= 1'b1;
        row_f2      <= 12'b0;
    end
    else begin
        valid_f2    <= 1'b0       ;
        eop_f2      <= eop_f2     ;
        transmod_f2 <= transmod_f2;
        row_f2      <= row_f2     ;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_f3    <= 1'b0;
        eop_f3      <= 1'b0;
        transmod_f3 <= 1'b1;
        row_f3      <= 12'b0;
    end
    else if (valid_f2) begin
        valid_f3    <= valid_f2   ;
        eop_f3      <= eop_f2     ;
        transmod_f3 <= transmod_f2;
        row_f3      <= row_f2     ;
    end
    else begin
        valid_f3    <= 1'b0       ;
        eop_f3      <= eop_f3     ;
        transmod_f3 <= transmod_f3;
        row_f3      <= row_f3     ;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_f4 <= 1'b0 ;
        row_f4   <= 12'b0;
    end
    else if (valid_f3) begin
        valid_f4 <= valid_f3 ;
        row_f4   <= row_f3   ;
    end
    else begin
        valid_f4 <= 1'b0     ;
        row_f4   <= row_f4   ;
    end
end

// 例化乘法器IP核
mult_gen_0 U_mult_gen_0(
    .CLK (clk     ), // input wire CLK
    .A   (data_f1 ), // input wire [31 : 0] A
    .B   (douta   ), // input wire [31 : 0] B
    .P   (P       )  // output wire [63 : 0] P
);

always @(posedge clk or posedge rst) begin
    if (rst) begin
        temp_sum <= 76'b0;
    end
    else if (valid_f3&(~transmod_f3)) begin
        if (row_f4 == row_f3) begin
            temp_sum <= temp_sum + P;
        end
        else begin
            temp_sum <= P;
        end
    end
    else begin
        temp_sum <= temp_sum;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        need_out <= 1'b0;
    end
    else if (valid_f4&(~transmod_f3)&&(row_f3!=row_f2)) begin
        need_out <= 1'b1;
    end
    else begin
        need_out <= 1'b0;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        eop_need_out <= 1'b0;
    end
    else if (eop_f3&(~transmod_f3)) begin
        eop_need_out <= 1'b1;
    end
    else begin
        eop_need_out <= 1'b0;
    end
end

(*mark_debug = "true"*) reg [15:0] out_cnt;
always @(posedge clk or posedge rst) begin
    if (rst) begin
        out_cnt <= 16'b0;
    end
    else if (transmod) begin
        out_cnt <= 16'b0;
    end
    else if (out_cnt==16'hffff) begin
        out_cnt <= out_cnt;
    end
    else if (valid_o) begin
        out_cnt <= out_cnt+1'b1;
    end
    else begin
        out_cnt <= out_cnt;
    end
end
always @(posedge clk or posedge rst) begin
    if (rst) begin
        eop_o <= 1'b0;
    end
    else if (transmod) begin
        eop_o <= 1'b0;
    end
    else if (out_cnt==16'd2623) begin        
        eop_o <= 1'b1;
    end
    else begin
        eop_o <= eop_o;
    end
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        valid_o <= 1'b0;
        data_o  <= 76'b0;
    end
    else if (need_out) begin
        valid_o <= 1'b1;
        data_o  <= temp_sum;
    end
    else begin
        valid_o <= 1'b0;
        data_o  <= 76'b0;
    end
end

endmodule
