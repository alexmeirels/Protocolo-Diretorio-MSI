module Memoria(Clock, AddressMemory, DataMemory, WriteBack, AddressTest, DataTest,
					HitOrMissP2, HitOrMissP1, AddressCacheP0_0, AddressCacheP0_1, DataCacheP0_0, 
					DataCacheP0_1, Processor);
	
	input Clock;
	input [1:0] WriteBack, HitOrMissP2, HitOrMissP1, Processor;
	input [3:0] AddressTest, DataTest;
	input [3:0] AddressCacheP0_0, AddressCacheP0_1, DataCacheP0_1, DataCacheP0_0;
	
	output reg [3:0] AddressMemory, DataMemory;
	
	reg [3:0]regAddressMemory[7:0], regDataMemory[7:0];
	
	integer i, testeMemory;
	
	initial begin
		// Address = 100						Data = 10
		regAddressMemory[0] = 4'b0001; regDataMemory[0] = 4'b0010;
		
		// Address = 108						Data = 08
		regAddressMemory[1] = 4'b0010; regDataMemory[1] = 4'b0001;
		
		// Address = 110						Data = 10
		regAddressMemory[2] = 4'b0011; regDataMemory[2] = 4'b0010;
		
		// Address = 118						Data = 18
		regAddressMemory[3] = 4'b0100; regDataMemory[3] = 4'b0011;
		
		// Address = 120						Data = 20
		regAddressMemory[4] = 4'b0101; regDataMemory[4] = 4'b0100;
		
		// Address = 128						Data = 28
		regAddressMemory[5] = 4'b0110; regDataMemory[5] = 4'b0101;
		
		// Address = 130						Data = 68
		regAddressMemory[6] = 4'b0111; regDataMemory[6] = 4'b0110;
		
		// Address = 138						Data = 96
		regAddressMemory[7] = 4'b1000; regDataMemory[7] = 4'b1010;
	
	end
	
	always@(negedge Clock)begin
		#1
		testeMemory = 0;
		if(WriteBack == 2'b00 && HitOrMissP2 == 2'b00 && HitOrMissP1 == 2'b00) 
			begin
				for(i = 0; i < 8; i = i + 1)
					begin
						if(regAddressMemory[i] == AddressTest)
							begin
								if(Processor == 2'b00)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
								else if(Processor == 2'b01)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
							end
					end
				end
				
			if(WriteBack == 2'b01 && HitOrMissP1 == 2'b00 && HitOrMissP1 == 2'b00) 
			begin
				
				for(i = 0; i < 8; i = i + 1)
					begin
						if(regAddressMemory[i] == AddressTest)
							begin
								if(Processor == 2'b00)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
								else if(Processor == 2'b01)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
							end
						if(regAddressMemory[i] == AddressCacheP0_0)
							begin
								
								regDataMemory[i] = DataCacheP0_0;
							end
						if(regAddressMemory[i] == AddressCacheP0_1)
							begin
								regDataMemory[i] = DataCacheP0_1;
							end
					end
					
				end
				
			if(WriteBack == 2'b01 && HitOrMissP1 == 2'b01 && HitOrMissP1 == 2'b01) 
			begin
				
				for(i = 0; i < 8; i = i + 1)
					begin
						if(regAddressMemory[i] == AddressTest)
							begin
								if(Processor == 2'b00)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
								else if(Processor == 2'b01)
									begin
										AddressMemory <= regAddressMemory[i];
										DataMemory <= regDataMemory[i];
									end
							end
						if(regAddressMemory[i] == AddressCacheP0_0)
							begin
								regDataMemory[i] = DataCacheP0_0;
							end
						if(regAddressMemory[i] == AddressCacheP0_1)
							begin
								regDataMemory[i] = DataCacheP0_1;
							end
					end
					
				end
	
	end
endmodule

