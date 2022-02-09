module Diretorio(Clock);

	input Clock;
	
	// Variáveis do Processador Cache L1
	wire[3:0] AddressCacheP0_0;		// Endereços
	wire[3:0] AddressCacheP0_1;
	wire[2:0] StateP0_0;			// Estados
	wire[3:0] DataCacheP0_0;			// Dados
	wire[3:0] DataCacheP0_1;			// Dados
	wire[2:0] BlockP0_0;			// Block
	wire[1:0] HitOrMissP1;		// Hit em P1
	wire[1:0] HitOrMissP2;		// Hit em P2s
	wire[1:0] Signal;
	
	// Variáveis da Lista Cache L2
	wire[3:0] AddressLista;		// Endereços
	wire[2:0] StateLista;		// Estados
	wire[3:0] DataLista;			// Dados
	wire[2:0] BlockLista;		// Block
	
	// Variáveis do Codigo Teste 
	wire[3:0] AddressTest;
	wire[1:0] WriteOrRead;
	wire[1:0] Processor;
	wire[3:0] DataTest;
	wire[1:0] Sharers;
	
	// Variáveis Memória
	wire[3:0] AddressMemory, DataMemory;
	wire[1:0] WriteBack;
	
	Processador1 P1(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_0, 
						AddressCacheP0_1, DataCacheP0_0, DataCacheP0_1, WriteBack, Signal);
						
	Processador2 P2(Clock, AddressTest, WriteOrRead, Processor, DataTest, HitOrMissP2, HitOrMissP1);
	
	CodigoTeste Teste(Clock, AddressTest, WriteOrRead, Processor, DataTest);
	
	Memoria MemoriaPrincipal(Clock, AddressMemory, DataMemory, WriteBack, AddressTest, DataTest,
									HitOrMissP2, HitOrMissP1, AddressCacheP0_0, AddressCacheP0_1, DataCacheP0_0, 
									DataCacheP0_1, Processor);
									
	Lista Diretorio(Clock, AddressTest, DataTest, HitOrMissP2, HitOrMissP1, Signal, DataMemory, AddressMemory, Processor);
endmodule

	
	/* Address
	empty - 0000
	100	- 0001
	108	- 0010
	110	- 0011
	118	- 0100
	120	- 0101
	128	- 0110
	130	- 0111
	138	- 1000
	*/
	
	/* State
	empty - 000
	I - 001
	S - 010
	M - 011
	*/
	
	/* Data
	empty - 0000
	08	- 0001
	10 - 0010
	18 - 0011
	20 - 0100
	28 - 0101
	68 - 0110
	78 - 0111
	80 - 1000
	90 - 1001
	*/
