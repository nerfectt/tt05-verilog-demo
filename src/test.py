import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles

@cocotb.test()
async def test_my_design(dut):
    my_high_Tuple = 151 # 10 01 01 11 
    my_high_Tuple_2 = 247 # 11 11 01 11

    my_low_Tuple = 147 # 10 01 00 11 thus p is 0

    dut._log.info("Start Sim")

    # initialize clk
    clock = Clock(dut.clk, 1, units="ns")
    cocotb.start_soon(clock.start())

    # first reset, then stop after 10 clk cycles
    dut.rst_n.value = 0 # low to reset
    await ClockCycles(dut.clk,10)
    dut.rst_n.value = 1 # take out of reset, inverse high

    dut.ena.value = 1 # enable the design

    # Test 1: 5 cycles of high P
    dut.ui_in.value = my_high_Tuple # 151
    await ClockCycles(dut.clk,5)

    # Test 2: 5 cycles of low P
    dut.ui_in.value = my_low_Tuple # 147
    await ClockCycles(dut.clk,5)

    # Test 3: 4 cycles of high p & 1 cycle of low p
    dut.ui_in.value = my_high_Tuple # 151
    await ClockCycles(dut.clk,4)
    dut.ui_in.value = my_low_Tuple # 147
    await ClockCycles(dut.clk,1)




    # # Test 2: 1 extra cycle of high p (diff x,y,t value)
    # dut.ui_in.value = my_high_Tuple_new # 199
    # await ClockCycles(dut.clk,1)

    # #Test 3: 5 cycles of low p
    # dut.ui_in.value = my_low_Tuple_1 # 147
    # await ClockCycles(dut.clk,5)

    # # Test 4: 1 extra cycle of low p (diff x,y,t value)
    # dut.ui_in.value = my_low_Tuple_2 # 159
    # await ClockCycles(dut.clk,1)
    
    # wait for a while and run for 100 cycles
    for _ in range(50):
        await RisingEdge(dut.clk)

    dut._log.info("Finished Sim")

 