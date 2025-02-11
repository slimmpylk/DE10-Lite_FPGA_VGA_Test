library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std;

entity vgadisplay is
Port(
	clk   : in std_logic;
	Vsync : out std_logic;
	Hsync : out std_logic;
	vga_r : out std_logic_vector(3 downto 0);
	vga_g : out std_logic_vector(3 downto 0);
	vga_b : out std_logic_vector(3 downto 0)
);
end vgadisplay;

architecture Behavioral of vgadisplay is

	constant h_active  	 : integer := 640;
	constant h_frontporch : integer := 16;
	constant h_syncpulse  : integer := 96;
	constant h_backporch  : integer := 48;
	constant h_period     : integer := h_syncpulse + h_backporch + h_active + h_frontporch;

	constant v_active     : integer := 480;
	constant v_frontporch : integer := 10;
	constant v_syncpulse  : integer := 2;
	constant v_backporch  : integer := 33;
	constant v_period 	 : integer := v_syncpulse + v_backporch + v_active + v_frontporch;

	signal h_counter  	 : integer range 0 to h_period - 1 := 0;
	signal v_counter   	 : integer range 0 to v_period - 1 := 0;
	signal pixel_clk  	 : std_logic := '0';

begin

	-- kellojakaja 25MHz
	process(clk)
	begin
		if rising_edge(clk) then
			pixel_clk <= not pixel_clk;
		end if;
	end process;

	-- vga-signaalien generointi
	process(pixel_clk)
	begin
		if rising_edge(pixel_clk) then
			if h_counter < h_period - 1 then
				h_counter <= h_counter + 1;
			else
				h_counter <= 0;
			if v_counter < v_period - 1 then
				v_counter <= v_counter + 1;
			else
				v_counter <= 0;
			end if;
		end if;
	end if;
	end process;

	-- synkronointisignaalit
	Hsync <= '0' when (h_counter >= h_active + h_frontporch  and h_counter < h_active + h_frontporch + h_syncpulse) else '1';
	Vsync <= '0' when (v_counter >= v_active + v_frontporch  and v_counter < v_active + v_frontporch + v_syncpulse) else '1';

	-- vÃ¤risignaalit
	process(h_counter, v_counter)
	begin
		if (h_counter < h_active and v_counter < v_active) then
			if v_counter < v_active / 3 then
				vga_r <= "1111"; vga_g <= "0000"; vga_b <= "0000";
			elsif v_counter < (2 * v_active) / 3 then
				vga_r <= "0000"; vga_g <= "1111"; vga_b <= "0000";
			else
				vga_r <= "0000"; vga_g <= "0000"; vga_b <= "1111";
			end if;
		else
		vga_r <= "0000"; vga_g <= "0000"; vga_b <= "0000";
		end if;
	end process;

end Behavioral;