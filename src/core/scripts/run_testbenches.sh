#!/bin/bash
# Run simulation of the testbench

vsim -c -do "run -all" tb_bitcoin
