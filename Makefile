blinky:
	mkdir -p output
	yosys -q -p "synth_ice40 -top blinky -json output/blinky.json" \
		rtl/blinky.v
	nextpnr-ice40 -q --hx8k --package ct256 --pcf kuchen.pcf \
		--asc output/blinky.txt --json output/blinky.json \
		--pcf-allow-unconstrained
	icebox_explain output/blinky.txt > output/blinky.ex
	icetime -d hx4k -c 50 -mtr output/blinky.rpt output/blinky.txt
	icepack output/blinky.txt output/blinky.bin

clean:
	rm -f output/*

.PHONY: blinky clean
