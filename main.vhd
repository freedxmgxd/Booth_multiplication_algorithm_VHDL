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

    signal extA : std_logic_vector(4 downto 0);
    signal RegOutA: std_logic_vector (4 downto 0);
    signal extB : std_logic_vector(4 downto 0);
    signal RegOutB: std_logic_vector (4 downto 0);
    signal extC : std_logic_vector(4 downto 0):="00000";
    signal RegOutC: std_logic_vector (4 downto 0);
    signal shiftOutFSM : std_logic;
    signal resetRegC : std_logic;
    signal resetFSMOUT : std_logic;
    signal somarFSMOUT : std_logic;
    signal SoS : std_logic_vector(1 downto 0) := "00";
    signal sosFSM : std_logic := '0';
    signal iterOut : std_logic;
    signal POut : std_logic_vector(9 downto 0);
    signal ver : std_logic_vector(1 downto 0);
     
begin
    extA(0) <= A(0);
    extA(1) <= A(1);
    extA(2) <= A(2);
    extA(3) <= A(3);
    extA(4) <= A(3);
    extB(0) <= '0';
    extB(1) <= B(0);
    extB(2) <= B(1);
    extB(3) <= B(2);
    extB(4) <= B(3);
    resetRegC <= reset or resetFSMOUT;
    Ver(0) <= RegOutB(0); 
    Ver(1) <= RegOutB(1); 
	
    
    RegA: shift_reg
        port map (
            extA,
            '0',
            '0',
            resetFSMOUT,
            Reset,
            clck,
            RegOutA
        );
    RegB: shift_reg
        port map (
            extB,
            RegOutC(0),
            shiftOutFSM,
            resetFSMOUT,
            Reset,
            clck,
            RegOutB
        );
    RegC: shift_reg
        port map (
            extC,
            RegOutC(4),
            shiftOutFSM,
            somarFSMOUT,
            resetRegC,
            clck,
            RegOutC
        );
    ALU0: ALU
        port map (
            RegOutC,
            RegOutA,
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
            Ver,
            Start,
            clck,
            Reset,
            resetFSMOUT,
            sosFSM,
            somarFSMOUT,
            shiftOutFSM            
        );
    iter0: iter
        port map (
            shiftOutFSM,
            resetFSMOUT,
            iterOut
        );

    Pout <= RegOutC& RegOUtB;
    P <= POut(8 downto 1);

end architecture;

----------------------------------------------------
----------------------------------------------------