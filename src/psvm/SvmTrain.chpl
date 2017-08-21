use Help;
use Time;

use Documents;
use Kernel;
use Model;
use Opt;

// Enum
use KernelType;


             // TODO: Chapelify these names!
             /* Training data file */
config const dataFile: string,
             /* When to stop ICF. Should be in (0, 1] */
             factThreshold = 1.0000000000000001e-05,
             /* Ratio of rank to be used in ICF. Should be in (0, 1] */
             rankRatio = 1.0,
             /* Type of kernel function. Available types are: 1: Linear  1: Polynomial  2: Gaussian  3: Laplacian */
             kernelType: KernelType = GAUSSIAN,
             /* Gamma value in Gaussian and Laplacian kernel */
             gamma = 1.0,
             /* Degree in Polynomial kernel */
             polyDegree = 3,
             /* Coefficient in Polynomial kernel */
             polyCoef = 1.0,
             /* Constant in Polynomial kernel */
             polyConst = 1.0,
             /* When to consider a variable as zero */
             zeroThreshold = 1.0000000000000001e-09,
             /* When to consider a variable as a support vector */
             svThreshold = 0.0001,
             /* Hyper-parameter C in SVM model */
             hyperParm = 1.0,
             /* Set hyper-parameter for positive class to be positiveWeight * C */
             positiveWeight = 1.0,
             /* Set hyper-parameter for negative class to be negativeWeight * C */
             negativeWeight = 1.0,
             /* Necessary convergance conditions: primal residual < feasibleThreshold and dual residual < dual residual */
             feasibleThreshold = 0.001,
             /* Necessary convergance condition: surrogate gap < surrogateGapThreshold */
             surrogateGapThreshold = 0.001,
             /* Maximum iterations for the IPM method */
             maxIteration = 200,
             /* Increasing factor mu */
             muFactor = 10.0,
             /* Where to save the resulting model */
             modelPath = '.',
             /* Number of seconds between two save operations */
             saveInterval = 600.0,
            /* Whether to enable failsafe feature. */
             failsafe = false,
            /* Whether to show additional information */
             verbose = false;

proc main() {
  var kernel = new Kernel();
  var trainer = new SvmTrainer();
  var model = new Model();
  var doc = new Document();
  var ipmParameter: PrimalDualIPMParameter;

  var t: Timer();

  // Verify options
  if dataFile.length == 0 {
    Usage();
    exit(3);
  }

  // TODO: Constructor?
  kernel.kernelType = kernelType;
  kernel.rbfGamma = gamma;
  kernel.polyDegree = polyDegree;
  kernel.coefLin = polyCoef;
  kernel.coefConst = polyConst;

  // TODO: Constructor?
  ipmParameter.threshold = factThreshold;
  ipmParameter.rankRatio = rankRatio;
  ipmParameter.epsilonX = zeroThreshold;
  ipmParameter.epsilonSv = svThreshold;
  ipmParameter.hyperParm = hyperParm;
  ipmParameter.modelPath = modelPath;
  ipmParameter.weightPositive = positiveWeight;
  ipmParameter.weightNegative = negativeWeight;
  ipmParameter.feasThresh = feasibleThreshold;
  ipmParameter.sgap = surrogateGapThreshold;
  ipmParameter.maxIter = maxIteration;
  ipmParameter.muFactor = muFactor;
  ipmParameter.verb = verbose;
  ipmParameter.saveInterval = saveInterval;
  ipmParameter.tradeoff = 0;

  // Read training samples
  doc.read(dataFile);

  writeln('Total: ', doc.samples.size,
          '  Positive: ', doc.numPos,
          '  Negative: ', doc.numNeg);

  trainer.trainModel(doc, kernel, ipmParameter, model, failsafe);

  // TODO:
  // model.setKernel(kernel);
  // model.computeB(ipmParameter);
  // model.save(ipmParameter.modelPath, "model");
}

proc Usage() {
      printUsage();
      writeln();
      writeln("SvmTrain: ");
      writeln("  SvmTrain --dataFile=<dataFile>");
      writeln();
}


// TODO
/*
  Trains a document with given kernel and IPM parameters.
  The result is a model structure including kernel and support vectors.
 */
class SvmTrainer {
  // TODO
  proc trainModel(doc: Document, kernel: Kernel,
                  p: PrimalDualIPMParameter , model: Model, failSafe: bool) {
    // TODO: Remove failsafe?

    // 2D array?
    //var icfResult = ?

    // TODO:
    // Incomplete Cholesky Factorization



  }

  // TODO
  /* Format the training time info of current processor to a string. */
  proc PrintTimeInfo() { }

  // TODO
  /*
    Save time statistic information into a file.
    For processor #, it is stored in "path/file_name.#"
   */
  proc SaveTimeInfo(path: string, fileName: string) { }
}
