module Diretorio(Clock);

	input Clock;

//testbench

	wire [2:0] stateCache;
	wire [2:0] stateCache2;
	wire [2:0] stateDiretorio;	
	wire [1:0] WriteRead;
	wire [1:0] invalidate;
	wire [2:0] signal; 

	wire [2:0] newStateCache;
	wire [2:0] newStateCache2;
	wire [2:0] newStateDiretorio;
	wire [1:0] WriteBack;
	wire [1:0] HitMiss;

	testbench test(Clock, WriteRead, stateCache, stateDiretorio, HitMiss, stateCache2);
	maquinaDeEstado maquinasDeEstados1e2(Clock, WriteRead, stateCache, stateDiretorio, signal, newStateCache, newStateDiretorio, WriteBack, HitMiss, invalidate, newStateCache2, stateCache2);
	

endmodule