enum KernelType {LINEAR, POLYNOMIAL, GAUSSIAN, LAPLACIAN};

class Kernel {

  // TODO
  // methods..

  var kernelType: KernelType;

  /* The gamma parameter for the Gaussian and Laplacian kernel.
     In Gaussian kernel
        k(a, b) = exp{-rbf_gamma_ * ||a - b||^2}
     In Laplacian kernel
        k(a, b) = exp{-rbf_gamma_ * |a - b|} */
  var rbfGamma: real;

  /* The three parameters of the polynomial kernel, in which:
        k(a, b) = (coef_lin * a.b + coef_const_) ^ poly_degree_ */
  var coefLin, coefConst: real;
  var polyDegree: int;

}
