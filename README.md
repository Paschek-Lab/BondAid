# BondAid: Correct Bond Population Correlation Functions from MD Simulations with Periodic Boundary Conditions

This repository contains a collection of input files and source code as described in the paper "An Exact A Posteriori Correction for Hydrogen Bond Population Correlation Functions and Other Reversible Geminate Recombinations Obtained from Simulations with Periodic Boundary Conditions. Liquid Water as a Test Case" The paper has been published in [J. Chem. Phys. 154, 214501 (2021)](https://www.doi.org/10.1063/5.0053445).

## Background

The time-dependent fluctuations of the hydrogen bond (HB) population are 
described by the HB population correlation function using
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
The "intermittent" HB population correlation function $C(t)$ 
describes the fraction of HBs still intact at time $t$, 
provided it was intact at $t_{0}=0$, without the need for it 
to be intact over the whole time interval  $t-t_{0}$. 
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
where $s(t)$ represents a time-dependent ``switching'' function
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

`cat ct_lc.dat | ./correct_bnp.pl -D 0.0041 -b 3.142 -h 0.00093 > ct_bnp.dat`


