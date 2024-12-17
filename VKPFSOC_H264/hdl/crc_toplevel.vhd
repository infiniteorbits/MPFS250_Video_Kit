library IEEE;
use IEEE.std_logic_1164.all;

-- Main design entity
entity crc16_ccitt_top is
    port (
        clk: in std_logic; -- Clock signal
        rst: in std_logic; -- Reset signal
        data_in: in std_logic_vector(7 downto 0); -- Input data
        data_valid: in std_logic; -- Data valid signal
        crc_out: out std_logic_vector(15 downto 0) -- Final CRC output
    );
end entity crc16_ccitt_top;

architecture Behavioral of crc16_ccitt_top is

    component crc is
        port (
            crcIn: in std_logic_vector(15 downto 0);
            data: in std_logic_vector(7 downto 0);
            crcOut: out std_logic_vector(15 downto 0)
        );
    end component;

    signal current_crc: std_logic_vector(15 downto 0) := (others => '1'); -- Initialize to 0xFFFF
    signal next_crc: std_logic_vector(15 downto 0);

begin
    -- CRC block instantiation
    crc_inst: crc
        port map (
            crcIn => current_crc,
            data => data_in,
            crcOut => next_crc
        );

    -- Sequential process to update CRC value
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                current_crc <= (others => '1'); -- Reset to 0xFFFF
            elsif data_valid = '1' then
                current_crc <= next_crc; -- Update CRC value
            end if;
        end if;
    end process;

    -- Final CRC output
    crc_out <= current_crc;

end architecture Behavioral;
