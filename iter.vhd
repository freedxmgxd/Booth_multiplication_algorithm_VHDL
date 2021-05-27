-- Iterador que conta até 4
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity iter is 
    port(
        inc:    in std_logic;
        rst:    in std_logic;
        ite:    out std_logic
    );
end iter;

architecture dentro of iter is
begin
    process(inc, rst)
    variable cnt : integer :=0 ;
    begin
        if rst = '1' then
            cnt := 0;
            ite <= '0';
        end if;
        if (inc='1' and inc'last_value='0') then
          cnt:=cnt+1;
        end if;
        if cnt > 4 then
            ite <= '1';
        end if;
    end process;
end architecture dentro;
---------------------------------------------------