class ring_env extends uvm_env;
  `uvm_component_utils(ring_env)

  ring_agent agth;
  ring_coverage covh;

  extern function new(string name, uvm_component parent);
  extern function void build_phase(uvm_phase phase);
  extern function void connect_phase(uvm_phase phase);
endclass

function ring_env::new(string name, uvm_component parent);
  super.new(name, parent);
endfunction

function void ring_env::build_phase(uvm_phase phase);
  super.build_phase(phase);
  `uvm_info(get_type_name, "In build_phase of env", UVM_LOW)
  agth = ring_agent::type_id::create("agth", this);
  covh = ring_coverage::type_id::create("covh", this);

endfunction

function void ring_env::connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  `uvm_info(get_type_name, "In connect_phase of env", UVM_LOW)
  agth.monh.ap.connect(covh.analysis_export);
endfunction

