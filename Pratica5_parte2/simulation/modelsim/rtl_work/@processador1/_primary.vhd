library verilog;
use verilog.vl_types.all;
entity Processador1 is
    port(
        Clock           : in     vl_logic;
        AddressTest     : in     vl_logic_vector(3 downto 0);
        WriteOrRead     : in     vl_logic_vector(1 downto 0);
        Processor       : in     vl_logic_vector(1 downto 0);
        DataTest        : in     vl_logic_vector(3 downto 0);
        HitOrMissP2     : in     vl_logic_vector(1 downto 0);
        HitOrMissP1     : out    vl_logic_vector(1 downto 0);
        AddressMemory   : in     vl_logic_vector(3 downto 0);
        DataMemory      : in     vl_logic_vector(3 downto 0);
        AddressCacheP0_0: out    vl_logic_vector(3 downto 0);
        AddressLista    : out    vl_logic_vector(3 downto 0);
        DataLista       : out    vl_logic_vector(3 downto 0);
        DataCacheP0_0   : out    vl_logic_vector(3 downto 0);
        WriteBack       : out    vl_logic_vector(1 downto 0);
        SignalP1        : out    vl_logic_vector(1 downto 0);
        Invalidate      : out    vl_logic_vector(1 downto 0)
    );
end Processador1;
