import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    my_high_Tuple = 151 # 10 01 01 11 
    my_high_Tuple_new = 199 # 11 00 01 11
    my_low_Tuple_1 = 147 # 10 01 00 11 thus p is 0
    my_low_Tuple_2 = 159 # 10 01 11 11 thus p is 3
    my_low_Tuple_3 = 155 # 10 01 10 11 thus p is 2

    dut._log.info("Start Sim")

    # initialize clk
    clock = Clock(dut.clk, 1, units="ms")
    cocotb.start_soon(clock.start())

    # first reset, then stop after 10 clk cycles
    dut.rst_n.value = 0 # low to reset
    await ClockCycles(dut.clk,10)
    dut.rst_n.value = 1 # take out of reset, inverse high

    # once out of reset Test1
    dut.ui_in.value = my_high_Tuple
    dut.ena.value = 1 # enable the design

    # wait 10 cycles Test2
    await ClockCycles(dut.clk,10)
    dut.ui_in.value = my_low_Tuple_1

    # wait 10 cycles Test3
    await ClockCycles(dut.clk,10)
    dut.ui_in.value = my_low_Tuple_2

    # wait 10 cycles Test4
    await ClockCycles(dut.clk,10)
    dut.ui_in.value = my_low_Tuple_3

    # back to high event and change the x,y,t tuple value
    await ClockCycles(dut.clk,10)
    dut.ui_in.value = my_high_Tuple_new

    # wait for a while and run for 100 cycles
    for _ in range(100):
        await RisingEdge(dut.clk)

    dut._log.info("Finished Sim")

 