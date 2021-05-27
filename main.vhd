-- Registrador 5Bits com shift
---------------------------------------------------

library ieee ;
use ieee.std_logic_1164.all;

---------------------------------------------------

entity shift_reg is
port(	
    RegIn:		in std_logic_vector (4 downto 0);
    inputS:     in std_logic;
    shift:		in std_logic;
    load:       in std_logic;
    reset:      in std_logic;
    clckSR:		in std_logic;
    RegOut:		buffer std_logic_vector (4 downto 0)
);
end shift_reg;

---------------------------------------------------

architecture behv of shift_reg is
   
    signal S: std_logic_vector(4 downto 0):="00000";
    
begin
    
    process(clckSR, reset)
    begin

   if reset = '1' then 
      S <= "00000";
   end if;
	-- everything happens upon the clock changing
	if (clckSR'last_value='1' and clckSR='0') then
	    if shift = '1' then
		    S(0) <= inputS;
            S(1) <= RegOut(0);
            S(2) <= RegOut(1);   
            S(3) <= RegOut(2);
            S(4) <= RegOut(3);
	    end if;
       if load = '1' then
		   S <= RegIn;
	    end if;
	end if;

   end process;
	
    -- concurrent assignment
   RegOut <= S;

end architecture behv;

----------------------------------------------------
--ALU de soma e subtração
---------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all; 
---------------------------------------------------

entity ALU is

port(	
    A:	    in std_logic_vector(4 downto 0);
	B:	    in std_logic_vector(4 downto 0);
	Sel:	in std_logic_vector(1 downto 0);
	Res:	out std_logic_vector(4 downto 0)  
);

end ALU;

---------------------------------------------------

architecture behv of ALU is
begin					   

    process(A,B,Sel)
    begin
    
	-- use case statement to achieve 
	-- different operations of ALU

	case Sel is
	    when "00" =>
		Res <= A + B;
	    when "01" =>						
	    Res <= A + (not B) + 1;
        when "10" =>
		Res <= A and B;
	    when "11" =>	 
		Res <= A or B;
	    when others =>	 
		Res <= "XXXXX";
        end case;

    end process;

end behv;

---------------------------------------------------
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
        output1:    out std_logic_vector(1 downto 0)
    );
end entity multiplex2;

architecture dentro of multiplex2 is    
begin
    process(input1, input2, sel)
    begin
        case sel is
            when '0' => output1 <= input1;
            when '1' => output1 <= input2;
            when others => output1 <=input1;
        end case;
    end process;
    
    
end architecture dentro;
----------------------------------------------------
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
        if (clk = '1' and clk'last_value='0') then
            if (Reset = '1') then
                state := 0;
            elsif (state = 0 and S ='0') then 
                state := 0;
            elsif (state = 0 and S ='1') then 
                state := 1;
            elsif (state = 1) then 
                state := 2;
            elsif (state = 2 and I ='1') then 
                state := 0;
            elsif (state = 2 and I = '0' and V ="01") then 
                state := 4;
            elsif (state = 2 and I = '0' and V ="10") then 
                state := 3;
            elsif (state = 2 and I = '0' and (V ="00" or V = "11")) then 
                state := 5;
            elsif (state = 3) then 
                state := 5;
            elsif (state = 4) then 
                state := 5;
            elsif (state = 5) then 
                state := 2;
            end if;
        end if;
        case state is
            when 0 => 
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            when 1 => 
                ResetOut <= '1';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            when 2 => 
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';
            when 3 => 
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '1';
                Shift <= '0';
            when 4 => 
                ResetOut <= '0';
                AorS <= '1';
                Somar <= '1';
                Shift <= '0';
            when 5 => 
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '1';
            when others =>
                ResetOut <= '0';
                AorS <= '0';
                Somar <= '0';
                Shift <= '0';

        end case;
    end process;
end architecture;
---------------------------------------------------
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
-- Corpo principal do multiplicador.

library ieee;
use ieee.std_logic_1164.all;

entity main is
    port (
        A:      in std_logic_vector(3 downto 0);
        B:      in std_logic_vector(3 downto 0);
        Start:  in std_logic;
        Reset:  in std_logic;
        clck:   in std_logic;
        P:      out std_logic_vector(7 downto 0)
        
    );
end entity;

architecture behav of main is
    component shift_reg is
        port(	
            RegIn:		in std_logic_vector (4 downto 0);
            inputS:     in std_logic;
            shift:		in std_logic;
            load:       in std_logic;
            reset:      in std_logic;
            clckSR:		in std_logic;
            RegOut:		buffer std_logic_vector (4 downto 0)
        );
        end component;
    component ALU is

        port(	A:	in std_logic_vector(4 downto 0);
            B:	    in std_logic_vector(4 downto 0);
            Sel:	in std_logic_vector(1 downto 0);
            Res:	out std_logic_vector(4 downto 0)  
        );
        end component;
    component multiplex2
        port (
            input1:     in std_logic_vector(1 downto 0);
            input2:     in std_logic_vector(1 downto 0);
            sel:        in std_logic;
            output1:    out std_logic_vector(1 downto 0)
        );
        end component;
    component boothFSM is
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
        end component;
    component iter is 
        port(
            inc:    in std_logic;
            rst:    in std_logic;
            ite:    out std_logic
        );
    end component;

    signal extA : std_logic_vector(4 downto 0) := "00000";
    signal RegOutA: std_logic_vector (4 downto 0) := "00000";
    signal extB : std_logic_vector(4 downto 0) := "00000";
    signal RegOutB: std_logic_vector (4 downto 0) := "00000";
    signal extC : std_logic_vector(4 downto 0) := "00000";
    signal RegOutC: std_logic_vector (4 downto 0) := "00000";
    signal shiftOutFSM : std_logic := '0';
    signal resetRegC : std_logic := '0';
    signal resetFSMOUT : std_logic := '0';
    signal Somar : std_logic := '0';
    signal SoS : std_logic_vector(1 downto 0) := "00";
    signal sosFSM : std_logic := '0';
    signal iterOut : std_logic := '0';
    signal POut : std_logic_vector(7 downto 0) := "00000000";
    
    
begin
    extA(0) <= A(0);
    extA(4 downto 1) <= A;
    extB(3 downto 0) <= B;
    extB(4) <= '0';
    resetRegC <= reset or resetFSMOUT;

    RegA: shift_reg
        port map (
            extA,
            '0',
            '0',
            Start,
            Reset,
            clck,
            RegOutA
        );
    RegB: shift_reg
        port map (
            extB,
            RegOutC(4),
            shiftOutFSM,
            Start,
            Reset,
            clck,
            RegOutB
        );
    RegC: shift_reg
        port map (
            extC,
            RegOutC(0),
            shiftOutFSM,
            Somar,
            resetRegC,
            clck,
            RegOutC
        );
    ALU0: ALU
        port map (
            RegOutA,
            RegOutB,
            SoS,
            extC
        );
    SelSoma: multiplex2
        port map (
            "00",
            "01",
            sosFSM,
            SoS
        );
    BoothMachine: boothFSM 
        port map (
            iterOut,
            RegOutB(4 downto 3),
            Start,
            clck,
            Reset,
            resetFSMOUT,
            sosFSM,
            Somar,
            shiftOutFSM            
        );
    iter0: iter
        port map (
            shiftOutFSM,
            resetFSMOUT,
            iterOut
        );

    POut(3 downto 0) <= RegOutC(4 downto 1);
    POut(7 downto 4) <= RegOutB(3 downto 0); 
    P <= POut;

end architecture;

----------------------------------------------------
----------------------------------------------------