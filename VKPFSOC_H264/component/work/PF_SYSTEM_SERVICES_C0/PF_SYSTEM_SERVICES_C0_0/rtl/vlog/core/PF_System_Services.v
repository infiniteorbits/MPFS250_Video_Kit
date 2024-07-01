// ****************************************************************************/    
// Actel Corporation Proprietary and Confidential    
// Copyright 2010 Actel Corporation.  All rights reserved.    
//    
// ANY USE OR REDISTRIBUTION IN PART OR IN WHOLE MUST BE HANDLED IN    
// ACCORDANCE WITH THE ACTEL LICENSE AGREEMENT AND MUST BE APPROVED    
// IN ADVANCE IN WRITING.    
//    
// Description: CoreSysServices_PF - Top level RTL    
//    
// Revision Information:    
// Date            Description    
// ----            -----------------------------------------    
// 16May13         Inital. Ports and Parameters declaration    
//    
// SVN Revision Information:    
// SVN $Revision: 39010 $    
// SVN $Date: 2021-10-05 14:54:11 +0530 (Tue, 05 Oct 2021) $    
//    
// Resolved SARs    
// SAR      Date        Who   Description    
// 
// Notes:    
// 1. 09/Feb 2017 Removed signal ports at the top level required for SVG.
//                USR_SS_BUSY, USR_SS_REQ, USR_MBX_WRITE, USR_MBX_READ,
//                USR_MBX_ECC. Not required.
// v2.2   15/Mar/2017  IP  Removed support for Services 24h and 25h.
//        23/Mar/2017  IP  Logic for invalid_cmd generation updated
//                         accordingly.    
// v2.3   18/Aug/2017  IP  SAR#89098, added synchronizers w.r.t. IP Clock in the
//                         FF_TIMED_ENTRY/FF_NONTIMED_ENTRY signal.
//                         Updated/modified USR_BUSY logic  and also
//                         ca_hold_pready.
//                         Added SS_BUSY output.
//                         Delayed AMBA sysreq to the Arbiter  
// v2.4   30/Sep/2021  IP  Added Read eNVM parameter service (RDENVMPARAMETERS) 
//                         for PFSoC Only
//                        
// ****************************************************************************/    
`timescale 1 ns/10 ps    
 
  
module PF_SYSTEM_SERVICES_C0_PF_SYSTEM_SERVICES_C0_0_PF_SYSTEM_SERVICES (    
                                          CLK
                                          ,RESETN
                                          // APB Slave Signals
                                          ,APBS_PSEL
                                          ,APBS_PENABLE
                                          ,APBS_PWRITE
                                          ,APBS_PADDR
                                          ,APBS_PWDATA
                                          ,APBS_PRDATA
                                          ,APBS_PREADY
                                          ,APBS_PSLVERR                                          
                                          // User Signals
                                          ,USR_CMD_ERROR    
                                          ,USR_BUSY
                                          ,USR_RDVLD
                                          
                                          // AMBA User Signals
                                          ,SYSSERV_INIT_REQ
                                          // From F*F Interface Signals
                                          ,FF_TIMED_ENTRY
                                          ,FF_NONTIMED_ENTRY
                                          // To F*F Interface Signals
                                          ,FF_EXIT_STATUS                                          
                                          ,FF_US_RESTORE
                                          ,FF_INIT_REQ
                                          ,FF_OSC2MHZ_ON
					  ,SS_BUSY

                                          );
   


   //------------------------------------------------------------------------------    
   // Parameter declarations    
   //------------------------------------------------------------------------------    
   parameter FAMILY                 = 26;
   parameter SNSERVICE              = 0;
   parameter UCSERVICE              = 0;
   parameter DVSERVICE              = 0;
   parameter DCSERVICE              = 0;
   parameter RDDIGEST               = 0;
   parameter QUERYSECSERVICE        = 0; 
   parameter RDDEBUGINFO            = 0;
   parameter RDENVMPARAMETERS       = 0;   // AP :: Newly added for PFSoC only
   //parameter EXECUICSCRIPT          = 0;  
   //parameter UICAUTHBITSTREAM       = 0;  
   parameter AUTHBITSTREAM          = 0;
   parameter AUTHIAPIMG             = 0;
   
   parameter DIGSIGSERVICE          = 0;
   parameter SECNVMWR               = 0;
   parameter SECNVMRD               = 0;
   parameter PUFEMSERVICE           = 0;
   parameter NONCESERVICE           = 0;
    
   parameter FFSERVICE              = 0;
   parameter FF_TIMEOUT_VAL         = 'ha;
   parameter FF_MAILBOX_ADDR        = 'h8;
   parameter DIGESTCHECK            = 0;
   parameter IAPSERVICE             = 0;
   parameter IAPAUTOUPD             = 0;
   parameter OSC_2MHZ_ON            = 0;
   
   localparam EXECUICSCRIPT         = 0;  
   localparam UICAUTHBITSTREAM      = 0;  
   
   //------------------------------------------------------------------------------    
   // Port declarations    
   //------------------------------------------------------------------------------    
    
   // -----------    
   // Inputs    
   // -----------    
   input      CLK;    
   input      RESETN;  

   // APB Slave Signals
   input         APBS_PSEL;       
   input         APBS_PENABLE;    
   input         APBS_PWRITE;     
   input [31:0]  APBS_PADDR;
   input [31:0]  APBS_PWDATA;
   // AMBA User signals

   
   // F*F Signals
   input         FF_TIMED_ENTRY;    
   input         FF_NONTIMED_ENTRY;

   // -----------   
   // Outputs   
   // -----------   

   // APB Slave Signals
   output [31:0] APBS_PRDATA;
   output        APBS_PREADY;     
   output        APBS_PSLVERR;    
   // User Signals  
   output        USR_CMD_ERROR;
   output        USR_BUSY;
   output        USR_RDVLD;

   // AMBA User signals
   output        SYSSERV_INIT_REQ;
   // F*F Signals
   output [15:0] FF_EXIT_STATUS;      
   output        FF_US_RESTORE;     
   output        FF_INIT_REQ;
   output        FF_OSC2MHZ_ON;
   output        SS_BUSY;

   //------------------------------------------------------------------------------    
   // Internal Signals
   //------------------------------------------------------------------------------    
   wire [31:0]   APBS_PRDATA;
   wire          APBS_PREADY;     
   wire          APBS_PSLVERR;    
   wire [31:0]   ca_reg_mbxrdata;   
   wire [1:0]    ca_reg_mbxecc;    
   wire [31:0]   ac_calc_mbxwraddr;
   wire [31:0]   ac_calc_mbxrdaddr;
   wire          ca_unrecog_cmd;
   wire          ac_mbx_rddone;
   wire [15:0]   ca_reg_status;
   wire [15:0]   ac_reg_cmd;
   wire [3:0]    ac_reg_req;
   wire [8:0]    ac_reg_wcnt;
   wire [8:0]    ac_reg_rcnt;
   wire [31:0]   ac_reg_mbxwdata;
   wire          ca_sysserv_inprog;   
   wire          ca_ff_inprog;
   wire          ca_ss_busy;
   wire          ac_status_rddone;
   wire          ac_sysserv_busy;
   wire [15:0]   FF_EXIT_STATUS;
   wire          FF_INIT_REQ;
   wire          SYSSERV_INIT_REQ;
   wire          FF_OSC2MHZ_ON;
   wire          FF_US_RESTORE;
   wire          apb_serv_busy;
   wire          nonAPB_serv_busy; 
   wire          busy;
   wire          SS_BUSY;

   //////////////////////////////////////////////////////////////////////////////   
   //                           Start-of-Code                                  //   
   //////////////////////////////////////////////////////////////////////////////   

   // Instances:: APB Slave Interface
   CoreSysServices_PF_APBS #(
                              .FAMILY           (FAMILY               )
                             ,.SNSERVICE        (SNSERVICE            )
                             ,.UCSERVICE        (UCSERVICE            )
                             ,.DVSERVICE        (DVSERVICE            )
                             ,.DCSERVICE        (DCSERVICE            )
                             ,.RDDIGEST         (RDDIGEST             )
                             ,.QUERYSECSERVICE  (QUERYSECSERVICE      )
                             ,.RDDEBUGINFO      (RDDEBUGINFO          )
                             ,.RDENVMPARAMETERS (RDENVMPARAMETERS     )
                             ,.AUTHBITSTREAM    (AUTHBITSTREAM        )
                             ,.AUTHIAPIMG       (AUTHIAPIMG           )
                             ,.DIGSIGSERVICE    (DIGSIGSERVICE        )
                             ,.SECNVMWR         (SECNVMWR             )
                             ,.SECNVMRD         (SECNVMRD             )
                             ,.PUFEMSERVICE     (PUFEMSERVICE         )
                             ,.NONCESERVICE     (NONCESERVICE         )
                             ,.FFSERVICE        (FFSERVICE            )
                             ,.DIGESTCHECK      (DIGESTCHECK          )
                             ,.IAPSERVICE       (IAPSERVICE           )
                             ,.IAPAUTOUPD       (IAPAUTOUPD           )
                             )
     u_CoreSysServices_PF_APBS (    
                                     .PCLK              (CLK                 )
                                    ,.PRESETN           (RESETN              )
                                    // APB slave interface signals             
                                    ,.PSEL              (APBS_PSEL           )
                                    ,.PENABLE           (APBS_PENABLE        )
                                    ,.PWRITE            (APBS_PWRITE         )
                                    ,.PADDR             (APBS_PADDR          )
                                    ,.PWDATA            (APBS_PWDATA         )
                                    ,.PRDATA            (APBS_PRDATA         )
                                    ,.PREADY            (APBS_PREADY         )
                                    ,.PSLVERR           (APBS_PSLVERR        )
                                    // Signals to register block               
                                    ,.ac_reg_cmd        (ac_reg_cmd          )
                                    ,.ac_reg_req        (ac_reg_req          )
                                    ,.ac_reg_wcnt       (ac_reg_wcnt         )
                                    ,.ac_reg_rcnt       (ac_reg_rcnt         )
                                    ,.ac_reg_mbxwdata   (ac_reg_mbxwdata     )
                                    ,.ac_mbxwdata_upd   (ac_mbxwdata_upd     )
                                    ,.ac_mbxrdata_upd   (ac_mbxrdata_upd     )
                                    ,.ac_calc_mbxwraddr (ac_calc_mbxwraddr   )
                                    ,.ac_calc_mbxrdaddr (ac_calc_mbxrdaddr   )
                                    ,.ac_mbx_rddone     (ac_mbx_rddone       )
                                    ,.ac_status_rddone  (ac_status_rddone    )
                                    // Signals from register block             
                                    ,.ca_reg_busy       (ca_reg_busy         )
                                    ,.ca_reg_ack        (ca_reg_ack          )
                                    ,.ca_reg_status     (ca_reg_status       )
                                    ,.ca_status_wen     (ca_status_wen       )
                                    ,.ca_reg_wen        (ca_reg_wen          )
                                    ,.ca_main_reg_wen   (ca_main_reg_wen     ) 
                                    ,.ca_hold_pready    (ca_hold_pready      )
                                    ,.ca_clrmbxwdata_upd(ca_clrmbxwdata_upd  )
                                    ,.ca_clrmbxrdata_upd(ca_clrmbxrdata_upd  )
                                    ,.ca_reg_mbxrdata   (ca_reg_mbxrdata     )
                                    ,.ca_reg_mbxecc     (ca_reg_mbxecc       )
                                    ,.ca_unrecog_cmd    (ca_unrecog_cmd      )
                                    ,.ca_mbx_ren        (ca_mbx_ren          )
                                    ,.ca_sysserv_inprog (ca_sysserv_inprog   )
                                    ,.ca_ff_inprog      (ca_ff_inprog        )
                                    ,.ca_ss_busy        (ca_ss_busy          )
                                    // To Top                              
                                    ,.apb_serv_busy     (apb_serv_busy       )
                                    ,.nonAPB_serv_busy  (nonAPB_serv_busy    )    
                                    ,.apb_rdvld         (USR_RDVLD           )
                                    ,.apb_unrecog_cmd   (USR_CMD_ERROR       )
                                    ,.ac_sysserv_busy   (ac_sysserv_busy     )
                                    ,.ff_timed_entry    (FF_TIMED_ENTRY      )
                                    ,.ff_nontimed_entry (FF_NONTIMED_ENTRY   )

                                    );

   

   // Instance:: CoreSysServices_PF_Ctrl
   CoreSysServices_PF_Ctrl #(
                              .FAMILY           (FAMILY               )
                             ,.SNSERVICE        (SNSERVICE            )
                             ,.UCSERVICE        (UCSERVICE            )
                             ,.DVSERVICE        (DVSERVICE            )
                             ,.DCSERVICE        (DCSERVICE            )
                             ,.RDDIGEST         (RDDIGEST             )
                             ,.QUERYSECSERVICE  (QUERYSECSERVICE      )
                             ,.RDDEBUGINFO      (RDDEBUGINFO          )
                             ,.RDENVMPARAMETERS (RDENVMPARAMETERS     )
                             ,.EXECUICSCRIPT    (EXECUICSCRIPT        )  
                             ,.UICAUTHBITSTREAM (UICAUTHBITSTREAM     )  
                             ,.AUTHBITSTREAM    (AUTHBITSTREAM        )
                             ,.AUTHIAPIMG       (AUTHIAPIMG           )
                             ,.DIGSIGSERVICE    (DIGSIGSERVICE        )
                             ,.SECNVMWR         (SECNVMWR             )
                             ,.SECNVMRD         (SECNVMRD             )
                             ,.PUFEMSERVICE     (PUFEMSERVICE         )
                             ,.NONCESERVICE     (NONCESERVICE         )
                             ,.FFSERVICE        (FFSERVICE            )
                             ,.FF_TIMEOUT_VAL   (FF_TIMEOUT_VAL       )
                             ,.FF_MAILBOX_ADDR  (FF_MAILBOX_ADDR      )  
                             ,.DIGESTCHECK      (DIGESTCHECK          )
                             ,.IAPSERVICE       (IAPSERVICE           )
                             ,.IAPAUTOUPD       (IAPAUTOUPD           )
                             ,.OSC_2MHZ_ON      (OSC_2MHZ_ON          )
                             )
     u_CoreSysServices_PF_Ctrl(    
                                    .CLK                   (CLK                  )
                                   ,.RESETN                (RESETN               )
                                   // Signals from APBS register block
                                   ,.ac_reg_cmd            (ac_reg_cmd           )
                                   ,.ac_reg_req            (ac_reg_req           )
                                   ,.ac_reg_wcnt           (ac_reg_wcnt          )
                                   ,.ac_reg_rcnt           (ac_reg_rcnt          )
                                   ,.ac_reg_mbxwdata       (ac_reg_mbxwdata      )
                                   ,.ac_mbxwdata_upd       (ac_mbxwdata_upd      )
                                   ,.ac_mbxrdata_upd       (ac_mbxrdata_upd      )
                                   ,.ac_calc_mbxwraddr     (ac_calc_mbxwraddr    )
                                   ,.ac_calc_mbxrdaddr     (ac_calc_mbxrdaddr    )
                                   ,.ac_status_rddone      (ac_status_rddone     )
                                   // Signals to APBS register block
                                   ,.ca_reg_busy           (ca_reg_busy          )
                                   ,.ca_reg_ack            (ca_reg_ack           )
                                   ,.ca_reg_status         (ca_reg_status        )
                                   ,.ca_status_wen         (ca_status_wen        )
                                   ,.ca_reg_wen            (ca_reg_wen           )
                                   ,.ca_reg_ren            (ca_reg_ren           )
                                   ,.ca_main_reg_wen       (ca_main_reg_wen      )
                                   ,.ca_reg_mbxrdata       (ca_reg_mbxrdata      )
                                   ,.ca_reg_mbxecc         (ca_reg_mbxecc        )
                                   ,.ca_hold_pready        (ca_hold_pready       )
                                   ,.ca_clrmbxwdata_upd    (ca_clrmbxwdata_upd   )
                                   ,.ca_clrmbxrdata_upd    (ca_clrmbxrdata_upd   )
                                   ,.ca_unrecog_cmd        (ca_unrecog_cmd       )
                                   ,.ca_mbx_ren            (ca_mbx_ren           )

                                   ,.ca_sysserv_inprog     (ca_sysserv_inprog    )
                                   ,.ca_ff_inprog          (ca_ff_inprog         )
                                   ,.ca_ss_busy            (ca_ss_busy           )
                                   ,.ff_timed_entry        (FF_TIMED_ENTRY       )
                                   ,.ff_nontimed_entry     (FF_NONTIMED_ENTRY    )
                                   ,.ac_sysserv_busy       (ac_sysserv_busy      ) 

                                   // To top-level
                                   ,.ff_exit_status        (FF_EXIT_STATUS       )
                                   ,.ff_init_req           (FF_INIT_REQ          )
                                   // To USer Signals
                                   ,.ss_busy               (SS_BUSY              ) 
                                   ,.ss_status             (                     )
                                   ,.ss_req                (                     ) 
                                   ,.mbx_write             (                     ) 
                                   ,.mbx_read              (                     ) 
                                   ,.mbx_ecc               (                     ) 
                                   ,.sysserv_init_req      (SYSSERV_INIT_REQ     )
                                   ,.ff_osc2mhz_on         (FF_OSC2MHZ_ON        )
                                   ,.ff_us_restore         (FF_US_RESTORE        )
                                   ,.apb_serv_busy         (apb_serv_busy        )  
                                   ,.nonAPB_serv_busy      (nonAPB_serv_busy     )    
                                   ,.USR_BUSY              (USR_BUSY             )  
                                   );


endmodule // PF_SYSTEM_SERVICES_C0_PF_SYSTEM_SERVICES_C0_0_PF_SYSTEM_SERVICES

