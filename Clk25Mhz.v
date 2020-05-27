`timescale 1ns / 1ps
//��Ƶ4���õ�һ��25mhz��ʱ��
module Clk25Mhz(
    input CLKIN,//ԭʱ��
    input ACLR_L,//���ƿ���
    output reg CLKOUT//��Ƶ��ʱ��
    );
    
reg SREG;    
wire aclr_i;
assign aclr_i = ~ACLR_L;

//���η�Ƶ�ﵽ4����Ƶ��Ч����һ�����ƿ�����0����ʬ��ʱ������
always @(posedge CLKIN or posedge aclr_i) begin
    if(aclr_i) begin
        SREG <= 1'b0;
    end
    else begin
        SREG <= ~SREG;
    end
end

//Output clock generation, divide by 4
always @(posedge CLKIN or posedge aclr_i) begin
    if(aclr_i) begin
        CLKOUT <= 1'b0;
    end
    else if(SREG) begin
        CLKOUT <= ~CLKOUT;
    end
end

endmodule
