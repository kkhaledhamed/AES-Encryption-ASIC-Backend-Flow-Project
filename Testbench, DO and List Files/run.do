vlib work
vlog AES_Encryption.v MUX2_1.v mux.v Sub_Bytes.v Shift_Rows.v Mix_Column.v Key.v Round_reg.v Sub_Key.v DFF_128.v AES_Encryption_tb.v

# Enable SAIF-based power analysis
vsim -voptargs=+acc work.AES_Encryption_tb -l AES.log

# Add signals to waveform viewer (optional)
add wave *

# Run the full simulation
run -all

