library ieee;
use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb is end;

architecture testbench of tb is

	component main
    	port (
        A:      in std_logic_vector(3 downto 0);
        B:      in std_logic_vector(3 downto 0);
        Start:  in std_logic;
        Reset:  in std_logic;
        clck:   in std_logic;
        P:      out std_logic_vector(7 downto 0);
        Pointer: buffer std_logic_vector(9 downto 0)
    );
    end component main;
    

    
    --declaração do tempo de clock
    constant PERIODO : time := 10 ns;
    
    --entradas e saídas tratadas por sinais, na mesma ordem que no componente
    signal sA:   		std_logic_vector(3 downto 0);
    signal sB:   		std_logic_vector(3 downto 0);
    signal Stt:  		std_logic;
    signal Rst:  		std_logic;
    signal Clk:  		std_logic := '0';
    signal Outp: 		std_logic_vector(7 downto 0);
    signal Ponteira:	std_logic_vector(9 downto 0);
    
    begin
    
    --geração do clock
    Clk <= not Clk after PERIODO/2;
    
    --assinalando as entradas e saídas aos sinais tratados
    dut: main port map( 	 A=> sA,
							 B=> sB,
							 Start=> Stt,
							 Reset=> Rst,
                             clck=> Clk,
                             P=> Outp,
                             Pointer=> Ponteira 
							);
    
    
    inc: process is
    
    variable cERR: 	integer := 0;
    variable aux: 	std_logic_vector(7 downto 0);
    
    begin
    Rst <= '1';
    wait for 10 ns;
    Rst <= '0';
    wait for 5 ns;
    
    for i in (-8) to 7 loop
    	for j in (-8) to 7 loop
        	sA <= std_logic_vector(to_signed(i, 4));
            sB <= std_logic_vector(to_signed(j, 4));
			Stt <= '1';
            Rst <= '0';
            wait for 30 ns;
            Stt <= '0';
            wait for 400 ns;
            
            aux := std_logic_vector(to_signed(j * i, 8));
            
            if (outp /= aux) then
            cERR := cERR + 1;
            end if;
        
        
        end loop;      
    end loop;
    
    report "resultado: " 		& to_string(Outp);

    report "ponteira: " 		& to_string(Ponteira);
    
    report "Erros apontados: " 	& to_string(cERR);
    
end process;
end testbench;
