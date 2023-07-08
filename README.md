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
