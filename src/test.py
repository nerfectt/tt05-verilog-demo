import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    my_high_Tuple = 151 # 10 01 01 11 

    dut._log.info("Start Sim")

    # initialize clk
    clock = Clock(dut.clk, 1, units="ms")
    cocotb.start_soon(clock.start())

    # first reset, then stop after 10 clk cycles
    dut.rst_n.value = 0 # low to reset
    await ClockCycles(dut.clk,10)
    dut.rst_n.value = 1 # take out of reset, inverse high

    dut.ui_in.value = my_high_Tuple
    dut.ena.value = 1 # enable the design

    # wait for a while and run for 100 cycles
    for _ in range(100):
        await RisingEdge(dut.clk)

    #assert dut.ui_in.value == dut.uo_out.value

    dut_log.info("Finished Sim")

 