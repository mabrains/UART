/* Generated by Yosys 0.9+3621 (git sha1 84e9fa7, gcc 8.3.1 -fPIC -Os) */

module uart(UARTn_RXD, UARTn_CTS, clk, UARTn_RTS, UARTn_TXD);
  wire _000_;
  wire _001_;
  wire _002_;
  wire _003_;
  wire _004_;
  wire _005_;
  wire _006_;
  wire _007_;
  wire _008_;
  wire _009_;
  wire _010_;
  wire _011_;
  wire _012_;
  wire _013_;
  wire _014_;
  wire _015_;
  wire _016_;
  wire _017_;
  wire _018_;
  wire _019_;
  wire _020_;
  wire _021_;
  wire _022_;
  wire _023_;
  wire _024_;
  wire _025_;
  wire _026_;
  wire _027_;
  wire _028_;
  wire _029_;
  wire _030_;
  wire _031_;
  wire _032_;
  wire _033_;
  wire _034_;
  wire _035_;
  wire _036_;
  wire _037_;
  wire _038_;
  wire _039_;
  wire _040_;
  wire _041_;
  wire _042_;
  wire _043_;
  wire _044_;
  wire _045_;
  wire _046_;
  wire _047_;
  wire _048_;
  wire _049_;
  wire _050_;
  wire _051_;
  wire _052_;
  wire _053_;
  wire _054_;
  wire _055_;
  wire _056_;
  wire _057_;
  wire _058_;
  wire _059_;
  wire _060_;
  wire _061_;
  wire _062_;
  wire _063_;
  wire _064_;
  wire _065_;
  wire _066_;
  wire _067_;
  wire _068_;
  wire _069_;
  wire _070_;
  wire _071_;
  wire _072_;
  wire _073_;
  wire _074_;
  wire _075_;
  wire _076_;
  wire _077_;
  wire _078_;
  wire _079_;
  wire _080_;
  wire _081_;
  wire _082_;
  wire _083_;
  wire _084_;
  wire _085_;
  wire _086_;
  wire _087_;
  wire _088_;
  wire _089_;
  wire _090_;
  wire _091_;
  wire _092_;
  wire _093_;
  wire _094_;
  wire _095_;
  wire _096_;
  wire _097_;
  wire _098_;
  wire _099_;
  wire _100_;
  wire _101_;
  wire _102_;
  wire _103_;
  wire _104_;
  wire _105_;
  wire _106_;
  wire _107_;
  wire _108_;
  wire _109_;
  wire _110_;
  wire _111_;
  wire _112_;
  wire _113_;
  wire _114_;
  input UARTn_CTS;
  output UARTn_RTS;
  input UARTn_RXD;
  output UARTn_TXD;
  input clk;
  wire \tx_inst.next_state[0] ;
  wire \tx_inst.next_state[1] ;
  wire \tx_inst.next_state[2] ;
  wire \tx_inst.tick[0] ;
  wire \tx_inst.tick[1] ;
  wire \tx_inst.tick[2] ;
  wire \tx_inst.tick[3] ;
  wire \tx_inst.transmitted_bit_index[0] ;
  wire \tx_inst.transmitted_bit_index[1] ;
  wire \tx_inst.transmitted_bit_index[2] ;
  wire \tx_inst.u1_tx.acc[0] ;
  wire \tx_inst.u1_tx.acc[1] ;
  wire \tx_inst.u1_tx.acc[2] ;
  wire \tx_inst.u1_tx.acc[3] ;
  wire \tx_inst.u1_tx.acc[4] ;
  wire \tx_inst.u1_tx.acc[5] ;
  wire \tx_inst.u1_tx.acc[6] ;
  wire \tx_inst.u1_tx.acc[7] ;
  wire \tx_inst.u1_tx.acc[8] ;
  wire \tx_inst.u1_tx.acc[9] ;
  sky130_fd_sc_hd__inv_2 _115_ (
    .A(\tx_inst.u1_tx.acc[3] ),
    .Y(_081_)
  );
  sky130_fd_sc_hd__nand3_2 _116_ (
    .A(\tx_inst.u1_tx.acc[0] ),
    .B(\tx_inst.u1_tx.acc[1] ),
    .C(\tx_inst.u1_tx.acc[2] ),
    .Y(_082_)
  );
  sky130_fd_sc_hd__nor2_2 _117_ (
    .A(_081_),
    .B(_082_),
    .Y(_083_)
  );
  sky130_fd_sc_hd__buf_1 _118_ (
    .A(\tx_inst.u1_tx.acc[6] ),
    .X(_084_)
  );
  sky130_fd_sc_hd__nand2_2 _119_ (
    .A(_084_),
    .B(\tx_inst.u1_tx.acc[7] ),
    .Y(_085_)
  );
  sky130_fd_sc_hd__nand2_2 _120_ (
    .A(\tx_inst.u1_tx.acc[5] ),
    .B(\tx_inst.u1_tx.acc[4] ),
    .Y(_086_)
  );
  sky130_fd_sc_hd__nor2_2 _121_ (
    .A(_085_),
    .B(_086_),
    .Y(_087_)
  );
  sky130_fd_sc_hd__a21oi_2 _122_ (
    .A1(_083_),
    .A2(_087_),
    .B1(\tx_inst.u1_tx.acc[8] ),
    .Y(_088_)
  );
  sky130_fd_sc_hd__nand2_2 _123_ (
    .A(\tx_inst.u1_tx.acc[8] ),
    .B(\tx_inst.u1_tx.acc[9] ),
    .Y(_089_)
  );
  sky130_fd_sc_hd__inv_2 _124_ (
    .A(\tx_inst.u1_tx.acc[5] ),
    .Y(_090_)
  );
  sky130_fd_sc_hd__nand3b_2 _125_ (
    .A_N(_089_),
    .B(_090_),
    .C(\tx_inst.u1_tx.acc[4] ),
    .Y(_091_)
  );
  sky130_fd_sc_hd__nor2b_2 _126_ (
    .A(\tx_inst.u1_tx.acc[1] ),
    .B_N(\tx_inst.u1_tx.acc[0] ),
    .Y(_092_)
  );
  sky130_fd_sc_hd__and2_2 _127_ (
    .A(\tx_inst.u1_tx.acc[6] ),
    .B(\tx_inst.u1_tx.acc[7] ),
    .X(_093_)
  );
  sky130_fd_sc_hd__nor2_2 _128_ (
    .A(\tx_inst.u1_tx.acc[3] ),
    .B(\tx_inst.u1_tx.acc[2] ),
    .Y(_094_)
  );
  sky130_fd_sc_hd__nand3_2 _129_ (
    .A(_092_),
    .B(_093_),
    .C(_094_),
    .Y(_095_)
  );
  sky130_fd_sc_hd__nor2_2 _130_ (
    .A(_091_),
    .B(_095_),
    .Y(_096_)
  );
  sky130_fd_sc_hd__nand3_2 _131_ (
    .A(_083_),
    .B(_087_),
    .C(\tx_inst.u1_tx.acc[8] ),
    .Y(_097_)
  );
  sky130_fd_sc_hd__inv_2 _132_ (
    .A(_097_),
    .Y(_098_)
  );
  sky130_fd_sc_hd__nor3_2 _133_ (
    .A(_088_),
    .B(_096_),
    .C(_098_),
    .Y(_031_)
  );
  sky130_fd_sc_hd__nor3_2 _134_ (
    .A(_081_),
    .B(_086_),
    .C(_082_),
    .Y(_099_)
  );
  sky130_fd_sc_hd__a21oi_2 _135_ (
    .A1(_099_),
    .A2(_084_),
    .B1(\tx_inst.u1_tx.acc[7] ),
    .Y(_100_)
  );
  sky130_fd_sc_hd__and3_2 _136_ (
    .A(_099_),
    .B(_084_),
    .C(\tx_inst.u1_tx.acc[7] ),
    .X(_101_)
  );
  sky130_fd_sc_hd__nor3_2 _137_ (
    .A(_096_),
    .B(_100_),
    .C(_101_),
    .Y(_030_)
  );
  sky130_fd_sc_hd__buf_1 _138_ (
    .A(_091_),
    .X(_102_)
  );
  sky130_fd_sc_hd__buf_1 _139_ (
    .A(_095_),
    .X(_103_)
  );
  sky130_fd_sc_hd__a2bb2oi_2 _140_ (
    .A1_N(_102_),
    .A2_N(_103_),
    .B1(_084_),
    .B2(_099_),
    .Y(_104_)
  );
  sky130_fd_sc_hd__o21a_2 _141_ (
    .A1(_084_),
    .A2(_099_),
    .B1(_104_),
    .X(_029_)
  );
  sky130_fd_sc_hd__inv_2 _142_ (
    .A(\tx_inst.u1_tx.acc[4] ),
    .Y(_105_)
  );
  sky130_fd_sc_hd__nor3_2 _143_ (
    .A(_081_),
    .B(_105_),
    .C(_082_),
    .Y(_106_)
  );
  sky130_fd_sc_hd__o32a_2 _144_ (
    .A1(_081_),
    .A2(_082_),
    .A3(_086_),
    .B1(\tx_inst.u1_tx.acc[5] ),
    .B2(_106_),
    .X(_028_)
  );
  sky130_fd_sc_hd__nor3_2 _145_ (
    .A(\tx_inst.u1_tx.acc[5] ),
    .B(_105_),
    .C(_089_),
    .Y(_107_)
  );
  sky130_fd_sc_hd__nor3_2 _146_ (
    .A(\tx_inst.u1_tx.acc[3] ),
    .B(\tx_inst.u1_tx.acc[2] ),
    .C(_085_),
    .Y(_108_)
  );
  sky130_fd_sc_hd__a31oi_2 _147_ (
    .A1(_107_),
    .A2(_108_),
    .A3(_092_),
    .B1(_106_),
    .Y(_109_)
  );
  sky130_fd_sc_hd__o21a_2 _148_ (
    .A1(\tx_inst.u1_tx.acc[4] ),
    .A2(_083_),
    .B1(_109_),
    .X(_027_)
  );
  sky130_fd_sc_hd__xnor2_2 _149_ (
    .A(\tx_inst.u1_tx.acc[3] ),
    .B(_082_),
    .Y(_026_)
  );
  sky130_fd_sc_hd__nand2_2 _150_ (
    .A(\tx_inst.u1_tx.acc[0] ),
    .B(\tx_inst.u1_tx.acc[1] ),
    .Y(_110_)
  );
  sky130_fd_sc_hd__xnor2_2 _151_ (
    .A(\tx_inst.u1_tx.acc[2] ),
    .B(_110_),
    .Y(_025_)
  );
  sky130_fd_sc_hd__and2b_2 _152_ (
    .A_N(\tx_inst.u1_tx.acc[0] ),
    .B(\tx_inst.u1_tx.acc[1] ),
    .X(_111_)
  );
  sky130_fd_sc_hd__o22a_2 _153_ (
    .A1(_092_),
    .A2(_111_),
    .B1(_102_),
    .B2(_103_),
    .X(_024_)
  );
  sky130_fd_sc_hd__inv_2 _154_ (
    .A(\tx_inst.u1_tx.acc[0] ),
    .Y(_023_)
  );
  sky130_fd_sc_hd__and2_2 _155_ (
    .A(\tx_inst.tick[1] ),
    .B(\tx_inst.tick[0] ),
    .X(_112_)
  );
  sky130_fd_sc_hd__nand3_2 _156_ (
    .A(_096_),
    .B(\tx_inst.tick[2] ),
    .C(_112_),
    .Y(_113_)
  );
  sky130_fd_sc_hd__nand2_2 _157_ (
    .A(_113_),
    .B(\tx_inst.tick[3] ),
    .Y(_114_)
  );
  sky130_fd_sc_hd__inv_2 _158_ (
    .A(_112_),
    .Y(_035_)
  );
  sky130_fd_sc_hd__nor3_2 _159_ (
    .A(_035_),
    .B(_102_),
    .C(_103_),
    .Y(_036_)
  );
  sky130_fd_sc_hd__inv_2 _160_ (
    .A(\tx_inst.tick[3] ),
    .Y(_037_)
  );
  sky130_fd_sc_hd__nand3_2 _161_ (
    .A(_036_),
    .B(_037_),
    .C(\tx_inst.tick[2] ),
    .Y(_038_)
  );
  sky130_fd_sc_hd__nand2_2 _162_ (
    .A(_114_),
    .B(_038_),
    .Y(_022_)
  );
  sky130_fd_sc_hd__a41oi_2 _163_ (
    .A1(_107_),
    .A2(_108_),
    .A3(_112_),
    .A4(_092_),
    .B1(\tx_inst.tick[2] ),
    .Y(_039_)
  );
  sky130_fd_sc_hd__inv_2 _164_ (
    .A(\tx_inst.tick[2] ),
    .Y(_040_)
  );
  sky130_fd_sc_hd__nand3_2 _165_ (
    .A(_107_),
    .B(_092_),
    .C(_108_),
    .Y(_041_)
  );
  sky130_fd_sc_hd__nor3_2 _166_ (
    .A(_040_),
    .B(_035_),
    .C(_041_),
    .Y(_042_)
  );
  sky130_fd_sc_hd__nor2_2 _167_ (
    .A(_039_),
    .B(_042_),
    .Y(_021_)
  );
  sky130_fd_sc_hd__nor3b_2 _168_ (
    .A(_102_),
    .B(_103_),
    .C_N(\tx_inst.tick[0] ),
    .Y(_043_)
  );
  sky130_fd_sc_hd__nand3b_2 _169_ (
    .A_N(_095_),
    .B(_107_),
    .C(_112_),
    .Y(_044_)
  );
  sky130_fd_sc_hd__o21a_2 _170_ (
    .A1(\tx_inst.tick[1] ),
    .A2(_043_),
    .B1(_044_),
    .X(_020_)
  );
  sky130_fd_sc_hd__xnor2_2 _171_ (
    .A(\tx_inst.tick[0] ),
    .B(_041_),
    .Y(_019_)
  );
  sky130_fd_sc_hd__inv_2 _172_ (
    .A(\tx_inst.next_state[2] ),
    .Y(_045_)
  );
  sky130_fd_sc_hd__buf_1 _173_ (
    .A(\tx_inst.next_state[1] ),
    .X(_046_)
  );
  sky130_fd_sc_hd__buf_1 _174_ (
    .A(_046_),
    .X(_047_)
  );
  sky130_fd_sc_hd__buf_1 _175_ (
    .A(\tx_inst.next_state[0] ),
    .X(_048_)
  );
  sky130_fd_sc_hd__nor2_2 _176_ (
    .A(_047_),
    .B(_048_),
    .Y(_049_)
  );
  sky130_fd_sc_hd__o21bai_2 _177_ (
    .A1(_045_),
    .A2(_049_),
    .B1_N(_034_),
    .Y(_018_)
  );
  sky130_fd_sc_hd__buf_1 _178_ (
    .A(\tx_inst.next_state[2] ),
    .X(_050_)
  );
  sky130_fd_sc_hd__o21a_2 _179_ (
    .A1(_046_),
    .A2(_048_),
    .B1(_050_),
    .X(_051_)
  );
  sky130_fd_sc_hd__inv_2 _180_ (
    .A(_051_),
    .Y(_052_)
  );
  sky130_fd_sc_hd__inv_2 _181_ (
    .A(\tx_inst.next_state[0] ),
    .Y(_053_)
  );
  sky130_fd_sc_hd__nand3_2 _182_ (
    .A(_045_),
    .B(_053_),
    .C(\tx_inst.next_state[1] ),
    .Y(_054_)
  );
  sky130_fd_sc_hd__buf_1 _183_ (
    .A(_054_),
    .X(_055_)
  );
  sky130_fd_sc_hd__o21a_2 _184_ (
    .A1(_045_),
    .A2(_049_),
    .B1(_055_),
    .X(_056_)
  );
  sky130_fd_sc_hd__nand3b_2 _185_ (
    .A_N(_050_),
    .B(_046_),
    .C(\tx_inst.next_state[0] ),
    .Y(_057_)
  );
  sky130_fd_sc_hd__nor2_2 _186_ (
    .A(\tx_inst.tick[1] ),
    .B(\tx_inst.tick[0] ),
    .Y(_058_)
  );
  sky130_fd_sc_hd__nand3_2 _187_ (
    .A(_058_),
    .B(\tx_inst.tick[3] ),
    .C(_040_),
    .Y(_059_)
  );
  sky130_fd_sc_hd__buf_1 _188_ (
    .A(_059_),
    .X(_004_)
  );
  sky130_fd_sc_hd__nand3b_2 _189_ (
    .A_N(_046_),
    .B(_045_),
    .C(\tx_inst.next_state[0] ),
    .Y(_060_)
  );
  sky130_fd_sc_hd__inv_2 _190_ (
    .A(_060_),
    .Y(_061_)
  );
  sky130_fd_sc_hd__a31oi_2 _191_ (
    .A1(_058_),
    .A2(_040_),
    .A3(\tx_inst.tick[3] ),
    .B1(_003_),
    .Y(_062_)
  );
  sky130_fd_sc_hd__o2bb2ai_2 _192_ (
    .A1_N(_057_),
    .A2_N(_004_),
    .B1(_061_),
    .B2(_062_),
    .Y(_063_)
  );
  sky130_fd_sc_hd__a2bb2oi_2 _193_ (
    .A1_N(_047_),
    .A2_N(_052_),
    .B1(_056_),
    .B2(_063_),
    .Y(_017_)
  );
  sky130_fd_sc_hd__o2bb2ai_2 _194_ (
    .A1_N(_033_),
    .A2_N(_052_),
    .B1(_045_),
    .B2(_053_),
    .Y(_016_)
  );
  sky130_fd_sc_hd__nor2_2 _195_ (
    .A(_055_),
    .B(_059_),
    .Y(_064_)
  );
  sky130_fd_sc_hd__a31oi_2 _196_ (
    .A1(_064_),
    .A2(\tx_inst.transmitted_bit_index[1] ),
    .A3(\tx_inst.transmitted_bit_index[0] ),
    .B1(\tx_inst.transmitted_bit_index[2] ),
    .Y(_065_)
  );
  sky130_fd_sc_hd__inv_2 _197_ (
    .A(\tx_inst.transmitted_bit_index[2] ),
    .Y(_066_)
  );
  sky130_fd_sc_hd__nand3_2 _198_ (
    .A(_064_),
    .B(\tx_inst.transmitted_bit_index[1] ),
    .C(\tx_inst.transmitted_bit_index[0] ),
    .Y(_067_)
  );
  sky130_fd_sc_hd__nor2_2 _199_ (
    .A(_066_),
    .B(_067_),
    .Y(_068_)
  );
  sky130_fd_sc_hd__nor2_2 _200_ (
    .A(_065_),
    .B(_068_),
    .Y(_015_)
  );
  sky130_fd_sc_hd__inv_2 _201_ (
    .A(\tx_inst.transmitted_bit_index[0] ),
    .Y(_011_)
  );
  sky130_fd_sc_hd__nor3_2 _202_ (
    .A(_011_),
    .B(_055_),
    .C(_004_),
    .Y(_069_)
  );
  sky130_fd_sc_hd__xor2_2 _203_ (
    .A(\tx_inst.transmitted_bit_index[1] ),
    .B(_069_),
    .X(_014_)
  );
  sky130_fd_sc_hd__xor2_2 _204_ (
    .A(\tx_inst.transmitted_bit_index[0] ),
    .B(_064_),
    .X(_013_)
  );
  sky130_fd_sc_hd__inv_2 _205_ (
    .A(UARTn_TXD),
    .Y(_070_)
  );
  sky130_fd_sc_hd__nand3_2 _206_ (
    .A(_060_),
    .B(_054_),
    .C(_003_),
    .Y(_010_)
  );
  sky130_fd_sc_hd__nor2_2 _207_ (
    .A(_050_),
    .B(_046_),
    .Y(_071_)
  );
  sky130_fd_sc_hd__nand3b_2 _208_ (
    .A_N(_071_),
    .B(_055_),
    .C(_003_),
    .Y(_072_)
  );
  sky130_fd_sc_hd__a21boi_2 _209_ (
    .A1(_004_),
    .A2(_010_),
    .B1_N(_072_),
    .Y(_073_)
  );
  sky130_fd_sc_hd__o21ai_2 _210_ (
    .A1(_047_),
    .A2(_048_),
    .B1(_057_),
    .Y(_074_)
  );
  sky130_fd_sc_hd__nor2_2 _211_ (
    .A(_008_),
    .B(_055_),
    .Y(_075_)
  );
  sky130_fd_sc_hd__inv_2 _212_ (
    .A(_009_),
    .Y(_076_)
  );
  sky130_fd_sc_hd__nand2_2 _213_ (
    .A(_010_),
    .B(_004_),
    .Y(_077_)
  );
  sky130_fd_sc_hd__o2111ai_2 _214_ (
    .A1(_074_),
    .A2(_075_),
    .B1(_076_),
    .C1(_072_),
    .D1(_077_),
    .Y(_078_)
  );
  sky130_fd_sc_hd__o21ai_2 _215_ (
    .A1(_070_),
    .A2(_073_),
    .B1(_078_),
    .Y(_012_)
  );
  sky130_fd_sc_hd__inv_2 _216_ (
    .A(_049_),
    .Y(_001_)
  );
  sky130_fd_sc_hd__nand2_2 _217_ (
    .A(_047_),
    .B(_048_),
    .Y(_002_)
  );
  sky130_fd_sc_hd__nor3b_2 _218_ (
    .A(_047_),
    .B(_048_),
    .C_N(_050_),
    .Y(_005_)
  );
  sky130_fd_sc_hd__inv_2 _219_ (
    .A(_057_),
    .Y(_006_)
  );
  sky130_fd_sc_hd__nand2b_2 _220_ (
    .A_N(\tx_inst.transmitted_bit_index[1] ),
    .B(\tx_inst.transmitted_bit_index[0] ),
    .Y(_007_)
  );
  sky130_fd_sc_hd__a311oi_2 _221_ (
    .A1(_058_),
    .A2(_040_),
    .A3(\tx_inst.tick[3] ),
    .B1(_050_),
    .C1(_053_),
    .Y(_000_)
  );
  sky130_fd_sc_hd__inv_2 _222_ (
    .A(\tx_inst.u1_tx.acc[9] ),
    .Y(_079_)
  );
  sky130_fd_sc_hd__o2bb2ai_2 _223_ (
    .A1_N(_079_),
    .A2_N(_097_),
    .B1(_102_),
    .B2(_103_),
    .Y(_080_)
  );
  sky130_fd_sc_hd__a21oi_2 _224_ (
    .A1(\tx_inst.u1_tx.acc[9] ),
    .A2(_098_),
    .B1(_080_),
    .Y(_032_)
  );
  sky130_fd_sc_hd__conb_1 _225_ (
    .LO(UARTn_RTS)
  );
  sky130_fd_sc_hd__mux2_1 _226_ (
    .A0(UARTn_CTS),
    .A1(_000_),
    .S(_010_),
    .X(_033_)
  );
  sky130_fd_sc_hd__mux2_1 _227_ (
    .A0(_006_),
    .A1(_005_),
    .S(_004_),
    .X(_034_)
  );
  sky130_fd_sc_hd__mux2_1 _228_ (
    .A0(_002_),
    .A1(_001_),
    .S(\tx_inst.next_state[2] ),
    .X(_003_)
  );
  sky130_fd_sc_hd__mux2_1 _229_ (
    .A0(\tx_inst.next_state[0] ),
    .A1(\tx_inst.next_state[2] ),
    .S(\tx_inst.next_state[1] ),
    .X(_009_)
  );
  sky130_fd_sc_hd__mux2_1 _230_ (
    .A0(_011_),
    .A1(_007_),
    .S(\tx_inst.transmitted_bit_index[2] ),
    .X(_008_)
  );
  sky130_fd_sc_hd__dfxtp_2 _231_ (
    .CLK(clk),
    .D(_012_),
    .Q(UARTn_TXD)
  );
  sky130_fd_sc_hd__dfxtp_2 _232_ (
    .CLK(clk),
    .D(_013_),
    .Q(\tx_inst.transmitted_bit_index[0] )
  );
  sky130_fd_sc_hd__dfxtp_2 _233_ (
    .CLK(clk),
    .D(_014_),
    .Q(\tx_inst.transmitted_bit_index[1] )
  );
  sky130_fd_sc_hd__dfxtp_2 _234_ (
    .CLK(clk),
    .D(_015_),
    .Q(\tx_inst.transmitted_bit_index[2] )
  );
  sky130_fd_sc_hd__dfxtp_2 _235_ (
    .CLK(clk),
    .D(_016_),
    .Q(\tx_inst.next_state[0] )
  );
  sky130_fd_sc_hd__dfxtp_2 _236_ (
    .CLK(clk),
    .D(_017_),
    .Q(\tx_inst.next_state[1] )
  );
  sky130_fd_sc_hd__dfxtp_2 _237_ (
    .CLK(clk),
    .D(_018_),
    .Q(\tx_inst.next_state[2] )
  );
  sky130_fd_sc_hd__dfxtp_2 _238_ (
    .CLK(clk),
    .D(_019_),
    .Q(\tx_inst.tick[0] )
  );
  sky130_fd_sc_hd__dfxtp_2 _239_ (
    .CLK(clk),
    .D(_020_),
    .Q(\tx_inst.tick[1] )
  );
  sky130_fd_sc_hd__dfxtp_2 _240_ (
    .CLK(clk),
    .D(_021_),
    .Q(\tx_inst.tick[2] )
  );
  sky130_fd_sc_hd__dfxtp_2 _241_ (
    .CLK(clk),
    .D(_022_),
    .Q(\tx_inst.tick[3] )
  );
  sky130_fd_sc_hd__dfxtp_2 _242_ (
    .CLK(clk),
    .D(_023_),
    .Q(\tx_inst.u1_tx.acc[0] )
  );
  sky130_fd_sc_hd__dfxtp_2 _243_ (
    .CLK(clk),
    .D(_024_),
    .Q(\tx_inst.u1_tx.acc[1] )
  );
  sky130_fd_sc_hd__dfxtp_2 _244_ (
    .CLK(clk),
    .D(_025_),
    .Q(\tx_inst.u1_tx.acc[2] )
  );
  sky130_fd_sc_hd__dfxtp_2 _245_ (
    .CLK(clk),
    .D(_026_),
    .Q(\tx_inst.u1_tx.acc[3] )
  );
  sky130_fd_sc_hd__dfxtp_2 _246_ (
    .CLK(clk),
    .D(_027_),
    .Q(\tx_inst.u1_tx.acc[4] )
  );
  sky130_fd_sc_hd__dfxtp_2 _247_ (
    .CLK(clk),
    .D(_028_),
    .Q(\tx_inst.u1_tx.acc[5] )
  );
  sky130_fd_sc_hd__dfxtp_2 _248_ (
    .CLK(clk),
    .D(_029_),
    .Q(\tx_inst.u1_tx.acc[6] )
  );
  sky130_fd_sc_hd__dfxtp_2 _249_ (
    .CLK(clk),
    .D(_030_),
    .Q(\tx_inst.u1_tx.acc[7] )
  );
  sky130_fd_sc_hd__dfxtp_2 _250_ (
    .CLK(clk),
    .D(_031_),
    .Q(\tx_inst.u1_tx.acc[8] )
  );
  sky130_fd_sc_hd__dfxtp_2 _251_ (
    .CLK(clk),
    .D(_032_),
    .Q(\tx_inst.u1_tx.acc[9] )
  );
endmodule
