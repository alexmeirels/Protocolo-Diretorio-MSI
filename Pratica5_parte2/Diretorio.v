module Diretorio(Clock);
// Pequena introdução sobre o valor de cada binário utilizado no projeto.

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
	--------------
	State
	empty - 000
	I - 001
	S - 010
	M - 011
	--------------
	Data
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
	------------------
	SignalP2/SignalP1
	empty 	  - 00
	ReadMiss	  - 01
	WriteMiss  - 10
	Fetch 	  - 11
	Fetch Invalidate - 100
	---------------
	Invalidate
	Hit - 01
	Miss - 00
	---------------
	Processor
	P0,0 - 00
	P0,1 - 01
	---------------
	WriteOrRead
	Read - 00;
	Write - 01;
	---------------
	Sharers
	empty - 000
	P0,0 - 001
	P0,1 - 010
	P0,0 e P0,1 - 011
	---------------
	Signal Sharers
	empty - 000
	Sharers = {}  			   - 01, data vlaue reply
	Sharers = {P} 				- 10, data vlaue reply
	Sharers = Sharers + {P} - 11, data vlaue reply
	*/
	input Clock;
	
	// Variáveis do Processador Cache L1
	wire[3:0] DataCacheP0_0;			
	wire[2:0] StateP0_0;			
	wire[3:0] AddressCacheP0_0, DataP1;		
	wire[1:0] HitOrMissP1;		
	wire[2:0] SignalP1;
	
	// Variáveis do Processador Cache L2
	wire[3:0] AddressCacheP0_1;
	wire[3:0] DataCacheP0_1;			
	wire[1:0] HitOrMissP2;		
	wire[2:0] SignalP2;
	
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
	
	// Sinais de envio.
	wire[1:0] WriteBack;
	wire[1:0] Invalidate;
	
	Processador1 P1(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_0, 
						AddressLista, DataLista, DataCacheP0_0, WriteBack, SignalP1, Invalidate, DataP1);
						
	Processador2 P2(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_1, 
						AddressLista, DataLista, DataCacheP0_1, SignalP2, Invalidate, DataP1);
	
	CodigoTeste Teste(Clock, AddressTest, WriteOrRead, Processor, DataTest);
	
	Memoria MemoriaPrincipal(Clock, AddressMemory, DataMemory, WriteBack, AddressTest, DataTest,
									HitOrMissP2, HitOrMissP1, AddressCacheP0_0, AddressCacheP0_1, DataCacheP0_0, 
									DataCacheP0_1, Processor);
									
	Lista List(Clock, AddressTest, DataTest, HitOrMissP2, HitOrMissP1, SignalP1, SignalP2, DataMemory, AddressMemory, 
						Processor, Invalidate, WriteOrRead);
endmodule
