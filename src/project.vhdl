library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tt_um_supreme_meme is
    port (
        ui_in   : in  std_logic_vector(7 downto 0);
        uo_out  : out std_logic_vector(7 downto 0);
        uio_in  : in  std_logic_vector(7 downto 0);
        uio_out : out std_logic_vector(7 downto 0);
        uio_oe  : out std_logic_vector(7 downto 0);
        ena     : in  std_logic;
        clk     : in  std_logic;
        rst_n   : in  std_logic
    );
end tt_um_supreme_meme;

architecture Behavioral of tt_um_supreme_meme is

    signal counter : unsigned(3 downto 0) := (others => '0');
    signal addressROM : std_logic_vector(4 downto 0);
    signal dataROM : std_logic_vector(15 downto 0) := (others => '0');
    signal counter_running : std_logic := '0';

    type ROM is array (0 to 29) of std_logic_vector(15 downto 0);
    constant ROM_content : ROM := (
        
        0 => "0000000000000000", 
        1 => "1011100000000000", 
        2 => "1110101010000000", 
        3 => "1110101110100000", 
        4 => "1110101000000000",
        5 => "1000000000000000", 
        6 => "1010111010000000", 
        7 => "1110111010000000", 
        8 => "1010101000000000", 
        9 => "1010000000000000",
        10 => "1011101110111000", 
        11 => "1110101110000000", 
        12 => "1011101010000000", 
        13 => "1110111000000000", 
        14 => "1110100000000000",
        15 => "1011101010100000", 
        16 => "1010101010000000", 
        17 => "1110111010111000", 
        18 => "1011101000000000", 
        19 => "1010100000000000",
        20 => "1110000000000000", 
        21 => "1010111000000000", 
        22 => "1010101110000000", 
        23 => "1011101110000000", 
        24 => "1010111010101000",
        25 => "1110101110111000", 
        26 => "1110111010100000", 
        27 => "1011101110101110", 
        28 => "1011101011100000", 
        29 => "1110111011101000"
        
    );

begin

    
    uo_out(7 downto 1) <= to_unsigned(0, 7);
    addressROM <= ui_in(4 downto 0);
    --dataROM <= ROM_content(to_integer(unsigned(addressROM)));

    process (clk, rst_n)
    begin
        if ui_in(5) = '1' then
            counter <= to_unsigned(0, 4); 
            counter_running <= '1';
            dataROM <= ROM_content(to_integer(unsigned(addressROM)));
        end if;

        if rising_edge(clk) and (counter_running = '1') then            

            counter <= counter - to_unsigned(1, 4);

            if (dataROM(to_integer(counter)) = to_unsigned(0, 16)) and (dataROM(to_integer(counter - to_unsigned(1, 4))) = to_unsigned(0, 16)) then
                counter <= to_unsigned(0, 4);
                counter_running <= '0';
                dataROM <= ROM_content(0);
            end if; 

        end if;
    --wait until ena_intern = 1;
    end process;

    uo_out(0) <= dataROM(to_integer(counter));
    --uo_out(1) <= dataROM(15);
    --uo_out(15 downto 1) <= 0;

end Behavioral;