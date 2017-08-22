use Documents;

enum KernelType {LINEAR, POLYNOMIAL, GAUSSIAN, LAPLACIAN};
use KernelType;

// TODO
class Kernel {

  proc calcKernel(a: Sample, b: Sample): real {
    select this.kernelType {
      when LINEAR {
        return innerProduct(a, b) / sqrt(a.twoNormSq * b.twoNormSq);
      }
      when POLYNOMIAL {
        halt('KernelType not supported');
      }
      when GAUSSIAN {
        halt('KernelType not supported');
      }
      when LAPLACIAN {
        halt('KernelType not supported');
      }
      otherwise {
        halt('KernelType not supported');
      }
    }
  }

  proc calcKernelWithLabel(a: Sample, b: Sample) {
    var result = calcKernel(a, b);
    if a.classLabel != b.classLabel then result *= -1.0;
    return result;
  }

  proc innerProduct(a: Sample, b: Sample) {
    var norm: real;

    // TODO: Refactor as iterator:
    // for (it1, it2) in zip(a.features, b.features) {
    // }

    var aIdx = 1,
        bIdx = 1;

    while aIdx != a.features.domain.last && bIdx != b.features.domain.last {
      const af = a.features[aIdx],
            bf = b.features[bIdx];
      if af.id == bf.id {
        norm += af.weight * bf.weight;
        aIdx += 1;
        bIdx += 1;
      } else if af.id < bf.id {
        aIdx += 1;
      } else {
        bIdx += 1;
      }
    }
    return norm;
  }

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
