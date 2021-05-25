-- multiplexador de 2 caminhos
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity multiplex2 is
    port (
        input1:     in bit_vector(2 downto 0);
        input2:     in bit_vector(2 downto 0);
        sel:        in bit;
        output1:    out bit_vector(2 downto 0)
    );
end entity multiplex2;

architecture dentro of multiplex2 is    
begin
    process(input1, input2, sel)
    begin
        case sel is
            when '0' => output1 <= input1;
            when '1' => output1 <= input2;
        end case;
    end process;
    
    
end architecture dentro;