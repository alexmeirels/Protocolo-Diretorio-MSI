module Processador1(Clock, AddressTest, WriteOrRead, Processor, DataTest, 
						HitOrMissP2, HitOrMissP1, AddressMemory, DataMemory, AddressCacheP0_0, 
						AddressLista, DataLista, DataCacheP0_0, WriteBack, SignalP1, Invalidate,
						DataP1);

	input Clock;

	// Variáveis do Codigo Teste 
	input [3:0] AddressTest;		
	input [1:0] WriteOrRead; 		
	input [1:0] Processor; 		
	input [3:0] DataTest;			
	
	input [1:0] HitOrMissP2;
	input [3:0] AddressMemory, DataMemory;
	
	output reg[1:0] HitOrMissP1;
	output reg[3:0] AddressLista, DataLista, AddressCacheP0_0, DataCacheP0_0, DataP1;
	 
	output reg[1:0] Invalidate, WriteBack;
	output reg[2:0] SignalP1;
	
	// Variáveis Auxiliadoras
	reg[3:0] regAddressP0_0[1:0];			// Endereços
	reg[2:0] regStateP0_0[1:0];				// Estados
	reg[3:0] regDataP0_0[1:0];				// Dados
	reg[1:0] HitOrMiss;

	// Contador
	integer cont, i, aux, aux1;
	
	initial begin	
// Inicialização da cache1 do Processador

//		State = M				  	 Address = 100					Data	= 10			
		regStateP0_0[0] = 2'b11; regAddressP0_0[0] = 4'b0001; regDataP0_0[0] = 4'b0010;
	
//		State = S				  	  Address = 108			   		Data	= 08	
		regStateP0_0[1] = 2'b10; regAddressP0_0[1] = 4'b0010; regDataP0_0[1] = 4'b0001;

//------------------------------------------------------------------------------------------

// Inicialização de variaveis auxiliares
		cont = 0;
		aux = 0;
		aux1 = 0;
	end
	
	always@(negedge Clock)begin // Código de transição da máquina 1.
	
		SignalP1 = 3'b000;
		Invalidate = 2'b00;
		cont = 0;
		WriteBack = 2'b00;
		AddressCacheP0_0 = 4'b0000;
		DataCacheP0_0 = 4'b0000;
		
				for(i = 0; i < 2; i = i + 1)
					begin
						if(regAddressP0_0[i] == AddressTest) // Verifica se existe alguma tag na cache L1 igual ao do caso teste. 
							begin
								cont = 1;
								
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
						HitOrMissP1 = 2'b00;
						
					end
		if(HitOrMissP1 == 2'b01 && HitOrMissP2 == 2'b01 && Processor == 2'b01 && WriteOrRead == 2'b00)
			begin
				
				DataP1 = regDataP0_0[0];	// Valor que vai ser passado para cache2
				regStateP0_0[0] = 2'b10;	// O estado é mudado para Shared
				WriteBack = 2'b01;			// Acontece WriteBack
				Invalidate = 2'b01;			// Sinal de Invalidate
				DataCacheP0_0 = 4'b1001;			// Dado que passará para memória por conta do writeback
				AddressCacheP0_0 = regAddressP0_0[0];	// Endereço que passará para memória por conta do writeback
			end
		if(HitOrMissP2 == 2'b00 && Processor == 2'b01 && aux1 == 0)
			begin
				WriteBack = 2'b01;
				aux1 = 1;
			end
			
		if(WriteOrRead == 2'b01 && HitOrMiss == 2'b01 && Processor == 2'b01 && aux1 == 1)
			begin
				
				regStateP0_0[0] = 2'b01; 		// Muda o estado para invalido
				regDataP0_0[0] = DataTest;		// Pega o valor escrito
				Invalidate = 2'b01;				// Sinal invalidate
				
			end
		if(HitOrMissP1 == 2'b01 && HitOrMissP2 == 2'b01 && WriteOrRead == 2'b01 && Processor == 2'b00)
				begin
					
					SignalP1 = 3'b100;				// Fetch Invalidate
					regStateP0_0[0] = 2'b11;		// o estado foi mudado para modificado
					regDataP0_0[0] = DataTest;		// Escreve o dado passado
					WriteBack = 2'b01;
				end
			
		if(HitOrMissP2 == 2'b00 && Processor == 2'b00)
			begin
			if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux == 1) // ReadMiss com WriteBack
				begin
					WriteBack = 2'b01; // Hit
					#2
					SignalP1 = 3'b001;	// Read Miss
					DataCacheP0_0 = regDataP0_0[0];			// Dado que passará para memória por conta do writeback
					AddressCacheP0_0 = regAddressP0_0[0];	// Endereço que passará para memória por conta do writeback
					regAddressP0_0[0] <= AddressMemory;	// Recebe o valor da memória
					regDataP0_0[0] <= DataMemory;			// Recebe o valor da memória
					regStateP0_0[0] = 2'b10;				// Shared
				end
			if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && WriteOrRead == 2'b00 && HitOrMiss == 2'b00 && aux != 1) // ReadMiss
				begin
					#2;
					SignalP1 = 3'b001;	// Read Miss
					regAddressP0_0[1] <= AddressMemory;	// Recebe o valor da memória
					regDataP0_0[1] <= DataMemory;			// Recebe o valor da memória
					regStateP0_0[1] = 2'b10;				//	Shared
					aux = 1;
				end
			end
		if(WriteOrRead == 2'b01 && HitOrMiss == 2'b01 && regStateP0_0[1] == 2'b10)	// Write Miss - Shared
			begin
				SignalP1 = 3'b010;		// Write Miss
				Invalidate = 2'b01;	// Hit
				regDataP0_0[1] = DataTest;		// recebe o valor que vai ser escrito
				regStateP0_0[1] = 2'b11;	//	Muda o estado para modificado
			end
		end
	
endmodule