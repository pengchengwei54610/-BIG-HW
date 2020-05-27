`timescale 1ns / 1ps
//���첽�ź�ͬ��
module Sync2(
    input CLK,//ԭʱ��
    input ASYNC,//usbʱ�ӻ�usb����
    input ACLR_L,//
    output SYNC//��ԭʱ��ͬ�����źŻ�����
    );
    
reg [1:0] SREG;
wire aclr_i;

assign aclr_i = ~ACLR_L; 
assign SYNC = SREG[1];

//������D���������첽�ź�תΪͬ���źţ�����ԭʱ�Ӻ�usbʱ�ӻ�usb����ͬ��
always @(posedge CLK or posedge aclr_i) begin        
        if(aclr_i) begin
            SREG <= 2'b00;
        end
        else begin
            SREG[0] <= ASYNC;//usb��ǰ�źŻ�����
            SREG[1] <= SREG[0];//��һ��ԭʱ���½���ʱusb�źŻ�����
        end
end
   
endmodule
