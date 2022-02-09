module testbench(Clock, WriteRead, stateCache, stateDiretorio, HitMiss, stateCache2);

	input Clock;
	
	reg [2:0] regStateCache[14:0], regStateDiretorio[14:0], regStateCache2[14:0];
	
	reg [1:0] regWriteRead[14:0], regHitMiss[14:0]; 
	
	integer cont;
	
	output reg [1:0] HitMiss;
	output reg [2:0] stateCache;
	output reg [2:0] stateCache2;
	output reg [2:0] stateDiretorio;	// Estados 1 e 2.
	output reg [1:0] WriteRead; // saida com read ou write

	// Estados
	// I = 001, S = 010, M = 011
	
	//WRITE or READ
	// 00 read
	// 01 write
	
	//Hit or miss
	// 00 miss
	// 01 Hit
	initial begin // FAZER O CASO TESTE AINDA, ALTERAR A TAG
		cont = 0;
		
	// INVALID READ Miss - Muda o estado cache para shared. Emite o sinal ReadMiss e muda o estado do diretorio para shared. Certo
		regHitMiss[0] = 2'b00;				// Miss
		regWriteRead[0] = 2'b00; 			// Read
		regStateCache[0] = 3'b001;			// I
		regStateDiretorio[0] = 3'b001;	// I

	// INVALID WRITE Miss - Muda o estado da cache para Modified. Emite o sinal WriteMiss e muda o estado do diretorio para Modified. Certo
		regHitMiss[1] = 2'b00;				// Miss
		regWriteRead[1] = 2'b01; 			// Write
		regStateCache[1] = 3'b001;			// I
		regStateDiretorio[1] = 3'b001;	// I
		
	// SHARED WRITE Hit - Muda o estado da cache para Modified. Emite o sinal Invalidate e muda o estado do diretório para Modified. Certo
		regHitMiss[2] = 2'b01;				// Hit
		regWriteRead[2] = 2'b01; 			// Write
		regStateCache[2] = 3'b010;			// S
		regStateDiretorio[2] = 3'b010;	// S
		
	// SHARED WRITE Miss - Muda o estado da cache para Modified. Emite o sinal WriteHit e muda o estado do diretório para Modified. Certo
		regHitMiss[3] = 2'b00;				// Miss 
		regWriteRead[3] = 2'b01; 			// Write
		regStateCache[3] = 3'b010;			// S
		regStateDiretorio[3] = 3'b010;	// S
		
	// SHARED READ Miss - Mantêm os estados da cache e do diretório. - Certo
		regHitMiss[4] = 2'b00;				// Miss
		regWriteRead[4] = 2'b00; 			// Read
		regStateCache[4] = 3'b010;			// S
		regStateDiretorio[4] = 3'b010;	// S
		
	// SHARED READ Hit - Mantêm os estados da cache e do diretório. - Certo
		regHitMiss[5] = 2'b01;				// Hit
		regWriteRead[5] = 2'b00; 			// Read
		regStateCache[5] = 3'b010;			// S
		regStateDiretorio[5] = 3'b010;	// S
		
	// MODIFIED READ Miss - Muda o estado da cache para Shared. Emite o sinal ReadMiss e muda o estado do diretório para Shared e acontece
																																										// Writeback.
		regHitMiss[6] = 2'b00;				// Miss																											Certo
		regWriteRead[6] = 2'b00; 			// Read
		regStateCache[6] = 3'b011;			// M
		regStateDiretorio[6] = 3'b011;	// M
		
	// MODIFIED WRITE Miss - Mantêm os estados da cache e do diretório e acontece Writeback. - certo
		regHitMiss[7] = 2'b00;				// Miss
		regWriteRead[7] = 2'b01; 			// Write
		regStateCache[7] = 3'b011;			// M
		regStateDiretorio[7] = 3'b011;	// M
		
	// MODIFIED WRITE Hit - Mantêm os estados da cache e do diretório.
		regHitMiss[8] = 2'b01;				// Hit
		regWriteRead[8] = 2'b01; 			// Write
		regStateCache[8] = 3'b011;			// M
		regStateDiretorio[8] = 3'b011;	// M
		
	// MODIFIED READ Hit - Mantêm os estados da cache e do diretório.
		regHitMiss[9] = 2'b01;				// Hit
		regWriteRead[9] = 2'b00; 			// Read
		regStateCache[9] = 3'b011;			// M
		regStateDiretorio[9] = 3'b011;	// M
		
// CASOS ESPECIAIS 
//-----------------------------------------------------------------------------

	// INVALID READ MISS - CACHE2 = MODIFIED - Cache1 mudaria para Shared e o Cache2 mudaria para Shared. O diretório mudaria para Shared
		regHitMiss[10] = 2'b00;				// Miss
		regWriteRead[10] = 2'b00; 			// Read
		regStateCache[10] = 3'b001;		// I
		regStateDiretorio[10] = 3'b001;	// I
		regStateCache2[10] = 3'b011;		// M
		
	// INVALID WRITE MISS - CACHE 2 = MODIFIED - Cache1 mudaria para Modified, o Cache2 mudaria para Inválido e o diretório mudaria para Modified 
		regHitMiss[11] = 2'b00;				// Miss
		regWriteRead[11] = 2'b01; 			// Write
		regStateCache[11] = 3'b001;		// I
		regStateDiretorio[11] = 3'b001;	// I
		regStateCache2[11] = 3'b011;		// M
		
	// SHARED WRITE HIT - CACHE2 = SHARED - Cache1 mudaria para Modified, o Cache2 mudaria para Inválido e o diretório mudaria para Shared
		regHitMiss[12] = 2'b00;				// Miss
		regWriteRead[12] = 2'b00; 			// Read
		regStateCache[12] = 3'b010;		// S
		regStateDiretorio[12] = 3'b010;	// S
		regStateCache2[12] = 3'b010;		// S
		
//-----------------------------------------------------------------------------
	end
	
	always@(posedge Clock) begin

			WriteRead = regWriteRead[cont];
			stateCache = regStateCache[cont];
			stateDiretorio = regStateDiretorio[cont];
			HitMiss = regHitMiss[cont];
			stateCache2 = regStateCache2[cont];
			cont = cont + 1;
			
			
	end
	


endmodule
