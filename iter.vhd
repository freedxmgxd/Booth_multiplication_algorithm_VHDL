-- Iterador que conta até 4
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity iter is 
    port(
        inc:    in bit;
        rst:    in bit;
        ite:    out bit;
    );
end iter;

architecture dentro of iter is
begin
    variable cnt : integer :=0 ;
    process(inc, rst)
    begin
        if rst '1' then
            cnt :=0;
            ite <= 0;
        end if;
        if inc = '1' then
          cnt:=cnt+1;
        end if;
        if cnt > 4 then
            ite <= '1';
        end if;
    end process;
end architecture dentro;