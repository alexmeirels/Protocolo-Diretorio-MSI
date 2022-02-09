library verilog;
use verilog.vl_types.all;
entity CodigoTeste is
    port(
        Clock           : in     vl_logic;
        AddressTest     : out    vl_logic_vector(3 downto 0);
        WriteOrRead     : out    vl_logic_vector(1 downto 0);
        Processor       : out    vl_logic_vector(1 downto 0);
        DataTest        : out    vl_logic_vector(3 downto 0)
    );
end CodigoTeste;
