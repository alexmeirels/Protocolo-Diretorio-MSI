library verilog;
use verilog.vl_types.all;
entity Memoria is
    port(
        Clock           : in     vl_logic;
        AddressMemory   : out    vl_logic_vector(3 downto 0);
        DataMemory      : out    vl_logic_vector(3 downto 0);
        WriteBack       : in     vl_logic_vector(1 downto 0);
        AddressTest     : in     vl_logic_vector(3 downto 0);
        DataTest        : in     vl_logic_vector(3 downto 0);
        HitOrMissP2     : in     vl_logic_vector(1 downto 0);
        HitOrMissP1     : in     vl_logic_vector(1 downto 0);
        AddressCacheP0_0: in     vl_logic_vector(3 downto 0);
        AddressCacheP0_1: in     vl_logic_vector(3 downto 0);
        DataCacheP0_0   : in     vl_logic_vector(3 downto 0);
        DataCacheP0_1   : in     vl_logic_vector(3 downto 0);
        Processor       : in     vl_logic_vector(1 downto 0)
    );
end Memoria;
