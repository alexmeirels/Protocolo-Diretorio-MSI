module Lista(Clock, AddressTest, DataTest, HitOrMissP2, HitOrMissP1, Signal, DataMemory, AddressMemory, Processor, Invalidate);

	input Clock;
	
	input[1:0] Processor;
	input[1:0] Signal, Invalidate;
	input[1:0] HitOrMissP2;
	input[1:0] HitOrMissP1;
	input[3:0] DataTest;			
	input[3:0] AddressTest;		
	input[3:0] AddressMemory, DataMemory;
	
	// Variáveis Aux
	//output reg[3:0] auxBlock;
	
	// Variáveis Auxiliadoras
	reg[3:0] regAddressLista[3:0];			// Endereços
	reg[2:0] regStateLista[3:0];				// Estados
	reg[3:0] regDataLista[3:0];				// Dados
	reg[1:0] regSharersLista[3:0];			// Sharers
	reg[1:0] signalSharers;				//	sinal do Sharers
	
	// Contador
	integer cont, i;
	
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
	B2 - 011
	B3 - 100
	*/
	
	/* Sharers
	empty - 000
	P0,0 - 001
	P0,1 - 010
	P0,0 e P0,1 - 011
	-----------------------
	Signal Sharers
	empty - 000
	Sharers = {}  			   - 01
	Sharers = {P} 				- 10
	Sharers = Sharers + {P} - 11
	*/
	
	
	initial begin
	
// LISTA - CacheL2

//	   State = M				    		 Address = 100					  		 Data	= 10					 Sharers = 		P0,0
		regStateLista[0] = 3'b011;   		 regAddressLista[0] = 4'b0001; 	 		 regDataLista[0] = 4'b0010;   regSharersLista[0] = 3'b001; 

//		State = S				 			 Address = 108			   			 Data	= 08					 Sharers = 		P0,0
		regStateLista[1] = 3'b010; 		 regAddressLista[1] = 4'b0010; 	 		 regDataLista[1] = 4'b0001; 	 regSharersLista[1] = 3'b001;
	
//	 	   State = M				  		 Address = 130							 Data	= 68					 Sharers = 		P0,1
		regStateLista[2] = 3'b011; 		 regAddressLista[2] = 4'b0111; 	 	 	 regDataLista[2] = 4'b0110; 	 regSharersLista[2] = 3'b010;
	
//	 		State = S				  		 Address = 118			   			 Data	= 18						Sharers = 		P0,1
		regStateLista[3] = 3'b010; 		 regAddressLista[3] = 4'b0100; 	 		 regDataLista[3] = 4'b0011; 		regSharersLista[3] = 3'b010;
	

//------------------------------------------------------------------------------------------
	cont = 0;
	end
	
	always@(negedge Clock) begin
		signalSharers = 2'b00;
			
		#4;
		if(HitOrMissP1 == 2'b00 && HitOrMissP2 == 2'b00 && Processor == 2'b00 && Signal == 2'b01)
			begin
				regAddressLista[1] <= AddressMemory;	// Recebe o valor da memória
				regDataLista[1] <= DataMemory;			// Recebe o valor da memória
				regStateLista[1] = 2'b10;					//	O estado é mudado para Shared
				regSharersLista[1] = 2'b01;				// P0_0
				signalSharers = 2'b10;						// Sharers = {P}
			end
			

	end

endmodule
