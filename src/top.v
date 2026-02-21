module top(
    input clk,
    input [7:0] sw,
    input btn_store,
    input btn_rst,
    output [7:0] led_min,
    output [7:0] led_max,
    output done
);

wire valid;

min_max uut (
    .clk(clk),
    .rst(btn_rst),
    .data_in(sw),
    .valid(valid),
    .min_val(led_min),
    .max_val(led_max),
    .done(done)
);


reg btn_store_d;
always @(posedge clk) begin
    btn_store_d <= btn_store;
end

assign valid = btn_store & ~btn_store_d;
endmodule
