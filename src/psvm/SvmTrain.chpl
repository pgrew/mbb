use Help;
use Time;

use Documents;
use Kernel;
use Model;
use Opt;

// Enum
use KernelType;


             /* Training data file */
config const dataFile: string,
             /* When to stop ICF. Should be in (0, 1] */
             factThreshold = 1.0000000000000001e-05,
             /* Ratio of rank to be used in ICF. Should be in (0, 1] */
             rankRatio = 1.0,
             /* Type of kernel function. Available types are: 1: Linear  1: Polynomial  2: Gaussian  3: Laplacian */
             kernelType: KernelType = LINEAR, // TODO: GAUSSIAN Default
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

    // 2D array (rows x rows?)
    // TODO: Distribute
    var icfResult: [1..doc.numTotal, 1..doc.numTotal] real;

    ICF(doc, kernel, p.threshold, icfResult);

    //MatrixManipulation::ICF(doc, kernel, doc.GetGlobalNumberRows(),
    //                        rank, parameter.threshold, &icf_result);

    // TODO:
    // Incomplete Cholesky Factorization
    //ipm_solver = new PrimalDualIPM();
    //ipm_solver.Solve(p, icf_result, doc, model, failsafe);



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

// matrix_manipulation.cc

proc ICF(doc: Document, kernel: Kernel, threshold: real, icf: [?icfDom]) {

  var (rows, columns) = icfDom.shape;
  var pivot: [1..columns] int;
  var pivotSelected: [1..rows] bool;

  // diag1: the diagonal part of Q (the kernal matrix diagonal
  // diag2: the quadratic sum of a row of the ICF matrix
  var diag1: [1..rows] real,
      diag2: [1..rows] real;

  for i in 1..rows {
    diag1[i] = kernel.calcKernelWithLabel(doc.samples[i], doc.samples[i]);
  }
}
/*
  double* header_row = new double[columns];
  for (int column = 0; column < columns; column++) {
    // Get global trace
    double local_trace = 0;
    for (int i = 0; i < local_rows; i++) {
      // If pivot_selected[i] == true, diag1[i] - diag2[i] == 0,
      // summation is not needed.
      if (pivot_selected[i] == false) local_trace += diag1[i] - diag2[i];
    }
    double global_trace = DBL_MAX;
    mpi->AllReduce(&local_trace, &global_trace, 1, MPI_DOUBLE, MPI_SUM,
                  MPI_COMM_WORLD);

    // Test stop criterion
    if (global_trace < threshold) {
      icf->SetNumCols(column);
      if (parallel_id == 0) {
        cout << "reset columns from " << columns
                  << " to " << icf->GetNumCols();
      }
      break;
    }

    // Find local pivot
    Pivot local_pivot;
    local_pivot.pivot_value = -DBL_MAX;
    local_pivot.pivot_index = -1;
    for (int i = 0; i < local_rows; ++i) {
      double tmp = diag1[i] - diag2[i];
      if (pivot_selected[i] == false && tmp > local_pivot.pivot_value) {
        local_pivot.pivot_index = mpi->ComputeLocalToGlobal(i, parallel_id);
        local_pivot.pivot_value = tmp;
      }
    }

    // Get global pivot (MPI_Reduce is used)
    Pivot global_pivot;
    mpi->AllReduce(&local_pivot, &global_pivot, 1,
                         MPI_DOUBLE_INT, MPI_MAXLOC, MPI_COMM_WORLD);

    // Update pivot vector
    pivot[column] = global_pivot.pivot_index;

    // Broadcast pivot sample
    Sample *pivot_sample = NULL;
    BroadcastPivotSample(doc, global_pivot.pivot_index, &pivot_sample);

    // Broadcast the row corresponds to pivot.
    int header_row_size = column + 1;
    int localRowID = mpi->ComputeGlobalToLocal(global_pivot.pivot_index,
                                                      parallel_id);
    if (localRowID != -1) {
      icf->Set(localRowID, column, sqrt(global_pivot.pivot_value));
      for (int j = 0; j < header_row_size; ++j) {
        header_row[j] = icf->Get(localRowID, j);
      }

      mpi->Bcast(header_row, header_row_size,
                 MPI_DOUBLE, parallel_id, MPI_COMM_WORLD);

      // Update pivot flag vector
      pivot_selected[localRowID] = true;
    } else {
      int root = global_pivot.pivot_index % pnum;
      mpi->Bcast(header_row, header_row_size,
                 MPI_DOUBLE, root, MPI_COMM_WORLD);
    }

    // Calculate the column'th column
    // Note: 1. This order can improve numerical accuracy.
    //       2. Cache is used, will be faster too.
    for (int i = 0; i < local_rows; ++i) {
      if (pivot_selected[i] == false) {
        icf->Set(i, column, 0);
      }
    }
    for (int k = 0; k < column; ++k) {
      for (int i = 0; i < local_rows; ++i) {
        if (pivot_selected[i] == false) {
          icf->Set(i, column, icf->Get(i, column) -
                          icf->Get(i, k) * header_row[k]);
        }
      }
    }
    for (int i = 0; i < local_rows; ++i) {
      if (pivot_selected[i] == false) {
        icf->Set(i, column, icf->Get(i, column) +
          kernel.CalcKernelWithLabel(*doc.GetLocalSample(i), *pivot_sample));
      }
    }
    for (int i = 0; i < local_rows; ++i) {
      if (pivot_selected[i] == false) {
        icf->Set(i, column, icf->Get(i, column)/header_row[column]);
      }
    }

    // Free pivot sample
    FreePivotSample(pivot_sample, global_pivot.pivot_index);

    // Update diagonal
    for (int i = 0; i < local_rows; ++i) {
      diag2[i] += icf->Get(i, column) * icf->Get(i, column);
    }
  }
*/
