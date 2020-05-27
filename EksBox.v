`timescale 1ns / 1ps
//����ģ��
module EksBox(
    input CLK,//�����ԭʱ��
    input ARST_L,//�����źţ�switch[15]Ϊ�ߵ�ƽʱ��Ϸ����
    input SCLK,//usbʱ��
    input SDATA,//usb����
    output HSYNC,//֡ͬ���ź�
    output VSYNC,//��ͬ���ź�
    output [3:0] RED,//�����ɫ
    output [3:0] GREEN,//�����ɫ
    output [3:0] BLUE,//�����ɫ
    output kbstrobe_i//ȥ���ź�
    );
    
wire clk25mhz_i, synctop_i, syncbot_i, keyup_i;//4����Ƶ��ʱ�ӣ�ͬ�����usb�źţ�ͬ�����usb���ݣ��Ƿ��ȡ��������Ϣ��1Ϊ��ȡ����
wire [3:0] hex1_i, hex0_i;//16���Ƽ����λ��16���Ƽ����λ
wire [9:0] hcoord_i, vcoord_i;//֡���꣬������
wire [11:0] csel_i; //��ɫr,g,bֵ
    
Sync2           U1 (.CLK(CLK), .ASYNC(SCLK), .ACLR_L(ARST_L), .SYNC(synctop_i));
Sync2           U2 (.CLK(CLK), .ASYNC(SDATA), .ACLR_L(ARST_L), .SYNC(syncbot_i));
Clk25Mhz        U3 (.CLKIN(CLK), .ACLR_L(ARST_L), .CLKOUT(clk25mhz_i));
KBDecoder       U4 (.CLK(synctop_i), .SDATA(syncbot_i), .ARST_L(ARST_L), .HEX1(hex1_i), .HEX0(hex0_i), .KEYUP(keyup_i));
SwitchDB        U5 (.CLK(clk25mhz_i), .SW(keyup_i), .ACLR_L(ARST_L), .SWDB(kbstrobe_i));
VGAController   U6 (.CLK(clk25mhz_i), .KBCODE({hex1_i, hex0_i}), .HCOORD(hcoord_i), .VCOORD(vcoord_i), .KBSTROBE(kbstrobe_i), .ARST_L(ARST_L), .CSEL(csel_i));
VGAEncoder      U7 (.CLK(clk25mhz_i), .CSEL(csel_i), .ARST_L(ARST_L), .HSYNC(HSYNC), .VSYNC(VSYNC), .RED(RED), .GREEN(GREEN), .BLUE(BLUE), .HCOORD(hcoord_i), .VCOORD(vcoord_i));
    
endmodule
