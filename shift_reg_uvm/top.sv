import uvm_pkg::*;
`include "uvm_macros.svh"
import shift_reg_test_pkg::*;

module top();

  bit clk;
  initial begin
    forever #1 clk= ~clk;
  end

  shift_reg_if sh_if (clk);
  shift_reg DUT (sh_if.clk, sh_if.reset, sh_if.serial_in, sh_if.direction, sh_if.mode, sh_if.datain, sh_if.dataout);

initial begin
  uvm_config_db #(virtual shift_reg_if)::set(null, "uvm_test_top", "shift_reg_if", sh_if);
  run_test("shift_reg_test");
end

endmodule