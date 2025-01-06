class ring_coverage extends uvm_subscriber #(ring_xtn);
  `uvm_component_utils(ring_coverage)

  ring_xtn xtn;

  covergroup cg1;
    option.per_instance = 1;
    RING_VALUE: coverpoint xtn.ring_count {
      bins all_values[] ={8'b0000_0001, 8'b0000_0010, 8'b0000_0100, 8'b0000_1000,
                          8'b0001_0000, 8'b0010_0000, 8'b0100_0000, 8'b1000_0000};
    }
    RESET: coverpoint xtn.rst {bins rst_high = {1}; bins rst_low = {0};}

  endgroup

  function new(string name, uvm_component parent);
    super.new(name, parent);
    cg1 = new;
  endfunction

  function void write(ring_xtn t);
    xtn = t;
    cg1.sample;

    check_reset_behavior(t);
    check_onehot(t);
  endfunction

  function void check_reset_behavior(ring_xtn t);
    if (t.rst == 1) begin
      `uvm_info("RESET_CHECK", "Reset detected. Counter output should be 8'b1000_0000", UVM_MEDIUM)
      assert (t.ring_count == 8'b1000_0000)
      else `uvm_error("ASSERT_FAIL", "Counter output is incorrect during reset");
    end
  endfunction

  function void check_onehot(ring_xtn t);
    if (t.rst == 0) begin
      if (!$onehot(t.ring_count)) begin
        `uvm_error("ASSERT_FAIL", "Counter output is not one-hot");
      end else begin
        `uvm_info("ONEHOT_CHECK", "One-hot output is valid", UVM_MEDIUM);
      end
    end
  endfunction

  function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info(get_type_name(), $sformatf("Coverage: %0.2f%%", cg1.get_coverage()), UVM_MEDIUM);
  endfunction
endclass
