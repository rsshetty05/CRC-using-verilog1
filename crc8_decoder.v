module crc8_decoder (
    input wire clk,
    input wire rst,
    input wire data_valid,
    input wire [7:0] data_in,  // 8-bit data input
    input wire [7:0] crc_in,   // 8-bit received CRC
    output reg crc_error       // High if CRC does not match
);

    // CRC-8 polynomial: x^8 + x^2 + x^1 + 1 (0x07)
    parameter POLYNOMIAL = 8'h07;

    reg [7:0] crc_calc;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_calc <= 8'h00; // Initial value for CRC register
        end else if (data_valid) begin
            crc_calc = crc_calc ^ data_in;
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
            crc_calc = (crc_calc[7] ? (crc_calc << 1) ^ POLYNOMIAL : crc_calc << 1);
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_error <= 0;  // Reset error flag
        end else if (data_valid) begin
            crc_error <= (crc_calc != crc_in);  // Set error if CRC doesn't match
        end
    end

endmodule
