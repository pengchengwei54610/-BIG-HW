`timescale 1ns / 1ps
//����ť������Ϊ�źŲ��ͷŵ�������
//����ÿһ�����µİ�ť�����ᷴ����
module SwitchDB(
input CLK,//4����Ƶ��ʱ��
input SW,//�Ƿ��ȡ��������Ϣ��1Ϊ��ȡ��
input ACLR_L,//�����ź�
output reg SWDB//ȥ���ź�
);

wire aclr_i;
reg [1:0] Q_CURR;//״̬����״̬
parameter [1:0] SW_OFF = 2'b00; //״̬������
parameter [1:0] SW_EDGE = 2'b01;
parameter [1:0] SW_VERF = 2'b10;
parameter [1:0] SW_HOLD = 2'b11;
assign aclr_i = ~ACLR_L;

//״̬ת��
always @(posedge CLK or posedge aclr_i) begin
    SWDB <= 1'b0;   //Ĭ��Ϊ0

    if(aclr_i) begin
        Q_CURR <= SW_OFF;
    end
    else begin
        case(Q_CURR)   
            SW_OFF: if(SW) begin
                        Q_CURR <= SW_EDGE;
                    end
                    else begin
                        Q_CURR <= SW_OFF;
                    end
                    
            SW_EDGE: if(SW) begin
                        Q_CURR <= SW_VERF;
                        SWDB <= 1'b1;   //ȥ���źŽ��ڵ�ǰ״̬ΪSW_VERFʱΪ��
                     end
                     else begin
                        Q_CURR <= SW_OFF;
                     end
                     
             SW_VERF: Q_CURR <= SW_HOLD;
                      
             SW_HOLD: if(SW) begin
                          Q_CURR <= SW_HOLD;
                      end
                      else begin
                          Q_CURR <= SW_OFF;
                      end
        endcase              
    end
end
endmodule
