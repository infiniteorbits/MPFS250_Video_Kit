library IEEE;
use IEEE.std_logic_1164.all;

entity tb_crc16_ccitt is
end entity tb_crc16_ccitt;

architecture Behavioral of tb_crc16_ccitt is

    -- Signals for DUT
    signal clk: std_logic := '0';
    signal rst: std_logic := '0';
    signal data_in: std_logic_vector(7 downto 0) := (others => '0');
    signal data_valid: std_logic := '0';
    signal crc_out: std_logic_vector(15 downto 0);

    -- Clock generation
    constant clk_period: time := 10 ns;

    -- DUT instantiation
    component crc16_ccitt_top is
        port (
            clk: in std_logic;
            rst: in std_logic;
            data_in: in std_logic_vector(7 downto 0);
            data_valid: in std_logic;
            crc_out: out std_logic_vector(15 downto 0)
        );
    end component;

begin
    -- Instantiate the DUT
    dut: crc16_ccitt_top
        port map (
            clk => clk,
            rst => rst,
            data_in => data_in,
            data_valid => data_valid,
            crc_out => crc_out
        );

    -- Clock generation process
    clk_gen: process
    begin
        while true loop
            clk <= not clk;
            wait for clk_period / 2;
        end loop;
    end process;

    -- Stimulus process
    stimulus: process
        variable test_data: std_logic_vector(7 downto 0) := "10101010"; -- Example data
    begin
        -- Reset
        rst <= '1';
        wait for 20 ns;
        rst <= '0';
        wait for 20 ns;

        -- Send data byte-by-byte
        for i in 0 to 3 loop
            case i is
                when 0 => data_in <= "10101010"; -- 0xAA
                when 1 => data_in <= "10111011"; -- 0xBB
                when 2 => data_in <= "11001100"; -- 0xCC
                when 3 => data_in <= "11011101"; -- 0xDD
        end case;
        data_valid <= '1';
        wait for clk_period;
        data_valid <= '0';
        wait for clk_period;
        end loop;

        -- Finish simulation
        wait for 100 ns;
        assert false report "Simulation complete." severity note;
        wait;
    end process;

end architecture Behavioral;
