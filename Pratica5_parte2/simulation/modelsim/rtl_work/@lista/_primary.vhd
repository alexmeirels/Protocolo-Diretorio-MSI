library verilog;
use verilog.vl_types.all;
entity Lista is
    port(
        Clock           : in     vl_logic;
        AddressTest     : in     vl_logic_vector(3 downto 0);
        DataTest        : in     vl_logic_vector(3 downto 0);
        HitOrMissP2     : in     vl_logic_vector(1 downto 0);
        HitOrMissP1     : in     vl_logic_vector(1 downto 0);
        SignalP1        : in     vl_logic_vector(1 downto 0);
        SignalP2        : in     vl_logic_vector(1 downto 0);
        DataMemory      : in     vl_logic_vector(3 downto 0);
        AddressMemory   : in     vl_logic_vector(3 downto 0);
        Processor       : in     vl_logic_vector(1 downto 0);
        Invalidate      : in     vl_logic_vector(1 downto 0);
        WriteOrRead     : in     vl_logic_vector(1 downto 0)
    );
end Lista;
