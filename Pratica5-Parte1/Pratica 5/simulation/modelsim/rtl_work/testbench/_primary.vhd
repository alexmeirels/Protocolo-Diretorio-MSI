library verilog;
use verilog.vl_types.all;
entity testbench is
    port(
        Clock           : in     vl_logic;
        WriteRead       : out    vl_logic_vector(1 downto 0);
        stateCache      : out    vl_logic_vector(2 downto 0);
        stateDiretorio  : out    vl_logic_vector(2 downto 0);
        HitMiss         : out    vl_logic_vector(1 downto 0);
        stateCache2     : out    vl_logic_vector(2 downto 0)
    );
end testbench;
