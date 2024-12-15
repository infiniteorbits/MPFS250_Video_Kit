library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity SOF_Detector_tb is
end SOF_Detector_tb;

architecture behavior of SOF_Detector_tb is
    -- Component declaration of the SOF_Detector entity
    component SOF_Detector is
        Port (
            clk_20mhz       : in  std_logic;
            reset           : in  std_logic;
            data_in         : in  std_logic;
            SOF_detected    : out std_logic;
            packed_data     : out std_logic_vector(9 downto 0);
            data_ready      : out std_logic;
            end_of_packet   : out std_logic
        );
    end component;

    -- Signals to connect to the SOF_Detector
    signal clk_20mhz       : std_logic := '0';
    signal reset           : std_logic := '0';
    signal data_in         : std_logic := '0';
    signal SOF_detected    : std_logic;
    signal packed_data     : std_logic_vector(9 downto 0);
    signal data_ready      : std_logic;
    signal end_of_packet   : std_logic;

    -- Clock period definition
    constant clk_period : time := 50 ns;

begin
    -- Instantiate the SOF_Detector
    uut: SOF_Detector
        Port map (
            clk_20mhz       => clk_20mhz,
            reset           => reset,
            data_in         => data_in,
            SOF_detected    => SOF_detected,
            packed_data     => packed_data,
            data_ready      => data_ready,
            end_of_packet   => end_of_packet
        );

    -- Clock generation process
    clk_process : process
    begin
        clk_20mhz <= '0';
        wait for clk_period / 2;
        clk_20mhz <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stimulus_process: process
    begin
        -- Reset the design
        reset <= '1';
        wait for clk_period/2;
        reset <= '0';
        wait for clk_period;

        -- Send SOF (SOF1 pattern)
        data_in <= '1'; wait for clk_period;  -- First bit of SOF1
        data_in <= '1'; wait for clk_period;  -- Second bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Third bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Fourth bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Fifth bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Sixth bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Seventh bit of SOF1
        data_in <= '1'; wait for clk_period;  -- Eighth bit of SOF1
        data_in <= '1'; wait for clk_period;  -- Ninth bit of SOF1
        data_in <= '0'; wait for clk_period;  -- Tenth bit of SOF1

        -- Assert SOF detection
        --assert (SOF_detected = '1') report "SOF detection failed!" severity error;
      --  if SOF_detected = '1' then
      --    report "Good news: SOF_detected is '1'" severity note;
      --  end if;
        --wait for clk_period;
        -- Send 10 bits of data
        for i in 0 to 9 loop
            data_in <= '1'; wait for clk_period;  -- Send bit (alternating for example)
        end loop;

        -- Assert that data is ready after sending 10 bits
        --wait for clk_period;
        --assert (data_ready = '1') report "Data not ready!" severity error;
        if data_ready = '1' then
          report "Good news: data_ready is '1'" severity note;
        end if;
        --wait for clk_period;
        -- Send EOF (EOF1 pattern)  
        data_in <= '1'; wait for clk_period;  -- First bit of EOF1
        data_in <= '1'; wait for clk_period;  -- Second bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Third bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Fourth bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Fifth bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Sixth bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Seventh bit of EOF1
        data_in <= '1'; wait for clk_period;  -- Eighth bit of EOF1
        data_in <= '0'; wait for clk_period;  -- Ninth bit of EOF1
        data_in <= '1'; wait for clk_period;  -- Tenth bit of EOF1

        -- Assert EOF detection
        --assert (end_of_packet = '1') report "EOF detection failed!" severity error;
        if end_of_packet = '1' then
          report "Good news: end_of_packet is '1'" severity note;
        end if;
        -- End simulation
        wait;
    end process;

end behavior;
