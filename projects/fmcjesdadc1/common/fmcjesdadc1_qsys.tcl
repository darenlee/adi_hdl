
# ad9250-xcvr

add_instance avl_ad9250_xcvr avl_adxcvr 1.0
set_instance_parameter_value avl_ad9250_xcvr {ID} {1}
set_instance_parameter_value avl_ad9250_xcvr {TX_OR_RX_N} {0}
set_instance_parameter_value avl_ad9250_xcvr {PCS_CONFIG} {JESD_PCS_CFG1}
set_instance_parameter_value avl_ad9250_xcvr {LANE_RATE} {5000.0}
set_instance_parameter_value avl_ad9250_xcvr {PLLCLK_FREQUENCY} {2500.0}
set_instance_parameter_value avl_ad9250_xcvr {REFCLK_FREQUENCY} {250.0}
set_instance_parameter_value avl_ad9250_xcvr {CORECLK_FREQUENCY} {125.0}
set_instance_parameter_value avl_ad9250_xcvr {NUM_OF_LANES} {4}
set_instance_parameter_value avl_ad9250_xcvr {NUM_OF_CONVS} {4}
set_instance_parameter_value avl_ad9250_xcvr {FRM_BCNT} {4}
set_instance_parameter_value avl_ad9250_xcvr {FRM_SCNT} {1}
set_instance_parameter_value avl_ad9250_xcvr {MF_FCNT} {32}
set_instance_parameter_value avl_ad9250_xcvr {HD} {0}

add_connection sys_clk.clk avl_ad9250_xcvr.sys_clk
add_connection sys_clk.clk_reset avl_ad9250_xcvr.sys_resetn
add_interface rx_ref_clk clock sink
set_interface_property rx_ref_clk EXPORT_OF avl_ad9250_xcvr.ref_clk
add_interface rx_data_0 conduit end
set_interface_property rx_data_0 EXPORT_OF avl_ad9250_xcvr.rx_data_0
add_interface rx_data_1 conduit end
set_interface_property rx_data_1 EXPORT_OF avl_ad9250_xcvr.rx_data_1
add_interface rx_data_2 conduit end
set_interface_property rx_data_2 EXPORT_OF avl_ad9250_xcvr.rx_data_2
add_interface rx_data_3 conduit end
set_interface_property rx_data_3 EXPORT_OF avl_ad9250_xcvr.rx_data_3
add_interface rx_sysref conduit end
set_interface_property rx_sysref EXPORT_OF avl_ad9250_xcvr.sysref
add_interface rx_sync conduit end
set_interface_property rx_sync EXPORT_OF avl_ad9250_xcvr.sync

# ad9250-xcvr

add_instance axi_ad9250_xcvr axi_adxcvr 1.0
set_instance_parameter_value axi_ad9250_xcvr {ID} {1}
set_instance_parameter_value axi_ad9250_xcvr {TX_OR_RX_N} {0}
set_instance_parameter_value axi_ad9250_xcvr {NUM_OF_LANES} {4}

add_connection sys_clk.clk axi_ad9250_xcvr.s_axi_clock
add_connection sys_clk.clk_reset axi_ad9250_xcvr.s_axi_reset
add_connection axi_ad9250_xcvr.if_up_rst avl_ad9250_xcvr.rst
add_connection avl_ad9250_xcvr.ready axi_ad9250_xcvr.ready
add_connection axi_ad9250_xcvr.core_pll_locked avl_ad9250_xcvr.core_pll_locked

# ad9250

add_instance axi_ad9250_core_0 axi_ad9250 1.0

add_connection avl_ad9250_xcvr.core_clk axi_ad9250_core_0.if_rx_clk
add_connection avl_ad9250_xcvr.ip_sof axi_ad9250_core_0.if_rx_sof
add_connection avl_ad9250_xcvr.ip_data axi_ad9250_core_0.if_rx_data
add_connection sys_clk.clk_reset axi_ad9250_core_0.s_axi_reset
add_connection sys_clk.clk axi_ad9250_core_0.s_axi_clock

add_instance axi_ad9250_core_1 axi_ad9250 1.0

add_connection avl_ad9250_xcvr.core_clk axi_ad9250_core_1.if_rx_clk
add_connection avl_ad9250_xcvr.ip_sof axi_ad9250_core_1.if_rx_sof
add_connection avl_ad9250_xcvr.ip_data axi_ad9250_core_1.if_rx_data
add_connection sys_clk.clk_reset axi_ad9250_core_1.s_axi_reset
add_connection sys_clk.clk axi_ad9250_core_1.s_axi_clock

# ad9250-pack

add_instance util_ad9250_cpack util_cpack 1.0
set_instance_parameter_value util_ad9250_cpack {CHANNEL_DATA_WIDTH} {32}
set_instance_parameter_value util_ad9250_cpack {NUM_OF_CHANNELS} {4}

add_connection sys_clk.clk_reset util_ad9250_cpack.if_adc_rst
add_connection sys_dma_clk.clk_reset util_ad9250_cpack.if_adc_rst
add_connection avl_ad9250_xcvr.core_clk util_ad9250_cpack.if_adc_clk
add_connection axi_ad9250_core_0.adc_ch_0 util_ad9250_cpack.adc_ch_0
add_connection axi_ad9250_core_0.adc_ch_1 util_ad9250_cpack.adc_ch_1
add_connection axi_ad9250_core_1.adc_ch_0 util_ad9250_cpack.adc_ch_2
add_connection axi_ad9250_core_1.adc_ch_1 util_ad9250_cpack.adc_ch_3

# ad9250-fifo

add_instance ad9250_adcfifo util_adcfifo 1.0
set_instance_parameter_value ad9250_adcfifo {ADC_DATA_WIDTH} {128}
set_instance_parameter_value ad9250_adcfifo {DMA_DATA_WIDTH} {128}
set_instance_parameter_value ad9250_adcfifo {DMA_ADDRESS_WIDTH} {16}

add_connection sys_clk.clk_reset ad9250_adcfifo.if_adc_rst
add_connection sys_dma_clk.clk_reset ad9250_adcfifo.if_adc_rst
add_connection avl_ad9250_xcvr.core_clk ad9250_adcfifo.if_adc_clk
add_connection util_ad9250_cpack.if_adc_valid ad9250_adcfifo.if_adc_wr
add_connection util_ad9250_cpack.if_adc_data ad9250_adcfifo.if_adc_wdata
add_connection sys_dma_clk.clk ad9250_adcfifo.if_dma_clk

# ad9250-dma

add_instance axi_ad9250_dma axi_dmac 1.0
set_instance_parameter_value axi_ad9250_dma {DMA_DATA_WIDTH_SRC} {128}
set_instance_parameter_value axi_ad9250_dma {DMA_DATA_WIDTH_DEST} {128}
set_instance_parameter_value axi_ad9250_dma {DMA_LENGTH_WIDTH} {24}
set_instance_parameter_value axi_ad9250_dma {DMA_2D_TRANSFER} {0}
set_instance_parameter_value axi_ad9250_dma {SYNC_TRANSFER_START} {1}
set_instance_parameter_value axi_ad9250_dma {CYCLIC} {0}
set_instance_parameter_value axi_ad9250_dma {DMA_TYPE_DEST} {0}
set_instance_parameter_value axi_ad9250_dma {DMA_TYPE_SRC} {1}

add_connection sys_dma_clk.clk axi_ad9250_dma.if_s_axis_aclk
add_connection ad9250_adcfifo.if_dma_wr axi_ad9250_dma.if_s_axis_valid
add_connection ad9250_adcfifo.if_dma_wdata axi_ad9250_dma.if_s_axis_data
add_connection ad9250_adcfifo.if_dma_wready axi_ad9250_dma.if_s_axis_ready
add_connection ad9250_adcfifo.if_dma_xfer_req axi_ad9250_dma.if_s_axis_xfer_req
add_connection ad9250_adcfifo.if_adc_wovf axi_ad9250_core_0.if_adc_dovf
add_connection sys_clk.clk_reset axi_ad9250_dma.s_axi_reset
add_connection sys_clk.clk axi_ad9250_dma.s_axi_clock
add_connection sys_dma_clk.clk_reset axi_ad9250_dma.m_dest_axi_reset
add_connection sys_dma_clk.clk axi_ad9250_dma.m_dest_axi_clock

# addresses

ad_cpu_interconnect 0x00010000 avl_ad9250_xcvr.phy_reconfig_0
ad_cpu_interconnect 0x00011000 avl_ad9250_xcvr.phy_reconfig_1
ad_cpu_interconnect 0x00012000 avl_ad9250_xcvr.phy_reconfig_2
ad_cpu_interconnect 0x00013000 avl_ad9250_xcvr.phy_reconfig_3
ad_cpu_interconnect 0x00018000 avl_ad9250_xcvr.core_pll_reconfig
ad_cpu_interconnect 0x00019000 avl_ad9250_xcvr.ip_reconfig
ad_cpu_interconnect 0x00020000 axi_ad9250_xcvr.s_axi
ad_cpu_interconnect 0x00050000 axi_ad9250_core_0.s_axi
ad_cpu_interconnect 0x00060000 axi_ad9250_core_1.s_axi
ad_cpu_interconnect 0x00070000 axi_ad9250_dma.s_axi

# dma interconnects

ad_dma_interconnect axi_ad9250_dma.m_dest_axi

# interrupts

ad_cpu_interrupt 11 axi_ad9250_dma.interrupt_sender
