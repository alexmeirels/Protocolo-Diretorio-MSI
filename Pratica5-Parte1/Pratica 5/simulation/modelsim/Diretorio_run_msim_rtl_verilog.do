transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pessoal/facul/5\ PerÃ­odo/Lab\ Aoc\ II/Pratica5-Parte1/Pratica\ 5 {C:/Users/Alexm/Desktop/Pessoal/facul/5 Período/Lab Aoc II/Pratica5-Parte1/Pratica 5/Diretorio.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pessoal/facul/5\ PerÃ­odo/Lab\ Aoc\ II/Pratica5-Parte1/Pratica\ 5 {C:/Users/Alexm/Desktop/Pessoal/facul/5 Período/Lab Aoc II/Pratica5-Parte1/Pratica 5/testbench.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pessoal/facul/5\ PerÃ­odo/Lab\ Aoc\ II/Pratica5-Parte1/Pratica\ 5 {C:/Users/Alexm/Desktop/Pessoal/facul/5 Período/Lab Aoc II/Pratica5-Parte1/Pratica 5/maquinaDeEstado.v}

