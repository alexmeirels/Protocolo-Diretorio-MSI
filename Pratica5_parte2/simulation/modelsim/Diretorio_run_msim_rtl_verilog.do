transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/Processador1.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/Diretorio.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/Memoria.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/Lista.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/CodigoTeste.v}
vlog -vlog01compat -work work +incdir+C:/Users/Alexm/Desktop/Pratica5_parte2 {C:/Users/Alexm/Desktop/Pratica5_parte2/Processador2.v}
