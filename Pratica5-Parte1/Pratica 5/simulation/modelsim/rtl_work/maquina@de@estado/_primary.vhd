library verilog;
use verilog.vl_types.all;
entity maquinaDeEstado is
    port(
        Clock           : in     vl_logic;
        WriteRead       : in     vl_logic_vector(1 downto 0);
        stateCache      : in     vl_logic_vector(2 downto 0);
        stateDiretorio  : in     vl_logic_vector(2 downto 0);
        \signal\        : out    vl_logic_vector(2 downto 0);
        newStateCache   : out    vl_logic_vector(2 downto 0);
        newStateDiretorio: out    vl_logic_vector(2 downto 0);
        WriteBack       : out    vl_logic_vector(1 downto 0);
        HitMiss         : in     vl_logic_vector(1 downto 0);
        invalidate      : out    vl_logic_vector(1 downto 0);
        newStateCache2  : out    vl_logic_vector(2 downto 0);
        stateCache2     : in     vl_logic_vector(2 downto 0)
    );
end maquinaDeEstado;
