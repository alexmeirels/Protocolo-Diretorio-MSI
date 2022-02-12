module Processador1(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_0, 
						AddressLista, DataLista, DataCacheP0_0, WriteBack, Signal, Invalidate);

	input Clock;

	// Variáveis do Codigo Teste 
	input [3:0] AddressTest;		// Endereços
	input [1:0] WriteOrRead; 		// 00 Write e 01 Read
	input [1:0] Processor; 		// P0,0 or P0,1
	input [3:0] DataTest;			// Dado
	
	input [1:0] HitOrMissP2;
	input [3:0] AddressMemory, DataMemory;
	
	output reg[1:0] HitOrMissP1, WriteBack;
	output reg[3:0] AddressLista, DataLista, AddressCacheP0_0, DataCacheP0_0;
	 
	output reg[1:0] Signal, Invalidate;
	/*Signal
		empty 	  - 00
		ReadMiss	  - 01
		WriteMiss  - 10
	-------------------
		Invalidate
		Hit - 01
		Miss - 00
	*/
	
	
	//output reg[2:0] acaoP0_0;		// Ação do processador
	
	// Variáveis Auxiliadoras
	reg[3:0] regAddressP0_0[1:0];			// Endereços
	reg[2:0] regStateP0_0[1:0];				// Estados
	reg[3:0] regDataP0_0[1:0];				// Dados
	reg[1:0] HitOrMiss;
	
	
	
	
	// Contador
	integer cont, i, aux;
	
	initial begin	
// Processador P0,0 - CacheL1

//		State = M				  	 Address = 100					Data	= 10			
		regStateP0_0[0] = 2'b11; regAddressP0_0[0] = 4'b0001; regDataP0_0[0] = 4'b0010;
	
//		State = S				  	  Address = 108			   		Data	= 08	
		regStateP0_0[1] = 2'b10; regAddressP0_0[1] = 4'b0010; regDataP0_0[1] = 4'b0001;

//------------------------------------------------------------------------------------------

		cont = 0;
		aux = 0;
	end
	
	always@(negedge Clock)begin
	
		cont = 0;
		WriteBack = 2'b00;
		//------------------------------------------------------------------------------------------------------
		// Máquina 1
		// Verifica se deu miss na cache ou hit	
				for(i = 0; i < 2; i = i + 1)
					begin
						if(regAddressP0_0[i] == AddressTest) // Verifica se existe alguma tag na cache L1 igual ao do caso teste. 
							begin
								cont = cont + 1;
								if(regStateP0_0[i] == 2'b01) // Se o estado do cache estiver em invalido vai dar miss 
									begin
										HitOrMiss = 2'b00;
										HitOrMissP1 = 2'b01;
										
									end
								else	// Read hit
									begin
										HitOrMiss = 2'b01;
										HitOrMissP1 = HitOrMiss;
										
									end
							end
					end
				if(cont == 0) // Se não tiver nenhum endereço igual ao do caso teste da miss.
					begin
						HitOrMiss = 2'b00;
						HitOrMissP1 = HitOrMiss;
						
					end
		
		if(HitOrMissP2 == 2'b00)
			begin
			if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux == 1) // ReadMiss com WriteBack
				begin
					WriteBack = 2'b01; // Hit
					#2
					Signal = 2'b01;	// Read Miss
					DataCacheP0_0 = regDataP0_0[0];			// Dado que passará para memória por conta do writeback
					AddressCacheP0_0 = regAddressP0_0[0];	// Endereço que passará para memória por conta do writeback
					regAddressP0_0[0] <= AddressMemory;	// Recebe o valor da memória
					regDataP0_0[0] <= DataMemory;			// Recebe o valor da memória
					regStateP0_0[0] = 2'b10;
				end
			if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux != 1) // ReadMiss
				begin
					#2;
					Signal = 2'b01;	// Read Miss
					regAddressP0_0[1] <= AddressMemory;	// Recebe o valor da memória
					regDataP0_0[1] <= DataMemory;			// Recebe o valor da memória
					regStateP0_0[1] = 2'b10;				//	O estado é mudado para Shared
					aux = 1;
				end
			
			end
		if(WriteOrRead == 2'b01 && HitOrMiss == 2'b01 && regStateP0_0[1] == 2'b10)	// Write Miss - Shared
			begin
				Signal = 2'b10;		// Write Miss
				Invalidate = 2'b01;	// Hit
				regDataP0_0[1] = DataTest;		// recebe o valor que vai ser escrito
				regStateP0_0[1] = 2'b11;	//	Muda o estado para modificado
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