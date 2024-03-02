library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity elevator is port (
    clk, reset : in std_logic;
    come : in std_logic_vector(3 downto 0);
    cf : in std_logic_vector(3 downto 0);
    switch : in std_logic_vector(3 downto 0);
    motor_up : out std_logic;
    motor_down : out std_logic;
    current_floor : out std_logic_vector(3 downto 0);
    move_state : out std_logic); -- zero for stop / one for moving
end entity;

architecture synth of elevator is 
    type statetype is (idle, moving, resetst);
    signal state, nextstate : statetype;
    signal pendingreq : std_logic_vector(3 downto 0) := "0000";
    signal cfloor : std_logic_vector(3 downto 0);
    signal direction : std_logic; -- 1 for moving up
    signal counter : std_logic_vector(3 downto 0); -- MSB is floor 4 > LSB is floor 1

begin
    -- current_floor <= cFloor;
    -- state REGISTER
    process (clk, reset) 
    begin
        if reset = '1' then
            state <= resetst;
        elsif rising_edge(clk) then
            state <= nextstate;
        end if;
    end process;
    
    -- NEXT state logic
    process (state, cf, come, switch, reset, cfloor, counter)
    begin
        case state is
            when idle =>
                move_state <= '0';
                
                if (cfloor and pendingreq) = cfloor then
                    pendingreq <= (pendingreq and (not cfloor));
                    nextstate <= idle;
                    motor_up <= '0';
                    motor_down <= '0';
                elsif pendingreq = "0000" then
                    pendingreq <= pendingreq or cf or come;
                    nextstate <= idle;
                    motor_up <= '0';
                    motor_down <= '0';
                else 
                    pendingreq <= pendingreq or cf or come;
                    if (counter and pendingreq) = counter then
                        nextstate <= moving;
                        motor_up <= direction;
                        motor_down <= (not direction);
                    else
                        nextstate <= idle;
                        motor_up <= '0';
                        motor_down <= '0';
                        if counter = "0001" then
                            direction <= '1';
                            counter <= "0010";
                        elsif counter = "1000" then
                            direction <= '0';
                            counter <= "0100";
                        else
                            if direction = '1' then -- moving up
                                counter <= counter(2 downto 0) & '0';
                            elsif direction = '0' then -- moving down
                                counter <= '0' & counter(3 downto 1);
                            end if;
                        end if;
                    end if;
                end if;
            when moving =>
                move_state <= '1';
                if switch = "0000" then
                    nextstate <= moving;
                    pendingreq <= pendingreq or come or cf;
                else
                    nextstate <= idle;
                    cfloor <= switch;
                    pendingreq <= (pendingreq and (not switch)) or (come or cf);
                end if;
            when resetst =>
                motor_up <= '0';
                motor_down <= '0';
                move_state <= '0';
                cfloor <= "0001"; 
                counter <= "0001";
                direction <= '1';
                pendingreq <= cf or come;
                if reset = '0' then
                    nextstate <= idle;
                else
                    nextstate <= resetst;
                end if;
            when others =>
                nextstate <= idle;
        end case;
    end process;
end;
