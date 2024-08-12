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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE STD.TEXTIO.ALL;
USE IEEE.STD_LOGIC_TEXTIO.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;
USE IEEE.NUMERIC_STD.ALL;
--=================================================================================================
-- Image_Enhancement_tb entity declaration
--=================================================================================================
ENTITY Image_Enhancement_tb IS
END Image_Enhancement_tb;
--=================================================================================================
-- Image_Enhancement_tb architecture body
--=================================================================================================
ARCHITECTURE behavioral OF Image_Enhancement_tb IS

COMPONENT Image_Enhancement_C0 IS
PORT(
    RESETN_I                            : IN STD_LOGIC;
    SYS_CLK_I                          	: IN STD_LOGIC;	
	DATA_VALID_I					    : IN STD_LOGIC;
	ENABLE_I							: IN STD_LOGIC;
	R_I									: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	G_I									: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	B_I									: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
	R_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	G_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	B_CONST_I							: IN STD_LOGIC_VECTOR(9 DOWNTO 0);
	COMMON_CONST_I						: IN STD_LOGIC_VECTOR(19 DOWNTO 0);
	DATA_VALID_O						: OUT STD_LOGIC;	
	R_O                         		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	G_O                        	   		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
	B_O                          		: OUT STD_LOGIC_VECTOR(7 DOWNTO 0)
);
END COMPONENT;
--=================================================================================================
-- Signal declarations
--=================================================================================================
--CONSTANT G_PIXEL_WIDTH                 : INTEGER := 8;
CONSTANT SYSCLK_PERIOD                 : TIME := 100 ns;
SIGNAL sys_clk_tb                      : STD_LOGIC:= '0';
SIGNAL reset_tb                        : STD_LOGIC:= '0';
--TYPE inputs IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
TYPE inputs IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
--TYPE outputs IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(23 DOWNTO 0);
TYPE outputs IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(7 DOWNTO 0);
TYPE pixel_const IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(9 DOWNTO 0);
TYPE second_const IS ARRAY (0 to 9) OF STD_LOGIC_VECTOR(19 DOWNTO 0);
CONSTANT data_input_tb_r : inputs := 	  (x"05",
										   x"12",
										   x"25",
										   x"35",
										   x"45",
										   x"58",
										   x"76",
										   x"A2",
										   x"CD",
										   x"E0");
										   
CONSTANT data_input_tb_g : inputs := 	  (x"06",
										   x"13",
										   x"28",
										   x"12",
										   x"67",
										   x"92",
										   x"89",
										   x"30",
										   x"12",
										   x"00"); 
										   
CONSTANT data_input_tb_b : inputs := 	  (x"07",
										   x"14",
										   x"35",
										   x"67",
										   x"12",
										   x"AA",
										   x"0A",
										   x"12",
										   x"A7",
										   x"00");
										   
CONSTANT second_const_tb : second_const := (x"00100",
										   x"00200",
										   x"00300",
										   x"00400",
										   x"00500",
										   x"00600",
										   x"00700",
										   x"00800",
										   x"00900",
										   x"00A00");
										   
CONSTANT r_const_tb : pixel_const    :=   ("00" & x"01",
										   "00" & X"25",
										   "00" & X"32",
										   "00" & X"64",
										   "00" & X"84",
										   "00" & X"90",
										   "00" & X"AB",
										   "00" & X"D3",
										   "01" & X"E5",
										   "01" & X"FF");
										   
CONSTANT g_const_tb : pixel_const    :=   ("01" & x"F0",
										   "01" & X"E5",
										   "00" & X"B2",
										   "00" & X"64",
										   "00" & X"34",
										   "00" & X"20",
										   "00" & X"1B",
										   "00" & X"13",
										   "00" & X"05",
										   "00" & X"F1");
										   
CONSTANT b_const_tb : pixel_const    :=   ("00" & x"25",
										   "00" & X"37",
										   "00" & X"50",
										   "00" & X"64",
										   "00" & X"91",
										   "00" & X"F0",
										   "00" & X"AB",
										   "00" & X"80",
										   "01" & X"12",
										   "01" & X"F3");
										   
CONSTANT output_desired_r : outputs := 	  (x"02",
										   x"09",
										   x"14",
										   x"31",
										   x"51",
										   x"6F",
										   x"AB",
										   x"FF",
										   x"FF",
										   x"FF");
										   
CONSTANT output_desired_g : outputs := 	  (x"19",
										   x"4B",
										   x"3D",
										   x"16",
										   x"33",
										   x"30",
										   x"2A",
										   x"17",
										   x"12",
										   x"14");
										   
CONSTANT output_desired_b : outputs := 	  (x"04",
										   x"0C",
										   x"27",
										   x"58",
										   x"1E",
										   x"FF",
										   x"1B",
										   x"22",
										   x"FF",
										   x"14");
SIGNAL output_dut_r : outputs;
SIGNAL output_dut_g : outputs;
SIGNAL output_dut_b : outputs;
										   
SIGNAL enable_i_tb                      : STD_LOGIC;
SIGNAL data_valid_i_tb                  : STD_LOGIC;
SIGNAL data_valid_o_tb                  : STD_LOGIC;



PROCEDURE print_file (FILE   file_pointer3: TEXT;text: IN string);

PROCEDURE print(text : in string);
PROCEDURE print_val(FILE   file_pointer3: TEXT;
                    text1 : in string;
                    text2 : in string;
                    text3 : in string
					);
                    
PROCEDURE print_text_val(text1 : in string;
				val   : in integer;
				text2 : in string);
--================================================================
-- PROCEDURE   : PRINT_FILE_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message in an output file
--================================================================

PROCEDURE print_file (   FILE   file_pointer3: TEXT;
                    text: IN string
                ) IS
    VARIABLE msg_line       : LINE;
BEGIN
    write(msg_line, text);
    writeline(file_pointer3, msg_line);
END print_file;

--================================================================
-- PROCEDURE   : PRINT_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message on the transcript window
--================================================================

PROCEDURE print(text : in string) is
     variable msg_line: line;
     begin
        write    (msg_line, text);
        writeline(output, msg_line);
   end print;
   
--================================================================
-- PROCEDURE   : PRINT_VAL_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message and value on the transcript window
--================================================================   
procedure print_val(FILE   file_pointer3: TEXT;
                  text1 : in string;
                  text2 : in string;
                  text3 : in string
			) is
    variable msg_line: line;
    begin
        write    (msg_line, text1);
        write    (msg_line, text2);
        write    (msg_line, text3);
        writeline(file_pointer3, msg_line);
end print_val;


-- ================================================================
-- PROCEDURE   : PRINT_TEXT_VAL_PROCEDURE
-- DESCRIPTION : Procedure to print_file a message and value on the transcript window
-- ================================================================   
PROCEDURE print_text_val(text1 : in string;
				val   : in integer;
				text2 : in string) is
     variable msg_line: line;
     begin
        write    (msg_line, text1);
        write    (msg_line, val);
		write    (msg_line, text2);
        writeline(output, msg_line);
   end print_text_val;
BEGIN
--------------------------------------------------------------------------
-- Name       : RESET_GEN_PROC
-- Description: Process generates the reset signal
--------------------------------------------------------------------------
RESET_GEN_PROC:
    PROCESS
        VARIABLE vhdl_initial : BOOLEAN := TRUE;
    BEGIN
        IF ( vhdl_initial ) THEN
            reset_tb <= '0';
			data_valid_i_tb <= '0';
			enable_i_tb     <= '0';
            WAIT FOR ( SYSCLK_PERIOD * 10 );
            reset_tb <= '1';
			data_valid_i_tb <= '1';
			enable_i_tb <= '1';
            WAIT;
        END IF;
    END PROCESS;

--------------------------------------------------------------------------------
-- Name       : COMPARE_PROC
-- Description: Process compare the actual output and the desired output signals
--------------------------------------------------------------------------------
COMPARE:
    PROCESS
    BEGIN
	    WAIT UNTIL (data_valid_o_tb);
        WAIT UNTIL (sys_clk_tb);
			print("");
			print("");
			print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			print("<<<<       START OF IMAGE_ENHANCEMENT IP SIMULATION                 >>>>");
			print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
        FOR J IN 0 TO 9 LOOP
			
			print("                                                                 ");
			print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			print_text_val("|   TESTCASE   :  ",(J),"                                        |");
			print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			print("   INPUTS                                                      ");
			--print_text_val("       DATA_INPUT  =  ",(to_integer(unsigned(data_input_tb(J)))),"                        ");
			print_text_val("       DATA_INPUT_R  =  ",(to_integer(unsigned(data_input_tb_r(J)))),"                        ");
			print_text_val("       DATA_INPUT_G  =  ",(to_integer(unsigned(data_input_tb_g(J)))),"                        ");
			print_text_val("       DATA_INPUT_B  =  ",(to_integer(unsigned(data_input_tb_b(J)))),"                        ");
			print_text_val("       SECOND_CONST_INPUT   =  ",(to_integer(unsigned(second_const_tb(J)))),"                   ");
			print_text_val("       R_CONST_INPUT  =  ",(to_integer(unsigned(r_const_tb(J)))),"                        ");
			print_text_val("       G_CONST_INPUT  =  ",(to_integer(unsigned(g_const_tb(J)))),"                        ");
			print_text_val("       B_CONST_INPUT  =  ",(to_integer(unsigned(b_const_tb(J)))),"                        ");
			print("                                                                ");
			print("   OUTPUTS                                                    ");
			print_text_val("       DESIRED_OUTPUT_R  =  ",(to_integer(unsigned(output_desired_r(J)))),"                       ");
			print_text_val("       DUT_OUTPUT_R  =  ",(to_integer(unsigned(output_dut_r(J)))),"                       ");
			print_text_val("       DESIRED_OUTPUT_G  =  ",(to_integer(unsigned(output_desired_g(J)))),"                       ");
			print_text_val("       DUT_OUTPUT_G  =  ",(to_integer(unsigned(output_dut_g(J)))),"                       ");
			print_text_val("       DESIRED_OUTPUT_B  =  ",(to_integer(unsigned(output_desired_b(J)))),"                       ");
			print_text_val("       DUT_OUTPUT_B  =  ",(to_integer(unsigned(output_dut_b(J)))),"                       ");
			IF((output_dut_r(J) = output_desired_r(J)) and (output_dut_g(J) = output_desired_g(J)) and (output_dut_b(J) = output_desired_b(J)))  THEN
				print("                                                           ");
				print("     STATUS            :  PASSED                           ");
				print("     DESCRIPTION       :  TB AND DUT OUTPUTS MATCH         ");
				print("                                                           ");
			ELSE
				print("                                                           ");
				print("     STATUS            :  FAILED                           ");
				print("     DESCRIPTION       :  TB AND DUT OUTPUTS DO NOT MATCH  ");
				print("                                                           ");
			END IF;	
		END LOOP;
		print("");
		print("");
		print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		print("<<<<       END OF IMAGE_ENHANCEMENT IP SIMULATION                 >>>>");
		print("<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
		WAIT;
    END PROCESS;	
--------------------------------------------------------------------------
-- Name       : CLOCK_GEN
-- Description: Logic generates 10 Mhz clock
--------------------------------------------------------------------------
sys_clk_tb <= NOT sys_clk_tb AFTER (SYSCLK_PERIOD / 2.0 );

--=================================================================================================
-- Component Instantiations
--=================================================================================================
-------------------------------------------------
-- BLDC_ESTIMATOR_UUT_INST
-------------------------------------------------
GEN_TEST: FOR I IN 0 TO 9 GENERATE
IMAGE_ENHANCEMENT_INST: Image_Enhancement_C0
PORT MAP(
    RESETN_I                           => reset_tb,
    SYS_CLK_I                          => sys_clk_tb,
    DATA_VALID_I                       => data_valid_i_tb,
	ENABLE_I                           => enable_i_tb,
	R_I								   => data_input_tb_r(I),
	G_I								   => data_input_tb_g(I),
	B_I								   => data_input_tb_b(I),
    R_CONST_I                          => r_const_tb(I),
    G_CONST_I                          => g_const_tb(I),
    B_CONST_I                   	   => b_const_tb(I),
	COMMON_CONST_I                     => second_const_tb(I),
    DATA_VALID_O                       => data_valid_o_tb,
	R_O								   => output_dut_r(I),
	G_O								   => output_dut_g(I),
	B_O								   => output_dut_b(I)
);
END GENERATE GEN_TEST;
END behavioral;
