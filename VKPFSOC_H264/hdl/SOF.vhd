library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SOF_Detector is
    Port (
        clk_20mhz       : in  std_logic;  -- 20 MHz clock signal
        reset           : in  std_logic;  -- Asynchronous reset signal
        data_in         : in  std_logic;  -- Single-bit data input
        SOF_detected    : out std_logic;  -- Output: High when SOF is detected
        packed_data     : out std_logic_vector(9 downto 0); -- Packed 10-bit data
        data_ready      : out std_logic;  -- Data ready signal for next stage
        end_of_packet   : out std_logic   -- High when EOF is detected
    );
end SOF_Detector;

architecture Behavioral of SOF_Detector is
    -- State type definition
    type state_type is (MONITOR, PACK_DATA);
    signal state : state_type := MONITOR;  -- Current state

    -- Shift register to hold the last 10 bits of the input stream
    signal shift_reg : std_logic_vector(9 downto 0) := (others => '0');

    -- Counter for packing data
    signal bit_counter : integer range 0 to 9 := 0;

    -- SOF and EOF patterns
    constant SOF1 : std_logic_vector(9 downto 0) := "1100000110";
    constant SOF2 : std_logic_vector(9 downto 0) := "0011111001";
    constant EOF1 : std_logic_vector(9 downto 0) := "1100000101"; -- Example EOF1
    constant EOF2 : std_logic_vector(9 downto 0) := "0011111010"; -- Example EOF2

    -- Internal signals
    signal packed_word  : std_logic_vector(9 downto 0) := (others => '0');
    signal ready_flag   : std_logic := '0';
    signal eof_detected : std_logic := '0';

begin

    -- Output assignments
    --SOF_detected <= '1' when (shift_reg = SOF1 or shift_reg = SOF2) else '0';
    packed_data  <= packed_word;
    data_ready   <= ready_flag;
    end_of_packet <= eof_detected;

    -- State machine process
    process(clk_20mhz, reset)
    begin
        if reset = '1' then
            state <= MONITOR;  -- Reset state to IDLE
            shift_reg <= (others => '0');  -- Clear the shift register
            bit_counter <= 0;
            packed_word <= (others => '0');
            ready_flag <= '0';
            SOF_detected <= '0';
            eof_detected <= '0';
        elsif rising_edge(clk_20mhz) then
            case state is
                when MONITOR =>
                    -- Shift in the new data bit
                    eof_detected <= '0';
                    shift_reg <= shift_reg(8 downto 0) & data_in;
                    if shift_reg = SOF1 or shift_reg = SOF2 then
                        SOF_detected <= '1';
                        shift_reg <= (others => '0');
                        state <= PACK_DATA;  -- Transition to PACK_DATA state on SOF detection                       
                    end if;

                when PACK_DATA =>
                    SOF_detected <= '0';
                    -- Pack data into 10-bit word
                    packed_word <= packed_word(8 downto 0) & data_in;
                    --packed_word(bit_counter) <= data_in;
                    if bit_counter = 9 then
                        -- Completed packing 10 bits
                        bit_counter <= 0;  -- Reset counter
                        if packed_word = EOF1 or packed_word = EOF2 then
                            eof_detected <= '1';  -- Signal EOF detection
                            packed_word  <= "000000000" & data_in;
                            ready_flag <= '0';  -- Clear ready flag
                            state <= MONITOR;  -- Return to MONITOR state
                        else
                            ready_flag <= '1';  -- Signal data ready
                            packed_word <= "000000000" & data_in;
                            state <= PACK_DATA;  -- Continue packing next data
                        end if;
                    else
                        bit_counter <= bit_counter + 1;  -- Increment bit counter
                        ready_flag <= '0';  -- Clear ready flag
                        state <= PACK_DATA;  -- Continue packing next data
                    end if;
            end case;
        end if;
    end process;

end Behavioral;
