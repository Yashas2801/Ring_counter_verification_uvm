interface ring_if (
    input bit clk
);

  logic rst;
  logic [7:0] ring_count;

  clocking cb @(posedge clk);
    //NOTE: Step keyword uses the finer timescale ie, the driving happens immediatly after edge of the clock
    default input #2 output #1step;
    input ring_count;
    output rst;
  endclocking

endinterface
