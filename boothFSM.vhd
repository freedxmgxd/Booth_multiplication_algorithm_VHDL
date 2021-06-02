--MAquina de estados
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;

entity boothFSM is
    port (
        I:          in std_logic;
        V:          in std_logic_vector(1 downto 0);
        S:          in std_logic; 
        clk   :     in std_logic;
        reset :     in std_logic;
        ResetOut:   out std_logic;
        AorS:       out std_logic;
        Somar:      out std_logic;
        Shift:      out std_logic
        
    );
end entity;

architecture behav of boothFSM is
begin
    process(I, V, S, Clk, Reset) 
    variable state : integer := 0;
    begin
        if (clk = '1' and clk'event) then
            if (Reset = '1') then
                state := 0;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            elsif (state = 0 and S ='0') then 
                state := 0;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            elsif (state = 0 and S ='1') then 
                state := 1;
                ResetOut <= '1';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            elsif (state = 1) then 
                state := 2;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            elsif (state = 2 and I ='1') then 
                state := 0;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            elsif (state = 2 and I = '0' and V(1)='1' and v(0)='0') then 
                state := 4;
                ResetOut <= '0';
                AorS <= '1';
                Somar <= '1';
                Shift <= '0';
            elsif (state = 2 and I = '0' and V(1)='0' and v(0)='1') then 
                state := 3;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '1';
                Shift <= '0';
            elsif (state = 2 and I = '0' and (V ="00" or V = "11")) then 
                state := 5;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '1';
            elsif (state = 3) then 
                state := 5;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '1';
            elsif (state = 4) then
                state := 5;
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '1';
            elsif (state = 5) then 
                state := 2;
				ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            end if;
        end if;
    end process;
end architecture;
---------------------------------------------------
