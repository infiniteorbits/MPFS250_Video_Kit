--=================================================================================================
-- File Name                           : display_enhancement_tb.vhd
-- Description                         : This module implements the test environment for
--                                       Image_Enhancement block
-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--
-- SVN Revision Information            :
-- SVN $Revision                       :
-- SVN $Date                           :
--
-- COPYRIGHT 2015 BY MICROSEMI
-- THE INFORMATION CONTAINED IN THIS DOCUMENT IS SUBJECT TO LICENSING RESTRICTIONS FROM MICROSEMI
-- CORP. IF YOU ARE NOT IN POSSESSION OF WRITTEN AUTHORIZATION FROM MICROSEMI FOR USE OF THIS
-- FILE, THEN THE FILE SHOULD BE IMMEDIATELY DESTROYED AND NO BACK-UP OF THE FILE SHOULD BE MADE.
--
--=================================================================================================

--=================================================================================================
-- Libraries
--=================================================================================================
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use IEEE.STD_LOGIC_SIGNED.all;
use IEEE.NUMERIC_STD.all;
--=================================================================================================
-- Image_Enhancement_tb entity declaration
--=================================================================================================
entity Image_Enhancement_tb is
end Image_Enhancement_tb;
--=================================================================================================
-- Image_Enhancement_tb architecture body
--=================================================================================================
architecture behavioral of Image_Enhancement_tb is

  component Image_Enhancement is
    generic(
-- Generic List
      -- Specifies the data width
      G_PIXEL_WIDTH     : integer range 8 to 16   := 8;
      G_PIXELS          : integer                 := 1;  --  1= one pixel and 4= 4pixels (4k) 
      G_AXI4Stream      : integer range 0 to 1    := 0;  --  0= Native and 1= Image_Enhancement with AXI Stream
      G_RCONST          : natural range 0 to 1023 := 146;
      G_GCONST          : natural range 0 to 1023 := 122;
      G_BCONST          : natural range 0 to 1023 := 165;
      G_COMMON_CONSTANT : natural                 := 1046528
      );
    port (
-- Port List
      RESETN_I      : in std_logic;     -- System reset
      SYS_CLK_I     : in std_logic;     -- System clock
      DATA_VALID_I  : in std_logic;  -- Specifies the input data is valid or not
      FRAME_START_I : in std_logic;
      R_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);  -- data input
      G_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);
      B_I           : in std_logic_vector (G_PIXELS*G_PIXEL_WIDTH - 1 downto 0);

      ACLK_I    : in  std_logic;
      ARESETN_I : in  std_logic;
      awvalid   : in  std_logic;
      awready   : out std_logic;
      awaddr    : in  std_logic_vector(31 downto 0);
      wdata     : in  std_logic_vector(31 downto 0);
      wvalid    : in  std_logic;
      wready    : out std_logic;
      bresp     : out std_logic_vector(1 downto 0);
      bvalid    : out std_logic;
      bready    : in  std_logic;
      araddr    : in  std_logic_vector(31 downto 0);
      arvalid   : in  std_logic;
      arready   : out std_logic;
      rready    : in  std_logic;
      rdata     : out std_logic_vector(31 downto 0);
      rresp     : out std_logic_vector(1 downto 0);
      rvalid    : out std_logic;

      -- Filtered Output 
      --DATA_O : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      DATA_VALID_O : out std_logic;     -- Specifies the valid RGB data
      Y_AVG_O    : out std_logic_vector(31 downto 0);
      R_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      G_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      B_O          : out std_logic_vector(G_PIXELS*G_PIXEL_WIDTH-1 downto 0);

      TDATA_I  : in  std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      TVALID_I : in  std_logic;
      TREADY_O : out std_logic;
      TUSER_I  : in  std_logic_vector(3 downto 0);
      -- Data output from MASTER1
      TDATA_O  : out std_logic_vector(3*G_PIXELS*G_PIXEL_WIDTH-1 downto 0);
      TLAST_O  : out std_logic;
      TUSER_O  : out std_logic_vector(3 downto 0);
      -- Specifies the valid control signal from MASTER1
      TVALID_O : out std_logic;
      TSTRB_O  : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0);
      TKEEP_O  : out std_logic_vector(G_PIXEL_WIDTH/8 - 1 downto 0)
      );
  end component Image_Enhancement;

--=================================================================================================
-- Signal declarations
--=================================================================================================
--CONSTANT G_PIXEL_WIDTH                 : INTEGER := 8;
  constant SYSCLK_PERIOD : time      := 100 ns;
  constant ACLK_PERIOD   : time      := 500 ns;
  signal sys_clk_tb      : std_logic := '0';
  signal reset_tb        : std_logic := '0';
  signal s_frame_start   : std_logic := '0';
  type inputs is array (0 to 9) of std_logic_vector(7 downto 0);
  type outputs is array (0 to 9) of std_logic_vector(7 downto 0);
  type pixel_const is array (0 to 9) of natural range 0 to 1023;
  type second_const is array (0 to 9) of natural range 0 to 1048575;
  constant data_input_tb_r : inputs := (x"05",
                                        x"12",
                                        x"25",
                                        x"35",
                                        x"45",
                                        x"58",
                                        x"76",
                                        x"A2",
                                        x"CD",
                                        x"E0");

  constant data_input_tb_g : inputs := (x"06",
                                        x"13",
                                        x"28",
                                        x"12",
                                        x"67",
                                        x"92",
                                        x"89",
                                        x"30",
                                        x"12",
                                        x"00");

  constant data_input_tb_b : inputs := (x"07",
                                        x"14",
                                        x"35",
                                        x"67",
                                        x"12",
                                        x"AA",
                                        x"0A",
                                        x"12",
                                        x"A7",
                                        x"00");

  constant r_const_tb      : pixel_const  := (1, 37, 50, 100, 132, 144, 171, 211, 485, 511);
  constant g_const_tb      : pixel_const  := (496, 485, 178, 100, 52, 32, 27, 19, 5, 241);
  constant b_const_tb      : pixel_const  := (37, 55, 80, 100, 145, 240, 171, 128, 274, 499);
  constant second_const_tb : second_const := (256, 512, 768, 1024, 1280, 1536, 1792, 2048, 2304, 2560);

  constant output_desired_r : outputs := (x"02",
                                          x"09",
                                          x"14",
                                          x"31",
                                          x"51",
                                          x"6F",
                                          x"AB",
                                          x"FF",
                                          x"FF",
                                          x"FF");

  constant output_desired_g : outputs := (x"19",
                                          x"4B",
                                          x"3D",
                                          x"16",
                                          x"33",
                                          x"30",
                                          x"2A",
                                          x"17",
                                          x"12",
                                          x"14");

  constant output_desired_b : outputs := (x"04",
                                          x"0C",
                                          x"27",
                                          x"58",
                                          x"1E",
                                          x"FF",
                                          x"1B",
                                          x"22",
                                          x"FF",
                                          x"14");
  signal output_dut_r : outputs;
  signal output_dut_g : outputs;
  signal output_dut_b : outputs;

  signal enable_i_tb     : std_logic;
  signal data_valid_i_tb : std_logic;
  signal data_valid_o_tb : std_logic;

  signal s_awvalid : std_logic                     := '0';
  signal s_awready : std_logic;
  signal s_awaddr  : std_logic_vector(31 downto 0) := (others => '0');
  signal s_wdata   : std_logic_vector(31 downto 0);
  signal s_wvalid  : std_logic;
  signal s_wready  : std_logic;
  signal s_bresp   : std_logic_vector(1 downto 0);
  signal s_bvalid  : std_logic;
  signal s_bready  : std_logic                     := '0';
  signal s_araddr  : std_logic_vector(31 downto 0) := (others => '0');
  signal s_arvalid : std_logic                     := '0';
  signal s_arready : std_logic;
  signal s_rready  : std_logic                     := '0';
  signal s_rdata   : std_logic_vector(31 downto 0);
  signal s_rresp   : std_logic_vector(1 downto 0);
  signal s_rvalid  : std_logic;

  procedure print_file (file file_pointer3 :    text; text : in string);
  procedure print(text                     : in string);
  procedure print_val(file file_pointer3 :    text;
                      text1              : in string;
                      text2              : in string;
                      text3              : in string
                      );

  procedure print_text_val(text1 : in string;
                           val   : in integer;
                           text2 : in string);
--================================================================
-- PROCEDURE   : PRINT_FILE_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message in an output file
--================================================================

  procedure print_file (file file_pointer3 :    text;
                        text               : in string
                        ) is
    variable msg_line : line;
  begin
    write(msg_line, text);
    writeline(file_pointer3, msg_line);
  end print_file;

--================================================================
-- PROCEDURE   : PRINT_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message on the transcript window
--================================================================

  procedure print(text : in string) is
    variable msg_line : line;
  begin
    write (msg_line, text);
    writeline(output, msg_line);
  end print;

--================================================================
-- PROCEDURE   : PRINT_VAL_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message and value on the transcript window
--================================================================   
  procedure print_val(file file_pointer3 :    text;
                      text1              : in string;
                      text2              : in string;
                      text3              : in string
                      ) is
    variable msg_line : line;
  begin
    write (msg_line, text1);
    write (msg_line, text2);
    write (msg_line, text3);
    writeline(file_pointer3, msg_line);
  end print_val;


-- ================================================================
-- PROCEDURE   : PRINT_TEXT_VAL_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message and value on the transcript window
-- ================================================================   
  procedure print_text_val(text1 : in string;
                           val   : in integer;
                           text2 : in string) is
    variable msg_line : line;
  begin
    write (msg_line, text1);
    write (msg_line, val);
    write (msg_line, text2);
    writeline(output, msg_line);
  end print_text_val;





begin
--------------------------------------------------------------------------
-- Name       : RESET_GEN_PROC
-- Description: Process generates the reset signal
--------------------------------------------------------------------------
  RESET_GEN_PROC :
  process
    variable vhdl_initial : boolean := true;
  begin

    if (vhdl_initial) then
      reset_tb        <= '0';
      data_valid_i_tb <= '0';
      enable_i_tb     <= '0';
      s_frame_start   <= '0';

      wait for (SYSCLK_PERIOD * 10);
      reset_tb        <= '1';
      wait for (SYSCLK_PERIOD * 10);          
      data_valid_i_tb <= '1';
      enable_i_tb     <= '1';
      wait for (SYSCLK_PERIOD * 10);                
      s_frame_start   <= '1';
      wait for (SYSCLK_PERIOD);
      s_frame_start   <= '0';
      wait for (SYSCLK_PERIOD * 10000);
      s_frame_start   <= '1';
      wait for (SYSCLK_PERIOD);
      s_frame_start   <= '0';      
      wait;

    end if;
  end process;



--------------------------------------------------------------------------------
-- Name       : COMPARE_PROC
-- Description: Process compare the actual output and the desired output signals
--------------------------------------------------------------------------------
  COMPARE :
  process
  begin

    wait until (data_valid_o_tb);
    wait until (sys_clk_tb);

    print("");
    print("");
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print("<<<<       START OF IMAGE_ENHANCEMENT IP SIMULATION                 >>>>");
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    for J in 0 to 9 loop

      print("                                                                 ");
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print_text_val("|   TESTCASE   :  ", (J), "                                        |");
      print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
      print("   INPUTS                                                      ");
      --print_text_val("       DATA_INPUT  =  ",(to_integer(unsigned(data_input_tb(J)))),"                        ");
      print_text_val("       DATA_INPUT_R  =  ", (to_integer(unsigned(data_input_tb_r(J)))), "                        ");
      print_text_val("       DATA_INPUT_G  =  ", (to_integer(unsigned(data_input_tb_g(J)))), "                        ");
      print_text_val("       DATA_INPUT_B  =  ", (to_integer(unsigned(data_input_tb_b(J)))), "                        ");

      print_text_val("       SECOND_CONST_INPUT   =  ", second_const_tb(J), "                   ");
      print_text_val("       R_CONST_INPUT  =  ", r_const_tb(J), "                        ");
      print_text_val("       G_CONST_INPUT  =  ", g_const_tb(J), "                        ");
      print_text_val("       B_CONST_INPUT  =  ", b_const_tb(J), "                        ");
      print("                                                                ");
      print("   OUTPUTS                                                    ");
      print_text_val("       DESIRED_OUTPUT_R  =  ", (to_integer(unsigned(output_desired_r(J)))), "                       ");
      print_text_val("       DUT_OUTPUT_R  =  ", (to_integer(unsigned(output_dut_r(J)))), "                       ");
      print_text_val("       DESIRED_OUTPUT_G  =  ", (to_integer(unsigned(output_desired_g(J)))), "                       ");
      print_text_val("       DUT_OUTPUT_G  =  ", (to_integer(unsigned(output_dut_g(J)))), "                       ");
      print_text_val("       DESIRED_OUTPUT_B  =  ", (to_integer(unsigned(output_desired_b(J)))), "                       ");
      print_text_val("       DUT_OUTPUT_B  =  ", (to_integer(unsigned(output_dut_b(J)))), "                       ");
      if((output_dut_r(J) = output_desired_r(J)) and (output_dut_g(J) = output_desired_g(J)) and (output_dut_b(J) = output_desired_b(J))) then
        print("                                                           ");
        print("     STATUS            :  PASSED                           ");
        print("     DESCRIPTION       :  TB AND DUT OUTPUTS MATCH         ");
        print("                                                           ");
      else
        print("                                                           ");
        print("     STATUS            :  FAILED                           ");
        print("     DESCRIPTION       :  TB AND DUT OUTPUTS DO NOT MATCH  ");
        print("                                                           ");
      end if;
    end loop;
    print("");
    print("");
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    print("<<<<       END OF IMAGE_ENHANCEMENT IP SIMULATION                 >>>>");
    print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
    wait;
  end process;
--------------------------------------------------------------------------
-- Name       : CLOCK_GEN
-- Description: Logic generates 10 Mhz clock
--------------------------------------------------------------------------
  sys_clk_tb <= not sys_clk_tb after (SYSCLK_PERIOD / 2.0);

--=================================================================================================
-- Component Instantiations
--=================================================================================================
-------------------------------------------------
-- BLDC_ESTIMATOR_UUT_INST
-------------------------------------------------
  GEN_TEST : for I in 0 to 9 generate
    IMAGE_ENHANCEMENT_INST : Image_Enhancement
      generic map (
        G_PIXEL_WIDTH     => 8,
        G_PIXELS          => 1,
        G_AXI4Stream      => 0,
        G_RCONST          => r_const_tb(I),
        G_GCONST          => g_const_tb(I),
        G_BCONST          => b_const_tb(I),
        G_COMMON_CONSTANT => second_const_tb(I)
        )
      port map (
        RESETN_I      => reset_tb,
        SYS_CLK_I     => sys_clk_tb,
        DATA_VALID_I  => data_valid_i_tb,
        FRAME_START_I => s_frame_start,
        R_I           => data_input_tb_r(I),
        G_I           => data_input_tb_g(I),
        B_I           => data_input_tb_b(I),
        DATA_VALID_O  => data_valid_o_tb,
        R_O           => output_dut_r(I),
        G_O           => output_dut_g(I),
        B_O           => output_dut_b(I),
        Y_AVG_O     => open,

        ACLK_I    => sys_clk_tb,
        ARESETN_I => reset_tb,
        awvalid   => s_awvalid,
        awready   => s_awready,
        awaddr    => s_awaddr,
        wdata     => s_wdata,
        wvalid    => s_wvalid,
        wready    => s_wready,
        bresp     => s_bresp,
        bvalid    => s_bvalid,
        bready    => s_bready,
        araddr    => s_araddr,
        arvalid   => s_arvalid,
        arready   => s_arready,
        rready    => s_rready,
        rdata     => s_rdata,
        rresp     => s_rresp,
        rvalid    => s_rvalid,

        TDATA_I  => (others => '0'),
        TVALID_I => '0',
        TREADY_O => open,
        TUSER_I  => (others => '0'),
        TDATA_O  => open,
        TLAST_O  => open,
        TUSER_O  => open,
        TVALID_O => open,
        TSTRB_O  => open,
        TKEEP_O  => open
        );
  end generate GEN_TEST;

end behavioral;
