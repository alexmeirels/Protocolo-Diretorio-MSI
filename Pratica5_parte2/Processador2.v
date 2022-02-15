module Processador2(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_1, 
						AddressLista, DataLista, DataCacheP0_1, SignalP2, Invalidate, DataP1);

	input Clock;
	input [3:0] AddressTest, DataP1;		
	input [1:0] WriteOrRead; 		
	input [1:0] Processor; 		
	input [3:0] DataTest;			
	
	input [1:0] HitOrMissP1;
	input [3:0] AddressMemory, DataMemory;
	
	output reg[1:0] HitOrMissP2;
	output reg[3:0] AddressLista, DataLista, AddressCacheP0_1, DataCacheP0_1;
	 
	output reg[1:0] Invalidate;
	output reg[2:0] SignalP2;
	// Variáveis Auxiliadoras

	reg[3:0] regAddressP0_1[1:0];			
	reg[2:0] regStateP0_1[1:0];				
	reg[3:0] regDataP0_1[1:0];				
	reg[1:0] HitOrMiss;
	
	// Contador
	integer cont, i, aux, aux1, aux2;



	initial begin
// Inicialização do Cache2 do processador.

//	  	  State = M				  		Address = 130				 Data	= 68			
		regStateP0_1[0] = 3'b011;  	 regAddressP0_1[0] = 4'b0111; regDataP0_1[0] = 4'b0110;


//	     State = S				  	   Address = 118			   Data	= 18	
		regStateP0_1[1] = 3'b010; 	 regAddressP0_1[1] = 4'b0100; regDataP0_1[1] = 4'b0011;


		cont = 0;
		aux = 0;
		aux1 = 0;
		aux2 = 0;
	end
	
	always@(negedge Clock)begin // Transição da máquina1
		cont = 0;
		AddressCacheP0_1 = 4'b0000;
		DataCacheP0_1 = 4'b0000;
		SignalP2 = 3'b000;
	
				for(i = 0; i < 2; i = i + 1)
					begin
						if(regAddressP0_1[i] == AddressTest) // Verifica se existe alguma tag na cache L1 igual ao do caso teste. 
							begin
								cont = 1;
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
		if(HitOrMissP1 == 2'b01 && Processor == 2'b00 && HitOrMissP2 == 2'b01 && WriteOrRead == 2'b01)
			begin
				regStateP0_1[0] = 2'b01;			// Estado muda para invalido
				DataCacheP0_1 = regDataP0_1[0];			// Dado que passará para memória por conta do writeback
				AddressCacheP0_1 = regAddressP0_1[0];	// Endereço que passará para memória por conta do writeback
				aux1 = 1;
			end
		
		#2;
		if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && Processor == 2'b01 && aux2 == 1)
			begin
				regAddressP0_1[0] = AddressTest;	//	O endereço é mudado
				regDataP0_1[0] = 4'b0010;	// Recebe o valor da memoria
				regStateP0_1[0] = 2'b10;	// COntinua shared
				SignalP2 = 3'b001; // Read Miss
			end
		if(HitOrMissP1 == 2'b01 && Processor == 2'b01)
			begin
			if(HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux == 0) // ReadMiss com WriteBack
				begin
					cont = 1000;
					AddressCacheP0_1 = regAddressP0_1[0]; 	// Passa para memória
					DataCacheP0_1 = regDataP0_1[0];			// Passa para memória
					regAddressP0_1[0] <= AddressMemory;		// Recebe o endereço da memória
					regStateP0_1[0] = 2'b10;					// Estado muda para Shared
					regDataP0_1[0] <= DataMemory;				// Recebe o dado da memoria
					SignalP2 = 3'b011;							// Sinal fetch
					aux = 1;	
				end
			
			if(HitOrMissP2 == 2'b01 && WriteOrRead == 2'b01)
				begin
					regDataP0_1[0] = DataTest;		// Recebe o valor que vai ser escrito
					regStateP0_1[0] = 2'b11; 		// Muda o estado para modified
					Invalidate = 2'b01;				// Invalidação
				end
			end
		if(HitOrMissP1 == 2'b01 && HitOrMissP2 == 2'b01 && Processor == 2'b01 && aux1 == 1)
			begin 
				regStateP0_1[0] = 2'b10;			//	Muda o estado para shared
				regDataP0_1[0] = DataP1;			// Recebe o valor da cache1
				SignalP2 = 3'b001;					// ReadMiss
				aux2 = 1;
			end
	end
endmodule
