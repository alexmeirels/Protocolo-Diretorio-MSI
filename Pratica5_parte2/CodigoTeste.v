module CodigoTeste(Clock, AddressTest, WriteOrRead, Processor, DataTest);

	input Clock;
	
	output reg[3:0] AddressTest;	// Endereços
	output reg[1:0] WriteOrRead; 	// 00 Write e 01 Read
	output reg[1:0] Processor; 	// P0,0 or P0,1
	output reg[3:0] DataTest;		// Dado
	
	// Variáveis auxReg
	reg[3:0] regAddressTest[8:0];	// Endereços
	reg[1:0] regWriteOrRead[8:0];	//	Write or Read
	reg[1:0] regProcessor[8:0];	// P0,0 or P0,1
	reg[3:0] regDataTest[8:0];		// Dado
		
	integer cont;
	
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
-----------------
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
-----------------
	Processor
	P0,0 - 00
	P0,1 - 01
-----------------
	WriteOrRead
	Read - 00;
	Write - 01;
	*/
	initial begin
	
		cont = 0;
		
		// P0,0: read 100
		regAddressTest[0] = 4'b0001;	// 100
		regWriteOrRead[0] = 2'b00;		// Read
		regProcessor[0] = 2'b00;		// P0,0
		regDataTest[0] = 4'b0000;		// vazia
		
		// P0,0: read 128
		regAddressTest[1] = 4'b0110;	// 128
		regWriteOrRead[1] = 2'b00;		// Read
		regProcessor[1] = 2'b00;		// P0,0
		regDataTest[1] = 4'b0000;		// vazia
		
		// P0,0: write 128 < -- 78
		regAddressTest[2] = 4'b0110;	// 128
		regWriteOrRead[2] = 2'b01;		// Write
		regProcessor[2] = 2'b00;		// P0,0
		regDataTest[2] = 4'b0111;		// 78
		
		//	P0,0: read 120
		regAddressTest[3] = 4'b0101;	// 120
		regWriteOrRead[3] = 2'b00;		// Read
		regProcessor[3] = 2'b00;		// P0,0
		regDataTest[3] = 4'b0000;		// vazia
		
		// P0,1: read 120 Falha de leitura na cache L1
		
		
		// P0,1: write 120 <-- 80
		
		
		// P0,0: write 120 < -- 90
		
		
		// P0, 1: read 120
		
		
		// P0,1: read 100 
	end
	
	always@(posedge Clock) begin

			AddressTest = regAddressTest[cont];
			WriteOrRead = regWriteOrRead[cont];
			Processor = regProcessor[cont];
			DataTest = regDataTest[cont];
			cont = cont + 1;
			
			
	end
	

endmodule
