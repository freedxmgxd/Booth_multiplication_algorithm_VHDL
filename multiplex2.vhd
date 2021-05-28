--- multiplexador de 2 caminhos
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity multiplex2 is
    port (
        input1:     in std_logic_vector(1 downto 0);
        input2:     in std_logic_vector(1 downto 0);
        sel:        in std_logic;
        output1:    buffer std_logic_vector(1 downto 0)
    );
end entity multiplex2;

architecture dentro of multiplex2 is    
begin
    process(input1, input2, sel)
    begin
        case sel is
            when '0' => output1 <= input1;
            when '1' => output1 <= input2;
            when others => output1 <= output1;
        end case;
    end process;
    
    
end architecture dentro;
----------------------------------------------------