library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb is
end entity tb;

architecture behave of tb is
    component elevator is port (
        clk, reset : in std_logic;
        come : in std_logic_vector(3 downto 0);
        cf : in std_logic_vector(3 downto 0);
        switch : in std_logic_vector(3 downto 0);
        motor_up : out std_logic;
        motor_down : out std_logic;
        current_floor : out std_logic_vector(3 downto 0);
        move_state : out std_logic -- zero for stop / one for moving
        );
    end component elevator;

    signal clk, reset, motor_up, motor_down, move_state : std_logic;
    signal come, cf, current_floor : std_logic_vector (3 downto 0);
    signal switch : std_logic_vector (3 downto 0) := "0001";
    signal tempsw : std_logic_vector (3 downto 0);

begin
    dut : elevator port map(clk, reset, come, cf, switch, motor_up, motor_down, current_floor, move_state);
    process begin
        clk <= '1';
        wait for 5 ns;
        clk <= '0';
        wait for 5 ns;
    end process;
    process begin
        reset <= '1';
        come <= "0000";
        cf <= "0000";
        switch <= "0001";
        wait for 12 ns;
        reset <= '0';
        wait for 32 ns;
        cf <= "0100";
        wait for 10 ns;
        switch <= "0000";
        wait for 32 ns;
        switch <= "0010";
        wait for 32 ns;
        switch <= "0000";
        wait for 32 ns;
        switch <= "0100";
        wait for 500 ns;
        reset <= '1';
        come <= "0000";
        cf <= "0000";
        wait for 5 ns;
        reset <= '0';
        wait for 10 ns;
        cf <= "0010";
        wait;
    end process;
end architecture behave;
