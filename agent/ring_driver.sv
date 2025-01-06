class ring_driver extends uvm_driver #(ring_xtn);

  `uvm_component_utils(ring_driver)
  virtual ring_if vif;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern task run_phase(uvm_phase phase);
  extern task drv_rst(ring_xtn xtn);

endclass

function ring_driver::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void ring_driver::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In the build_phase of driver", UVM_LOW)

  if (!uvm_config_db#(virtual ring_if)::get(this, "", "vif", vif))
    `uvm_fatal(get_type_name, "Failed to get vif in driver")

endfunction

task ring_driver::drv_rst(ring_xtn xtn);
  @(vif.cb);
  vif.rst <= xtn.rst;
endtask

task ring_driver::run_phase(uvm_phase phase);
  `uvm_info(get_type_name, "In the run phase of driver", UVM_LOW)
  super.run_phase(phase);
  forever begin
    seq_item_port.get_next_item(req);
    drv_rst(req);
    seq_item_port.item_done;
  end
endtask
