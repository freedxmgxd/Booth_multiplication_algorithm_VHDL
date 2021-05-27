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
    
    --declaração do tempo de clock
    constant PERIODO : time := 10 ns;
    
    --entradas e saídas tratadas por sinais, na mesma ordem que no componente
    signal sA:   std_logic_vector(3 downto 0);
    signal sB:   std_logic_vector(3 downto 0);
    signal Stt:  std_logic;
    signal Rst:  std_logic;
    signal Clk:  std_logic := '0';
    signal Outp: std_logic_vector(7 downto 0);
    
    begin
    
    --geração do clock
    Clk <= not Clk after PERIODO/2;
    
    --assinalando as entradas e saídas aos sinais tratados
    dut: main port map( 	 A=> sA,
							 B=> sB,
							 Start=> Stt,
							 Reset=> Rst,
                             clck=> Clk,
                             P=> Outp
							);
    
    
    inc: process is
    begin
    wait for 5 ns;
    
    sA <= "0000";
    sB <= "0111";
    Stt<= '1';
    Rst<= '0';
    
    wait for 5 ns;
    
    Stt<= '0';
    
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    wait for 5 ns;
    
    report "Clk: " & std_logic'image(Clk);
    
    report "resultado: " & integer'image(to_integer(unsigned(Outp)));
    
    wait;
    
end process;
end testbench;
