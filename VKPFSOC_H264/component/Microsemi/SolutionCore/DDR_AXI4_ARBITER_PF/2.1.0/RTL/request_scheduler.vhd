--=================================================================================================
-- File Name                           : request_scheduler.vhd


-- Targeted device                     : Microsemi-SoC
-- Author                              : India Solutions Team
--

-- COPYRIGHT 2019 BY MICROSEMI
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
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
--=================================================================================================
-- request_scheduler entity declaration
--=================================================================================================
ENTITY request_scheduler IS
PORT (
--Port list
    -- system reset
    reset_i                            	: IN  STD_LOGIC;

    -- system clock
    sys_clk_i                          	: IN  STD_LOGIC;
	
	--Acknowledge input from Write Master
    ack_i	                          	: IN  STD_LOGIC;
	
	--Read/Write request from DDR Write Controllers 0-3
	req0_i							    : IN STD_LOGIC;
	req1_i							    : IN STD_LOGIC;
	req2_i							    : IN STD_LOGIC;
	req3_i							    : IN STD_LOGIC;
	req4_i							    : IN STD_LOGIC;
	req5_i							    : IN STD_LOGIC;
	req6_i							    : IN STD_LOGIC;
	req7_i							    : IN STD_LOGIC;
	
	--Done signal from Write Master
	done_i								: IN STD_LOGIC;
	
	--Request output signal to DDR Write Controllers
	req_o								: OUT STD_LOGIC;
	
	--Mux selection output for channel selection
	mux_sel_o							: OUT STD_LOGIC_VECTOR(2 DOWNTO 0)
);
END request_scheduler;

--=================================================================================================
-- request_scheduler architecture body
--=================================================================================================
ARCHITECTURE request_scheduler OF request_scheduler IS

--=================================================================================================
-- Component declarations
--=================================================================================================

--=================================================================================================
-- Synthesis Attributes
--=================================================================================================
--NA--
--=================================================================================================
-- Signal declarations
--=================================================================================================
TYPE    scheduler_states IS 			(IDLE,
										SCAN,
										ASSIGN_REQ,
										ASSIGN_REQ_1,
										WAIT_FOR_ACK,
										WAIT_FOR_DONE);
										
TYPE   matrix_8x4 	IS ARRAY(0 to 7) of STD_LOGIC_VECTOR (3 DOWNTO 0);

SIGNAL s_state           				: scheduler_states;
SIGNAL s_fifo							: matrix_8x4;
SIGNAL s_req0_re						: STD_LOGIC;
SIGNAL s_req1_re						: STD_LOGIC;
SIGNAL s_req2_re						: STD_LOGIC;
SIGNAL s_req3_re						: STD_LOGIC;
SIGNAL s_req4_re						: STD_LOGIC;
SIGNAL s_req5_re						: STD_LOGIC;
SIGNAL s_req6_re						: STD_LOGIC;
SIGNAL s_req7_re						: STD_LOGIC;
SIGNAL s_req0_dly						: STD_LOGIC;
SIGNAL s_req1_dly						: STD_LOGIC;
SIGNAL s_req2_dly						: STD_LOGIC;
SIGNAL s_req3_dly						: STD_LOGIC;
SIGNAL s_req4_dly						: STD_LOGIC;
SIGNAL s_req5_dly						: STD_LOGIC;
SIGNAL s_req6_dly						: STD_LOGIC;
SIGNAL s_req7_dly						: STD_LOGIC;
SIGNAL s_req0_latch						: STD_LOGIC;
SIGNAL s_req1_latch						: STD_LOGIC;
SIGNAL s_req2_latch						: STD_LOGIC;
SIGNAL s_req3_latch						: STD_LOGIC;
SIGNAL s_req4_latch						: STD_LOGIC;
SIGNAL s_req5_latch						: STD_LOGIC;
SIGNAL s_req6_latch						: STD_LOGIC;
SIGNAL s_req7_latch						: STD_LOGIC;
SIGNAL s_clear_fifo						: STD_LOGIC;
SIGNAL s_write_ctr						: STD_LOGIC_VECTOR(2 DOWNTO 0);
SIGNAL s_read_ctr						: STD_LOGIC_VECTOR(2 DOWNTO 0);

BEGIN
--=================================================================================================
-- Top level output port assignments
--=================================================================================================

--=================================================================================================
-- Generate blocks
--=================================================================================================
--NA--
--=================================================================================================
-- Asynchronous blocks
--=================================================================================================
s_req0_re	<= NOT(s_req0_dly) AND req0_i;
s_req1_re	<= NOT(s_req1_dly) AND req1_i;
s_req2_re	<= NOT(s_req2_dly) AND req2_i;
s_req3_re	<= NOT(s_req3_dly) AND req3_i;
s_req4_re	<= NOT(s_req4_dly) AND req4_i;
s_req5_re	<= NOT(s_req5_dly) AND req5_i;
s_req6_re	<= NOT(s_req6_dly) AND req6_i;
s_req7_re	<= NOT(s_req7_dly) AND req7_i;
--=================================================================================================
-- Synchronous blocks
--=================================================================================================
--------------------------------------------------------------------------
-- Name       : DELAY_PROC
-- Description: Process generates delayed version of signals
--------------------------------------------------------------------------
DELAY_PROC:
        PROCESS(sys_clk_i,reset_i)
        BEGIN
            IF(reset_i = '0') THEN
				s_req0_dly	<= '0';
				s_req1_dly	<= '0';
				s_req2_dly	<= '0';
				s_req3_dly	<= '0';
				s_req4_dly	<= '0';
				s_req5_dly	<= '0';
				s_req6_dly	<= '0';
				s_req7_dly	<= '0';
            ELSIF (RISING_EDGE(sys_clk_i))  THEN
				s_req0_dly	<= req0_i;
				s_req1_dly	<= req1_i;
				s_req2_dly	<= req2_i;
				s_req3_dly	<= req3_i;
				s_req4_dly	<= req4_i;
				s_req5_dly	<= req5_i;
				s_req6_dly	<= req6_i;
				s_req7_dly	<= req7_i;
			END IF;
		END PROCESS;
--------------------------------------------------------------------------
-- Name       : WRITE_FIFO_PROC
-- Description: Process registers incoming requests in FIFO
--------------------------------------------------------------------------
WRITE_FIFO_PROC:
        PROCESS(sys_clk_i,reset_i)
        BEGIN
            IF(reset_i = '0') THEN
				s_write_ctr		<= "000";
				s_fifo			<= (OTHERS => (OTHERS => '1'));
                s_req0_latch    <= '0';
                s_req1_latch    <= '0';
                s_req2_latch    <= '0';
                s_req3_latch    <= '0';                
                s_req4_latch    <= '0';                
                s_req5_latch    <= '0';                   
                s_req6_latch    <= '0';                
                s_req7_latch    <= '0';                
            ELSIF (RISING_EDGE(sys_clk_i))  THEN
                IF(s_clear_fifo = '1')THEN
					s_fifo(to_integer(unsigned(s_read_ctr)))	<= "1111";
				ELSIF(s_req0_latch = '1')THEN
                    s_req0_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + '1';
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0000";
				ELSIF(s_req1_latch = '1')THEN
                    s_req1_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + '1';
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0001";
				ELSIF(s_req2_latch = '1')THEN
                    s_req2_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr))) 	<= "0010";
				ELSIF(s_req3_latch = '1')THEN
                    s_req3_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0011";
				ELSIF(s_req4_latch = '1')THEN
                    s_req4_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0100";
				ELSIF(s_req5_latch = '1')THEN
                    s_req5_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0101";
				ELSIF(s_req6_latch = '1')THEN
                    s_req6_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0110";
				ELSIF(s_req7_latch = '1')THEN
                    s_req7_latch                                <= '0';
					s_write_ctr				                    <= s_write_ctr + 1;
					s_fifo(to_integer(unsigned(s_write_ctr)))	<= "0111";
				END IF;			

                IF(s_req0_re = '1')THEN
                    s_req0_latch  <= '1';
                END IF;
                IF(s_req1_re = '1')THEN
                    s_req1_latch  <= '1';
                END IF;
                IF(s_req2_re = '1')THEN
                    s_req2_latch  <= '1';
                END IF;
                IF(s_req3_re = '1')THEN
                    s_req3_latch  <= '1';
                END IF;
                IF(s_req4_re = '1')THEN
                    s_req4_latch  <= '1';
                END IF;
                IF(s_req5_re = '1')THEN
                    s_req5_latch  <= '1';
                END IF;
                IF(s_req6_re = '1')THEN
                    s_req6_latch  <= '1';
                END IF;
                IF(s_req7_re = '1')THEN
                    s_req7_latch  <= '1';
                END IF;

			END IF;
		END PROCESS;
--------------------------------------------------------------------------
-- Name       : FSM_PROC
-- Description: FSM implements scheduler FSM
--------------------------------------------------------------------------
FSM_PROC:
        PROCESS(sys_clk_i,reset_i)
        BEGIN
            IF(reset_i = '0') THEN
                s_state				    <= IDLE;
				s_read_ctr				<= "000";
				mux_sel_o				<= "000";
				req_o					<= '0';
				s_clear_fifo			<= '0';
            ELSIF (RISING_EDGE(sys_clk_i))  THEN
                CASE s_state IS
--------------------
-- IDLE state
--------------------
                    WHEN IDLE         =>
						s_state		<= SCAN;
--------------------
-- SCAN state
--------------------
                    WHEN SCAN   =>
						CASE s_fifo(to_integer(unsigned(s_read_ctr))) IS
							WHEN "0000" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "000";
							WHEN "0001" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "001";
							WHEN "0010" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "010";
							WHEN "0011" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "011";
							WHEN "0100" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "100";
							WHEN "0101" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "101";
							WHEN "0110" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "110";
							WHEN "0111" =>
								s_state		<= ASSIGN_REQ;
								mux_sel_o		<= "111";
							WHEN OTHERS => 
								s_state		<= SCAN;
								s_read_ctr	<= s_read_ctr + 1;
						END CASE;
--------------------
-- ASSIGN_REQ state
--------------------
                    WHEN ASSIGN_REQ =>
						s_state	        <= ASSIGN_REQ_1;

--------------------
-- ASSIGN_REQ_1 state
--------------------
                    WHEN ASSIGN_REQ_1 =>
						s_state	        <= WAIT_FOR_ACK;
						req_o	        <= '1';
                        s_clear_fifo	<= '0';
--------------------
-- WAIT_FOR_ACK state
--------------------
                    WHEN WAIT_FOR_ACK =>
						IF(ack_i = '1')THEN
							s_clear_fifo	<= '1';
							s_state	        <= WAIT_FOR_DONE;
							req_o	        <= '0';
						ELSE
							s_state	        <= WAIT_FOR_ACK;
						END IF;
--------------------
-- WAIT_FOR_DONE state
--------------------
                    WHEN WAIT_FOR_DONE =>
						s_clear_fifo	<= '0';
						IF(done_i = '1')THEN
							s_read_ctr		<= s_read_ctr + 1;
							s_state			<= SCAN;
						ELSE
							s_state			<= WAIT_FOR_DONE;
						END IF;
--------------------                                  
-- OTHERS state                                        
--------------------                                  
                    WHEN OTHERS =>                    
                        s_state          <= IDLE;
                END CASE;
            END IF;
        END PROCESS;

--=================================================================================================
-- Component Instantiations
--=================================================================================================
--NA
END request_scheduler;