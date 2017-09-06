use Documents;
use Kernel;

class Model {
  /*
     kernel stores kernel type, kernel parameter information,
     and calculates kernel function accordingly.
   */
  var kernel: Kernel; // TODO
  /* The number of support vectors in all. */
  var numTotalSV: int,
  /* The number of chunks/processors. */
      numChunks: int;
  /* support_vector stores support vector information.
     In training phase, it stores the pointers to the suppor vectors,
     In testing phase, it stores the support vectors read from model files. */
  var supportVector: SupportVector; // TODO

  // TODO
  /* Uses alpha values to decide which samples are support vectors and stores
     their information. */
  proc checkSupportVector(alpha, doc, ipmParameter) { }

  // TODO
  /* Saves the model to the directory specified by str_directory. */
  proc save(strDirectory, modelName) { }
  proc saveHeader(strDirectory, modelName) { }
  proc saveChunks(strDirectory, modelName) { }

  // TODO
  /* Loads the model from the directory specified by str_directory. */
  proc load(strDirectory, modelName) { }
  proc loadHeader(strDirectory, modelName) { }
  proc loadChunks(strDirectory, modelName) { }

  // TODO
  /* Computes the b value of the SVM's classification function. */
  proc computeB(ipmParameter) { }
}

record SupportVector {
  /* number of support vectors */
  var num_sv: int,
  /* number of support vectors at boundary */
      num_bsv: int;
  /* b value of classification function in SVM model */
  var b: real;

  var alphaDom: domain(1);
  /* the alpha values of the support vectors */
  var alpha: [alphaDom] real;

  var dataDom: domain(1);
  /* the pointers to support vectors, used only in training phase. */
  var data: [dataDom] Sample;

  /* support vector samples */
  var dataTest: [alphaDom] Sample;
}
