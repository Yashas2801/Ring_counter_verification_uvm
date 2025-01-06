class ring_xtn extends uvm_sequence_item;

  bit rst;
  bit [7:0] ring_count;

  `uvm_object_utils_begin(ring_xtn)
    `uvm_field_int(rst, UVM_ALL_ON)
    `uvm_field_int(ring_count, UVM_ALL_ON)
  `uvm_object_utils_end

  function new(string name = "ring_xtn");
    super.new(name);
  endfunction

  function string convert2string();
    return $sformatf("rst=%0b | ring_count=%8b", rst, ring_count);
  endfunction

endclass
