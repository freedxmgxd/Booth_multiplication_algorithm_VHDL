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
        P:      out std_logic_vector(7 downto 0)
    );
    end component main;
    

    constant PERIODO : time := 10 ns;
    
    signal sA:   		std_logic_vector(3 downto 0);
    signal sB:   		std_logic_vector(3 downto 0);
    signal Stt:  		std_logic;
    signal Rst:  		std_logic;
    signal Clk:  		std_logic := '0';
    signal Outp: 		std_logic_vector(7 downto 0);
    
    begin
    
    Clk <= not Clk after PERIODO/2;
    
    dut: main port map( 	 A=> sA,
							 B=> sB,
							 Start=> Stt,
							 Reset=> Rst,
                             clck=> Clk,
                             P=> Outp
							);
    

    testbench1: process is
        variable cERR: 	integer := 0;
        variable aux: 	std_logic_vector(7 downto 0);

        -- Case 1: Usando EPWave ou outra ferramenta de waveform, será possivel acompanhar o diagrama temporal deste caso. Ao acompanhar o elemento pOut do design fica temporalmente fica mais facil de acompanhar o algoritmo de booth.

        begin
        Rst <= '1';
        wait for 10 ns;
        Rst <= '0';
        wait for 5 ns;
    
        sA <= "1000";
        sB <= "0010";
        Stt<= '1';
        Rst<= '0';
    
        wait for 30 ns;
    
        Stt<= '0';
    
        wait for 150 ns;
            
        assert (outP = "11110000") report "Erro no caso 1!" severity error;

        report "resultado: "     & to_string(Outp);
    

        --Case 2 : Irá verificar para todos os casos possiveis se a solução bate com o esperado.
    
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
                wait for 150 ns;
                
                aux := std_logic_vector(to_signed(j * i, 8));
                
                assert (outp = aux) report "Error na operação " & to_string(sA) & " * " & to_string(sB);
                if (outp /= aux) then
                cERR := cERR + 1;
                end if;
            
            
            end loop;      
        end loop;
        
        report "Todos os testes foram realizados! Numeros de erros encontrados: " & to_string(cERR); 
        wait;
end process;

end testbench;
