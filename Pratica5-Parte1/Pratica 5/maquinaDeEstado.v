module maquinaDeEstado(Clock, WriteRead, stateCache, stateDiretorio, signal, newStateCache, newStateDiretorio, WriteBack, HitMiss, invalidate, newStateCache2, stateCache2);

/* Instruções para melhor entendimento do código.
 -----------------------------------------
	Estados
	I = 001, S = 010, M = 011
	
	Signal
	000 - vazio
	001 - readMiss
	010 - readHit
	011 - writeMiss
	100 - writeHit
	
	Invalidate
	0 - Miss
	1 - Hit
	
	writeBack
	0 - Miss
	1 - Hit
	
 -----------------------------------------
 */
	//	Entradas:
	input Clock;
	input [2:0] stateCache;
	input [2:0] stateCache2;
	input [2:0] stateDiretorio;	// Estados 1 e 2.
	input [1:0] WriteRead; // saida com read ou write
	input [1:0] HitMiss;
	
	// Saídas que receberam os valores para a simulação.
	output reg[2:0] signal;
	output reg[1:0] invalidate;
	output reg[2:0] newStateCache;
	output reg[2:0] newStateCache2;
	output reg[2:0] newStateDiretorio;
	output reg[1:0] WriteBack;
	

	// Inicializando algumas variáveis.
	initial begin 
	
		signal = 3'b000; 
		newStateCache = 3'b000; 
		newStateDiretorio = 3'b000;
		WriteBack = 2'b00;
		invalidate = 2'b00;
		newStateCache2 = 3'b000; 

	end
	
	always@(negedge Clock)begin
		WriteBack = 2'b00;
		signal = 3'b000;
		invalidate = 2'b00;
		
		
// --------------------------------------------------------------------------------------------
		// Máquina de estado 1
		
		if(stateCache == 3'b001 && WriteRead == 2'b00 && HitMiss == 2'b00) //INVALID - CPU Read 
			begin
				newStateCache = 3'b010;					// Shared
				signal = 3'b001;							// Read miss
				
				if(stateCache2 == 3'b011)				// Verificando o estado da segunda cache se é Modified
					begin
						newStateCache2 = 3'b010;			// Shared
					end
			end
			
		if(stateCache == 3'b001 && WriteRead == 2'b01 && HitMiss == 2'b00) // INVALID - CPU Write 
			begin
				newStateCache = 3'b011;					// MODIFIED
				signal = 3'b011;							// Write miss
				
				if(stateCache2 == 3'b011)				// Verificando o estado da segunda cache se é Modified
					begin
						newStateCache2 = 3'b001;			// Invalidate	
					end
			end
			
		if(stateCache == 3'b010 && WriteRead == 2'b01 && HitMiss == 2'b01) //SHARED - WriteHIT 
			begin
				newStateCache = 3'b011;					// Modified
				signal = 3'b100;							// WriteHit
				invalidate = 2'b01;						// Invalidate hit
				
				if(stateCache2 == 3'b000)				// Verificando o estado da segunda cache se é Shared
					begin
						newStateCache2 = 3'b001;			// Invalidate	
					end
			end
			
		else if(stateCache == 3'b010 && WriteRead == 2'b01 && HitMiss == 2'b00) //SHARED - WriteMiss 
			begin
				newStateCache = 3'b011;					// Modified
				signal = 3'b011;							// WriteMiss.
				invalidate = 2'b01;						// Invalidate hit	

			end
		
		if(stateCache == 3'b010 && WriteRead == 2'b00 && HitMiss == 2'b01) //SHARED - ReadHit 
			begin
				newStateCache = stateCache;			// Continua o mesmo estado.
				signal = 3'b001;							// ReadHit.
			end
		else if(stateCache == 3'b010 && WriteRead == 2'b00 && HitMiss == 2'b00) // SHARED - ReadMiss 
			begin
				newStateCache = stateCache;			// Continua o mesmo estado.
				signal = 3'b001;							// ReadHit.
			end	

		if(stateCache == 3'b011 && WriteRead == 2'b00 && HitMiss == 2'b00) //MODIFIED - READ MISS 
			begin
				signal = 3'b001; 							// ReadMiss
				newStateCache = 3'b010;					// SHARED.
				WriteBack = 2'b01;						// Acontece WriteBack	
			end
			
		if(stateCache == 3'b011 && WriteRead == 2'b00 && HitMiss == 2'b01) //MODIFIED - READ Hit 
			begin
				signal = 3'b010; 							// ReadHit
				newStateCache = stateCache;			// Continua o mesmo estado.
			end
			
		if(stateCache == 3'b011 && WriteRead == 2'b01 && HitMiss == 2'b01) //MODIFIED - WriteHit 
			begin
				signal = 3'b100; 							// WriteHit
				newStateCache = stateCache;			// Continua o mesmo estado.
				invalidate = 2'b01;						// Invalidate hit	
			end
		if(stateCache == 3'b011 && WriteRead == 2'b01 && HitMiss == 2'b00) //MODIFIED - WriteMiss 
			begin
				signal = 3'b011; 							// WriteHit
				newStateCache = stateCache;			// Continua o mesmo estado.
				WriteBack = 2'b01;						// Acontece WriteBack
				invalidate = 2'b01;						// Invalidate hit	
			end
		

//-------------------------------------------------------------------------------------------------------
		// Máquina de estado 2 
		
		if(stateDiretorio == 3'b001 && signal == 3'b001) //INVALID - ReadMiss 
			begin

				newStateDiretorio = 3'b010; // SHARED

			end
			
		if(stateDiretorio == 3'b001 && signal == 3'b011) //INVALID - WriteMiss 
			begin

				newStateDiretorio = 3'b011; // MODIFIED

			end
			
		if(stateDiretorio == 3'b010 && signal == 3'b011) //SHARED - WriteMiss 
			begin

				newStateDiretorio = 3'b011; // MODIFIED

			end
			
		if(stateDiretorio == 3'b010 && signal == 3'b001) //SHARED - ReadMiss 
			begin

				newStateDiretorio = stateDiretorio; // SHARED

			end
		if(stateDiretorio == 3'b010 && signal == 3'b101) //SHARED - Invalidate 
			begin

				newStateDiretorio = 3'b011; // MODIFIED

			end
		if(stateDiretorio == 3'b010 && signal == 3'b010) //SHARED - Readhit 
			begin

				newStateDiretorio = stateDiretorio; // MODIFIED

			end
		if(stateDiretorio == 3'b011 && signal == 3'b011) //MODIFIED - WriteMiss 
			begin

				newStateDiretorio = stateDiretorio; // MODIFIED

			end
		if(stateDiretorio == 3'b011 && signal == 3'b001) //MODIFIED - ReadMiss 
			begin

				newStateDiretorio = 3'b010; 	// SHARED

			end
		if(stateDiretorio == 3'b011 && signal == 3'b100) //MODIFIED - WriteHit 
			begin

				newStateDiretorio = stateDiretorio; // MODIFIED

			end
		if(stateDiretorio == 3'b011 && signal == 3'b010) //MODIFIED - ReadHit 
			begin

				newStateDiretorio = stateDiretorio; // MODIFIED

			end
		
	end
// --------------------------------------------------------------------------------------------
endmodule
