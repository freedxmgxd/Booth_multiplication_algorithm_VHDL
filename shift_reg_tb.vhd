------------------------------------------------------------------
-- Test Bench for 2-bit register (ESD figure 2.6)
-- by Weijun Zhang, 04/2001
--
-- several ways you may use to specify the concurrent clock signal
------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity reg_TB is			-- entity declaration
end reg_TB;

------------------------------------------------------------------

architecture TB of reg_TB is

    component shift_reg
    port(   
        RegIn:		   in std_logic_vector (4 downto 0);
        inputS:        in std_logic;
        shift:		   in std_logic;
        load:          in std_logic;
        reset:         in std_logic;
        clckSR:		   in std_logic;
        RegOut:		   buffer std_logic_vector (4 downto 0)
    );
    end component;

    signal T_I:			std_logic_vector(4 downto 0);
    signal T_inputS: 	std_logic;
    signal T_shift: 	std_logic;
    signal T_clock:		std_logic;
    signal T_load:		std_logic;
    signal T_reset:		std_logic;
    signal T_Q:			std_logic_vector(4 downto 0);
	
begin

    U_reg: shift_reg port map (T_I,T_inputS, T_shift, T_load, T_reset, T_clock, T_Q);
	
    -- concurrent process to offer the clock signal
    process
    begin
 	T_clock <= '0';
 	wait for 5 ns;
	T_clock <= '1';
	wait for 5 ns;
    end process;
	
    process							
							 
	variable err_cnt: integer :=0;
	
    begin								
	
	T_I <= "10001";
    T_inputS <= '0';
	T_load <= '0';
	T_reset <= '0';
		
	-- case 1
	wait for 20 ns;
	T_load <= '1';
	wait for 10 ns;
    report "Case 1: " & to_string(T_Q);
	assert (T_Q="10001") report "Test1 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
		
	-- case 2				
	wait for 10 ns;
	T_load <= '0';
	wait for 10 ns;
    report "Case 2: " & to_string(T_Q);
	assert (T_Q="10001") report "Test2 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;		
		
	-- case 3
	wait for 10 ns;
	T_reset <= '1';										   
	wait for 10 ns;
    report "Case 3: " & to_string(T_Q);
	assert (T_Q="00000") report "Test3 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
		
	-- case 4
	wait for 10 ns;
	T_reset <= '0';
	wait for 10 ns;
    report "Case 4: " & to_string(T_Q);
	assert (T_Q="00000") report "Test4 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    
    -- case 5
	wait for 10 ns;
	T_load <= '1';
	wait for 10 ns;
    T_load <= '0';
    report "Case 5: " & to_string(T_Q);
	assert (T_Q="10001") report "Test5 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    
    -- case 6
	wait for 10 ns;
	T_shift <= '1';
	wait for 10 ns;
    T_shift <= '0';
    report "Case 6: " & to_string(T_Q);
	assert (T_Q="01000") report "Test6 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    -- case 7
	wait for 10 ns;
	T_shift <= '1';
	wait for 10 ns;
    T_shift <= '0';
    report "Case 7: " & to_string(T_Q);
	assert (T_Q="00100") report "Test7 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    -- case 8
	wait for 10 ns;
	T_shift <= '1';
	wait for 10 ns;
    T_shift <= '0';
    report "Case 8: " & to_string(T_Q);
	assert (T_Q="00010") report "Test8 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    -- case 9
	wait for 10 ns;
	T_shift <= '1';
	wait for 10 ns;
    T_shift <= '0';
    report "Case 9: " & to_string(T_Q);
	assert (T_Q="00001") report "Test9 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
    -- case 10
	wait for 10 ns;
	T_shift <= '1';
	wait for 10 ns;
    T_shift <= '0';
    report "Case 10: " & to_string(T_Q);
	assert (T_Q="00000") report "Test10 Failed!" severity error;
	if (T_Q/=T_I) then
	    err_cnt := err_cnt+1;
	end if;
   
		
	-- summary of all the tests
	if (err_cnt=0) then	
	    assert false
	    report "Testbench of register completely successfully!"
	    severity note;
	else
	    assert true
	    report "Something wrong, check again pls!"
	    severity error;
	end if;
	
        wait;
		
    end process;

end TB;

------------------------------------------------------------------
configuration CFG_TB of reg_TB is
    for TB
    end for;
end CFG_TB;
------------------------------------------------------------------
