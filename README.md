- Visualizer of the complex plane with some infinite sums
- Coded in Java with Processing 4

- Controls:
  - click and drag: move the plane
  - up arrow/down arrow: zoom in and out
  - shift: move initial input for functions (displayed in red)
  - enter: hide red dot representing initial input for functions
  - spacebar: recenters plane and zoom
 
- Notes:
  - The blue dots represents a basic geometric series: `f(z) = 1 + z + z^2 + z^3 + ... + z^n` for complex input `z` and `n` iterations (ideally infinite)
      - when the sum converges, each step draws a pretty spiral!
  - The green dots are supposed to represent the Zeta Function in its most simple representation:
    >`zeta(z) = z^0 + z^-1 + z^-2 + ...`
    - however this is broken for the reason below
  - Currently, numbers raised to complex powers are bugged because the math is a bit more complicated than I realized
    - I may return to fix this in the future
  - However, numbers raised to imaginary powers do work as intended
  - This code takes advantage of the exponential form and rectangular form of complex numbers most.
