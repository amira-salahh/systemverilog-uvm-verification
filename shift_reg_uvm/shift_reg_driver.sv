package shift_reg_driver_pkg;
import uvm_pkg::*;
import config_pkg::*;
`include "uvm_macros.svh"

class shift_reg_driver extends uvm_driver;
`uvm_component_utils(shift_reg_driver)
shift_reg_config shift_reg_cfg;
virtual shift_reg_if sh_vif;

function new(string name = "shift_reg_driver", uvm_component parent = null);
  super.new(name,parent);
endfunction

function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    shift_reg_cfg = shift_reg_config::type_id::create("shift_reg_config");
    
    if(!uvm_config_db#(shift_reg_config)::get(this, "", "CFG", shift_reg_cfg)) begin
      `uvm_fatal("build_phase", "unable to config object")
    end
endfunction 

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  sh_vif = shift_reg_cfg.sh_vif;
endfunction

task run_phase(uvm_phase phase);
  super.run_phase(phase);
  sh_vif.direction=0; 
  sh_vif.serial_in=0;
  sh_vif.mode=0;
  sh_vif.datain=0;
  sh_vif.reset=1;
  @(negedge sh_vif.clk);
  sh_vif.reset=0;
  forever begin
    @(negedge sh_vif.clk);
    sh_vif.direction = $random;
    sh_vif.serial_in = $random;
    sh_vif.mode = $random;
    sh_vif.datain = $random;
  end
endtask
endclass
endpackage