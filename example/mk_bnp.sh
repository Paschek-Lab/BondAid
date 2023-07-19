

cat ct_luzar_chandler_1024W_298K.dat | ./correct_bnp.pl -D 0.00414 -b 3.14194 -h 0.00093 > ct_bnp_298K.dat 
cat ct_luzar_chandler_1024W_273K.dat | ./correct_bnp.pl -D 0.00202 -b 3.12924 -h 0.00095 > ct_bnp_273K.dat 
