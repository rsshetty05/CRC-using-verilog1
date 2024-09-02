module crc8_encoder (
    input wire clk,
    input wire rst,
    input wire data_valid,
    input wire [7:0] data_in,  // 8-bit data input
    output reg [7:0] crc_out   // 8-bit CRC output
);

    // CRC-8 polynomial: x^8 + x^2 + x^1 + 1 (0x07)
    parameter POLYNOMIAL = 8'h07;

    reg [7:0] crc_reg;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_reg <= 8'h00; // Initial value for CRC register
        end else if (data_valid) begin
            crc_reg = crc_reg ^ data_in; // XOR input data with CRC register
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
            crc_reg = (crc_reg[7] ? (crc_reg << 1) ^ POLYNOMIAL : crc_reg << 1);
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_out <= 8'h00;  // Reset CRC output
        end else begin
            crc_out <= crc_reg;
        end
    end

endmodule
