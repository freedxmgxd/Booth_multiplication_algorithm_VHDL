-- Registrador 5Bits com shift
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity shift_reg is
port(	
    RegIn:		   in std_logic_vector (4 downto 0);
    inputS:        in std_logic;
    shift:		   in std_logic;
    load:          in std_logic;
    reset:         in std_logic;
    clckSR:		   in std_logic;
    RegOut:		   buffer std_logic_vector (4 downto 0)
);
end shift_reg;

---------------------------------------------------

architecture behv of shift_reg is
   
    signal S: std_logic_vector(4 downto 0);
    
begin
    
    process(clckSR, inputS, reset, RegIn, shift)
    begin

   if reset = '1' then 
      S <= "00000";
   elsif(clckSR='0' and clckSR'event) then
	    if shift = '1' then
		    S(0) <= inputS;
            S(1) <= RegOut(0);
            S(2) <= RegOut(1);   
            S(3) <= RegOut(2);
            S(4) <= RegOut(3);
	    elsif load = '1' then
		   S <= RegIn;
	    end if;
	end if;

   end process;
	
    -- concurrent assignment
   RegOut <= S;

end architecture behv;

----------------------------------------------------