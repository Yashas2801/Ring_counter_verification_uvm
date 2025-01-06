class ring_monitor extends uvm_monitor;

  `uvm_component_utils(ring_monitor)

  virtual ring_if vif;
  uvm_analysis_port #(ring_xtn) ap;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task mon;

endclass

function ring_monitor::new(string name, uvm_component parent);
  super.new(name, parent);
  ap = new("ap", this);
endfunction

function void ring_monitor::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build phase of monitor", UVM_LOW)
  if (!uvm_config_db#(virtual ring_if)::get(this, "", "vif", vif))
    `uvm_fatal(get_type_name, "Failed to get vif in monitor")
endfunction

task ring_monitor::run_phase(uvm_phase phase);
  super.run_phase(phase);
  `uvm_info(get_type_name, "In the run_phase of monitor", UVM_LOW)
  forever mon;
endtask

task ring_monitor::mon;
  ring_xtn xtn = ring_xtn::type_id::create("xtn", this);

  @(vif.cb);
  xtn.ring_count = vif.ring_count;
  xtn.rst = vif.rst;

  ap.write(xtn);
endtask
