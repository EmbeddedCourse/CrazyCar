--Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
--Date        : Tue Oct 03 19:06:18 2017
--Host        : fox-19 running 64-bit major release  (build 9200)
--Command     : generate_target GPU_test_wrapper.bd
--Design      : GPU_test_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity GPU_test_wrapper is
  port (
    reset : in STD_LOGIC;
    sys_clock : in STD_LOGIC
  );
end GPU_test_wrapper;

architecture STRUCTURE of GPU_test_wrapper is
  component GPU_test is
  port (
    sys_clock : in STD_LOGIC;
    reset : in STD_LOGIC
  );
  end component GPU_test;
begin
GPU_test_i: component GPU_test
     port map (
      reset => reset,
      sys_clock => sys_clock
    );
end STRUCTURE;
