library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Entity declaration for the ALU
entity alu is
    Port (
        op_code : in std_logic_vector(3 downto 0); -- Operation code input (4 bits)
        r2 : in std_logic_vector(18 downto 0);     -- First operand (19 bits)
        r3 : in std_logic_vector(18 downto 0);     -- Second operand (19 bits)
        result : out std_logic_vector(18 downto 0) -- Result output (19 bits)
    );
end entity;

-- Architecture definition for the ALU
architecture Behavioral of alu is
begin
    -- Process triggered by changes in op_code, r2, or r3
    process(op_code, r2, r3)
    begin
        case op_code is
            when "0000" => -- ADD: r2 + r3
                result <= std_logic_vector(resize(unsigned(r2) + unsigned(r3), 19));

            when "0001" => -- SUB: r2 - r3
                result <= std_logic_vector(resize(unsigned(r2) - unsigned(r3), 19));

            when "0010" => -- MUL: r2 * r3
                result <= std_logic_vector(resize(unsigned(r2) * unsigned(r3), 19));

            when "0011" => -- DIV: r2 / r3 (handle division by zero)
                if r3 /= "0000000000000000000" then
                    result <= std_logic_vector(resize(unsigned(r2) / unsigned(r3), 19));
                else
                    result <= (others => '0'); -- Output zero if division by zero
                end if;

            when "0100" => -- AND: bitwise AND between r2 and r3
                result <= r2 and r3;

            when "0101" => -- OR: bitwise OR between r2 and r3
                result <= r2 or r3;

            when "0110" => -- XOR: bitwise XOR between r2 and r3
                result <= r2 xor r3;

            when "0111" => -- NOT: bitwise NOT of r2
                result <= not r2;

            when others => -- Default case: output zero
                result <= (others => '0');
        end case;
    end process;
end Behavioral;
