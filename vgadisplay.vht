library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity vgadisplay_tb is
end vgadisplay_tb;

architecture testbench of vgadisplay_tb is
    signal clk   : std_logic;
    signal Vsync : std_logic;
    signal Hsync : std_logic;
    signal vga_r : std_logic_vector(3 downto 0);
    signal vga_g : std_logic_vector(3 downto 0);
    signal vga_b : std_logic_vector(3 downto 0);

begin
    -- Instansioidaan testattava yksikkö
    uut: entity work.vgadisplay
        port map (
            clk   => clk,
            Vsync => Vsync,
            Hsync => Hsync,
            vga_r => vga_r,
            vga_g => vga_g,
            vga_b => vga_b
        );

    -- Kellosignaalin generointi
    clk_process: process
    begin
			while now < 16.7 ms loop
            clk <= '0';
            wait for 10 ns;
            clk <= '1';
            wait for 10 ns;
			end loop;
		wait;
    end process;

    -- Testaussignaaleja tarkkaileva prosessi
    monitor_process: process
    begin
        wait for 20 ns; -- Odotetaan alkuvaiheen asettumista
        report "Simulation start";
        
        -- Tarkkaillaan horisontaalista vaihetta (yksi vaakajuova)
        wait until Hsync = '0';
        report "Hsync active (beginning of horizontal sync)";
        wait until Hsync = '1';
        report "Hsync inactive (end of horizontal sync)";
        
        -- Tarkkaillaan pystysynkronointia
        wait until Vsync = '0';
        report "Vsync active (beginning of vertical sync)";
        wait until Vsync = '1';
        report "Vsync inactive (end of vertical sync)";
        
        report "Test complete";
        wait;
    end process;
	 
end testbench;
