class ring_agent extends uvm_agent;

  `uvm_component_utils(ring_agent)

  ring_sequencer seqrh;
  ring_driver drvh;
  ring_monitor monh;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass

function ring_agent::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void ring_agent::build_phase(uvm_phase phase);
  `uvm_info(get_type_name, "This is the build phase of agent", UVM_LOW)
  seqrh = ring_sequencer::type_id::create("seqrh", this);
  drvh  = ring_driver::type_id::create("drvh", this);
  monh  = ring_monitor::type_id::create("monh", this);
endfunction

function void ring_agent::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In the connect phase of agent", UVM_LOW)
  drvh.seq_item_port.connect(seqrh.seq_item_export);
endfunction

