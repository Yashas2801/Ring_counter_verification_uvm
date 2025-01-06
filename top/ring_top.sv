
module ring_top;
  import uvm_pkg::*;
  import ring_pkg::*;

  bit clk;

  ring_if if0 (clk);

  ring_rtl DUT (
      .rst(if0.rst),
      .clk(if0.clk),
      .out(if0.ring_count)
  );

  initial begin
    clk = 0;
  end

  always #5 clk = ~clk;

  initial begin
    uvm_config_db#(virtual ring_if)::set(null, "*", "vif", if0);
    run_test();
  end

  property next_bit_high;
    @(posedge clk) disable iff (if0.rst)
  (if0.ring_count == 8'b0000_0001) |=> (if0.ring_count == 8'b0000_0010) or
  (if0.ring_count == 8'b0000_0010) |=> (if0.ring_count == 8'b0000_0100) or
  (if0.ring_count == 8'b0000_0100) |=> (if0.ring_count == 8'b0000_1000) or
  (if0.ring_count == 8'b0000_1000) |=> (if0.ring_count == 8'b0001_0000) or
  (if0.ring_count == 8'b0001_0000) |=> (if0.ring_count == 8'b0010_0000) or
  (if0.ring_count == 8'b0010_0000) |=> (if0.ring_count == 8'b0100_0000) or
  (if0.ring_count == 8'b0100_0000) |=> (if0.ring_count == 8'b1000_0000) or
  (if0.ring_count == 8'b1000_0000) |=> (if0.ring_count == 8'b0000_0001);
  endproperty

  NEXT_BIT_HIGH :
  assert property (next_bit_high) begin
    $display("Ring counter sequence is verified");
  end else $error("Ring counter failed: Next bit is not high in sequence");

  cover property (next_bit_high);

endmodule
