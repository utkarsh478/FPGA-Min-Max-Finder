`timescale 1ns / 1ps


module min_max #(
    parameter WIDTH = 8,      
    parameter N = 5        
)(
    input clk,
    input rst,
    input [WIDTH-1:0] data_in,
    input valid,
    output reg [WIDTH-1:0] min_val,
    output reg [WIDTH-1:0] max_val,
    output reg done
);

reg [7:0] count;
reg processing;

always @(posedge clk or posedge rst) begin
    if (rst) begin
    min_val <= 0;
    max_val <= 0;
    count   <= 0;
    done    <= 0;
    processing <= 1; 
    end 
    else begin
        if (processing && valid) begin
            if (count == 0) begin
                min_val <= data_in;
                max_val <= data_in;
            end else begin
                if (data_in < min_val)
                    min_val <= data_in;

                if (data_in > max_val)
                    max_val <= data_in;
            end

            count <= count + 1;

            if (count == N-1) begin
                done <= 1;
                processing <= 0;
            end
        end
    end
end

endmodule

