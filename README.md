# BondAid: Correct Bond Population Correlation Functions from MD Simulations with Cubic Periodic Boundary Conditions

This repository contains a collection of input files and source code as described in the paper "An Exact A Posteriori Correction for Hydrogen Bond Population Correlation Functions and Other Reversible Geminate Recombinations Obtained from Simulations with Periodic Boundary Conditions. Liquid Water as a Test Case". The paper has been published in [J. Chem. Phys. 154, 214501 (2021)](https://www.doi.org/10.1063/5.0053445).


The repository is structured as follows:

- [example/](example/) contains examples for performing the "BNP"-correction of hydrogen bond population time correlation functions (HBPCFs) computed via the Luzar-Chandler approach. The HBPCFs were obtained from MD simulations of a system of 1024 TIP4P/2005 water molecules at $T=273 \mbox{K}$ and $T=298 \mbox{K}$ taken from [J. Chem. Phys. 154, 214501 (2021)](https://www.doi.org/10.1063/5.0053445) and are stored in files `ct_luzar_chandler_1024W_273K.dat` and `ct_luzar_chandler_1024W_298K.dat`. The shell-skript `mk_bnp.sh` is performing the correction using donor-acceptor inter-diffusion coefficients $D'=2\times D_\mathrm{self}$, box-sizes $b$ , and average hydrogen bond populations $\langle h\rangle=C_\infty$  given in Table I of [J. Chem. Phys. 154, 214501 (2021)](https://www.doi.org/10.1063/5.0053445).

- [src/](src/) contains the Perl source code. `correct_bnp.pl` is a Perl script that performs the long-time correction on a hydrogen bond population time correlation function via the Luzar-Chandler approach.

## Background

The time-dependent fluctuations of bond populations such as
hydrogen bond (HB) populations are 
described by a population correlation function using
the Luzar-Chandler notation
```math
C(t) \approx  \frac{\left\langle h(0)h(t) \right\rangle }
          {\left\langle h \right\rangle}
```
with the HB population function 
```math
h(t) = 
\begin{cases}
1, \text{if HB exists}\\
0, \text{if no HB exists}
\end{cases}
```
which is calculated for every donor-acceptor pair separately. 
The brackets denote averaging over all donor-acceptor pairs 
of a specific HB  type and all times $t=0$. 
The (sometimes labeled as "intermittent") HB population correlation function $C(t)$ 
describes the fraction of HBs still intact at time $t$, 
provided it was intact at $t_{0}=0$. It is not required that the bond remains intact over the whole time interval  $t-t_{0}$. 
When applied to "wrapped" trajectory data (i.e. trajectory data folded into the 
central unit cell, while computing inter-molecular distances using the 
"minimum image" convention),
the presence of periodic boundary conditions perturbs the 
long-time limiting behaviour of $C(t)$, leading to 
a non-zero plateau value at long times
```math
\lim_{t\rightarrow\infty}C(t) = \langle h\rangle
```
To appropriately correct the long-time limiting behavior and to
restore the 
behavior observed 
in absence of periodic boundary conditions, we have derived a time-dependent correction
using
```math
\frac{\left\langle h(0)h(t) \right\rangle}
          {\left\langle h \right\rangle}-\left\langle h \right\rangle s(t)\;,
```
where $s(t)$ represents a time-dependent ''switching'' function
```math
s(t)=
\frac{b^3}{q(t)}
\left\{1+
2 \sum_{n=1}^\infty 
\exp\left[
-\frac{b^2 n^2}{4 D't} 
\right]
\right\}^3 -\frac{b^3}{q(t)}\;,
```
with $q(t)=(4\pi D't)^{3/2}$,
where $D'=D_\text{donor}+D_\text{acceptor}$ is the
donor-acceptor inter-diffusion coefficient and $b$ the box-length of the
cubic MD cell. 

## Usage of the "correct_bnp" Program

`correct_bnp.pl` is a Perl script that transforms a bond population time correlation function computed 
via the Luzar-Chandler approach, which is stored in a ASCII file (here: `ct_lc.dat`) containing two colums: The first column
contains the time $t$ (here given in units of ps or $10^{-12}\mbox{s}$) and the second colum contains the
correlation function $C(t)$. `correct_bnp.pl` reads data from `<STDIN>` and writes data to `<STDOUT>`.

**Command Line Options:**
-   `-b` $b$: Box length of the cubic MD cell
-   `-D` $D'$: Donor-acceptor inter-diffusion coefficient $D'=D_\text{donor}+D_\text{acceptor}$
-   `-h` $\langle h\rangle$: Average hydrogen bond population $\langle h\rangle$ 

Note: the units of the specified quantities have to fullfill the condition
$D't/b^2=u$, where $u$ is a dimensionless quantity. Suppose the $t$-data of $C(t)$ in
file `ct_lc.dat`
is given in ps and the box-length $b$ is given in nm, then the diffusion coefficient $D'$ has to be specified in $\text{nm}^2/\text{ps}$. 

**Usage:**

`cat ct_lc.dat | ./correct_bnp.pl -D 0.0041 -b 3.142 -h 0.00093 > ct_bnp.dat`

For further information, please contact [the authors](mailto:dietmar.paschek@uni-rostock.de).

