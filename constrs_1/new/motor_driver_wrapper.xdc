set_property MARK_DEBUG true [get_nets motor_driver_i/BLDC_controller_0/U0/U0/PWM_signal]

set_property MARK_DEBUG true [get_nets PWM_signal_OBUF]







create_debug_core u_ila_0 ila
set_property ALL_PROBE_SAME_MU true [get_debug_cores u_ila_0]
set_property ALL_PROBE_SAME_MU_CNT 1 [get_debug_cores u_ila_0]
set_property C_ADV_TRIGGER false [get_debug_cores u_ila_0]
set_property C_DATA_DEPTH 4096 [get_debug_cores u_ila_0]
set_property C_EN_STRG_QUAL false [get_debug_cores u_ila_0]
set_property C_INPUT_PIPE_STAGES 0 [get_debug_cores u_ila_0]
set_property C_TRIGIN_EN false [get_debug_cores u_ila_0]
set_property C_TRIGOUT_EN false [get_debug_cores u_ila_0]
set_property port_width 1 [get_debug_ports u_ila_0/clk]
connect_debug_port u_ila_0/clk [get_nets [list motor_driver_i/clk_wiz_0/inst/clk_out1]]
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe0]
set_property port_width 16 [get_debug_ports u_ila_0/probe0]
connect_debug_port u_ila_0/probe0 [get_nets [list {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[0]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[1]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[2]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[3]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[4]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[5]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[6]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[7]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[8]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[9]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[10]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[11]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[12]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[13]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[14]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/reg_RX[15]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe1]
set_property port_width 2 [get_debug_ports u_ila_0/probe1]
connect_debug_port u_ila_0/probe1 [get_nets [list {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/current_state_0[0]} {motor_driver_i/spi_handler_0/U0/U1_Rx_SPI/current_state_0[1]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe2]
set_property port_width 3 [get_debug_ports u_ila_0/probe2]
connect_debug_port u_ila_0/probe2 [get_nets [list {motor_driver_i/BLDC_controller_0_EN_LM[0]} {motor_driver_i/BLDC_controller_0_EN_LM[1]} {motor_driver_i/BLDC_controller_0_EN_LM[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe3]
set_property port_width 3 [get_debug_ports u_ila_0/probe3]
connect_debug_port u_ila_0/probe3 [get_nets [list {motor_driver_i/BLDC_controller_0_IN_LM[0]} {motor_driver_i/BLDC_controller_0_IN_LM[1]} {motor_driver_i/BLDC_controller_0_IN_LM[2]}]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe4]
set_property port_width 1 [get_debug_ports u_ila_0/probe4]
connect_debug_port u_ila_0/probe4 [get_nets [list motor_driver_i/MOSI_0_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe5]
set_property port_width 1 [get_debug_ports u_ila_0/probe5]
connect_debug_port u_ila_0/probe5 [get_nets [list motor_driver_i/sclk_0_1]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe6]
set_property port_width 1 [get_debug_ports u_ila_0/probe6]
connect_debug_port u_ila_0/probe6 [get_nets [list motor_driver_i/spi_handler_0_m1_dir]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe7]
set_property port_width 1 [get_debug_ports u_ila_0/probe7]
connect_debug_port u_ila_0/probe7 [get_nets [list motor_driver_i/spi_handler_0_m1_start]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe8]
set_property port_width 1 [get_debug_ports u_ila_0/probe8]
connect_debug_port u_ila_0/probe8 [get_nets [list motor_driver_i/spi_handler_0_MISO]]
create_debug_port u_ila_0 probe
set_property PROBE_TYPE DATA_AND_TRIGGER [get_debug_ports u_ila_0/probe9]
set_property port_width 1 [get_debug_ports u_ila_0/probe9]
connect_debug_port u_ila_0/probe9 [get_nets [list motor_driver_i/ssel_0_1]]
set_property C_CLK_INPUT_FREQ_HZ 300000000 [get_debug_cores dbg_hub]
set_property C_ENABLE_CLK_DIVIDER false [get_debug_cores dbg_hub]
set_property C_USER_SCAN_CHAIN 1 [get_debug_cores dbg_hub]
connect_debug_port dbg_hub/clk [get_nets u_ila_0_clk_out1]
