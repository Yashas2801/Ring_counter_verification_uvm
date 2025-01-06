class ring_sequencer extends uvm_sequencer #(ring_xtn);

  `uvm_component_utils(ring_sequencer)

  extern function new(string name, uvm_component parent);
endclass

function ring_sequencer::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction
