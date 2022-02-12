module Processador2(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_1, 
						AddressLista, DataLista, DataCacheP0_1, SignalP2, Invalidate);

	input Clock;
	input [3:0] AddressTest;		// Endereços
	input [1:0] WriteOrRead; 		// 00 Write e 01 Read
	input [1:0] Processor; 		// P0,0 or P0,1
	input [3:0] DataTest;			// Dado
	
	input [1:0] HitOrMissP1;
	input [3:0] AddressMemory, DataMemory;
	
	output reg[1:0] HitOrMissP2;
	output reg[3:0] AddressLista, DataLista, AddressCacheP0_1, DataCacheP0_1;
	 
	output reg[1:0] Invalidate;
	output reg[2:0] SignalP2;
	// Variáveis Auxiliadoras

	reg[3:0] regAddressP0_1[1:0];			// Endereços
	reg[2:0] regStateP0_1[1:0];				// Estados
	reg[3:0] regDataP0_1[1:0];				// Dados
	reg[1:0] HitOrMiss;
	
	
	//output reg[2:0] acaoP0_0;		// Ação do processador
	
	// Contador
	integer cont, i, aux;



	initial begin
// Processador P0,1 - CacheL1

//	  	  State = M				  		Address = 130				 Data	= 68			
		regStateP0_1[0] = 3'b011;  	 regAddressP0_1[0] = 4'b0111; regDataP0_1[0] = 4'b0110;


//	     State = S				  	   Address = 118			   Data	= 18	
		regStateP0_1[1] = 3'b010; 	 regAddressP0_1[1] = 4'b0100; regDataP0_1[1] = 4'b0011;


		cont = 0;
		aux = 0;
	end
	
	always@(negedge Clock)begin
		cont = 0;
		SignalP2 = 3'b000;
	
				for(i = 0; i < 2; i = i + 1)
					begin
						if(regAddressP0_1[i] == AddressTest) // Verifica se existe alguma tag na cache L1 igual ao do caso teste. 
							begin
								cont = cont + 1;
								if(regStateP0_1[i] == 2'b01) // Se o estado do cache estiver em invalido vai dar miss 
									begin
										HitOrMiss = 2'b00;
										HitOrMissP2 = 2'b01;
									end
								else
									begin
										HitOrMiss = 2'b01;
										HitOrMissP2 = 2'b01;
									end
							end
					end
				if(cont == 0) // Se não tiver nenhum endereço igual ao do caso teste da miss.
					begin
					
						HitOrMiss = 2'b00;
						HitOrMissP2 = HitOrMiss;

					end
		#2;
		if(HitOrMissP1 == 2'b01 && Processor == 2'b01)
			begin
			if(HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux == 0) // ReadMiss com WriteBack
				begin
					AddressCacheP0_1 = regAddressP0_1[0];
					DataCacheP0_1 = regDataP0_1[0];
					regAddressP0_1[0] <= AddressMemory;
					regStateP0_1[0] = 2'b10;
					regDataP0_1[0] <= DataMemory;
					SignalP2 = 3'b011;
					aux = 1;
				end
			
			if(HitOrMissP2 == 2'b01 && WriteOrRead == 2'b01)
				begin
					regDataP0_1[0] = DataTest;		// Recebe o valor que vai ser escrito
					regStateP0_1[0] = 2'b11; 		// Muda o estado para modified
					Invalidate = 2'b01;				// Invalidação
				end
			end
		
	end
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
	
	/* Bloco
	empty - 000
	B0 - 001
	B1 - 010
	*/
	
	/* AçãoP0_0
	
	ReadMiss 	- 	2'b01
	WriteMiss 	- 	2'b10
	Invalidate	- 	2'b11
	
	*/
		/*SignalP2
		empty 	  - 00
		ReadMiss	  - 01
		WriteMiss  - 10
		Fetch 	  - 11
		Fetch Invalidate - 100
	-------------------
		Invalidate
		Hit - 01
		Miss - 00
	*/