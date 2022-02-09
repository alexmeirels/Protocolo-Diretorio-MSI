module Processador2(Clock, AddressTest, WriteOrRead, Processor, DataTest, HitOrMissP2, HitOrMissP1, WriteBack);


	input Clock;
	// Variáveis do Codigo Teste 
	input [3:0] AddressTest;		// Endereços
	input [2:0] WriteOrRead; 		// 00 Write e 01 Read
	input [2:0] Processor; 		// P0,0 or P0,1
	input [3:0] DataTest;			// Dado
	input [1:0]HitOrMissP1;
	
	output reg[1:0] HitOrMissP2, WriteBack;
	
	// Variáveis Auxiliadoras

	reg[3:0] regAddressP0_1[1:0];			// Endereços
	reg[2:0] regStateP0_1[1:0];				// Estados
	reg[3:0] regDataP0_1[1:0];				// Dados
	reg[1:0] HitOrMiss;
	
	
	//output reg[2:0] acaoP0_0;		// Ação do processador
	
	// Contador
	integer cont, i;



	initial begin
// Processador P0,1 - CacheL1

//	  	  State = M				  		Address = 130				 Data	= 68			
		regStateP0_1[0] = 3'b011;  	 regAddressP0_1[0] = 4'b0111; regDataP0_1[0] = 4'b0110;


//	     State = S				  	   Address = 118			   Data	= 18	
		regStateP0_1[1] = 3'b010; 	 regAddressP0_1[1] = 4'b0100; regDataP0_1[1] = 4'b0011;


		cont = 0;
	end
	
	always@(negedge Clock)begin
		cont = 0;
	
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
									end
							end
					end
				if(cont == 0) // Se não tiver nenhum endereço igual ao do caso teste da miss.
					begin
					
						HitOrMiss = 2'b00;
						HitOrMissP2 = HitOrMiss;
						WriteBack = 2'b00;
						
					end
				
		
		
	end
endmodule