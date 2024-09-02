module tb_crc8();

    reg clk;
    reg rst;
    reg [7:0] data_in;
    reg data_valid;
    wire [7:0] crc_out;
    wire crc_error;

    // Instantiate the CRC Encoder
    crc8_encoder encoder (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .data_valid(data_valid),
        .crc_out(crc_out)
    );

    // Instantiate the CRC Decoder
    crc8_decoder decoder (
        .clk(clk),
        .rst(rst),
        .data_in(data_in),
        .crc_in(crc_out),   // CRC input from encoder
        .data_valid(data_valid),
        .crc_error(crc_error)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        clk = 0;
        rst = 1;
        data_in = 8'h00;
        data_valid = 0;

        // Apply reset
        #10;
        rst = 0;

        // Test case 1: Simple data byte
        #10;
        data_in = 8'hAB;  // Example data byte
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 2: Another data byte
        #10;
        data_in = 8'h34;  // Another data byte
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 3: All zero data
        #10;
        data_in = 8'h00;  // All zeros
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 4: All one data
        #10;
        data_in = 8'hFF;  // All ones
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 5: Alternating bits
        #10;
        data_in = 8'hAA;  // Alternating bits 10101010
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 6: Sequence of bytes
        #10;
        data_in = 8'h12;  // First byte
        data_valid = 1;
        #10;
        data_in = 8'h34;  // Second byte
        data_valid = 1;
        #10;
        data_in = 8'h56;  // Third byte
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 7: Known input with known CRC
        #10;
        data_in = 8'h1B;  // First byte
        data_valid = 1;
        #10;
        data_in = 8'h2C;  // Second byte
        data_valid = 1;
        #10;
        data_in = 8'h3D;  // Third byte
        data_valid = 1;
        #10;
        data_in = 8'h4E;  // Fourth byte
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // Test case 8: Error detection
        #10;
        data_in = 8'h5F;  // Example data byte
        data_valid = 1;
        #10;
        data_valid = 0;
        #20;

        // End of simulation
        #50 $finish;
    end

    // Monitor output
    initial begin
        $monitor("Time = %0t, data_in = %h, crc_out = %h, crc_error = %b", $time, data_in, crc_out, crc_error);
    end

endmodule
