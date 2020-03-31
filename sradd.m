function f = sradd(a, b, R)
% SRADD   Stochastically rounded addition.
%    F = SRADD(A,B,R) computes F by rounding A+B stochastically. The
%    parameter R must be a real scalar between 0 and 1, but the input arguments
%    are not checked for performance reasons.
  round_mode = feature('setround', 0.5);
  [sum, error] = twosum(a, b);
  feature('setround', 0);
  Es = floor(log2(abs(a+b)));
  P = sign(error).*R.*2.^(Es-52);
  if (error >= 0)
    feature('setround', -Inf);
  else
    feature('setround', Inf);
  end
  f = (error+P)+sum;
  feature('setround', round_mode);
end