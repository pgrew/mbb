use Documents;

// TODO
/* Newton method for primal-dual interior point method for SVM optimization */
class PrimalDualIPM {
  // TODO: methods..
  /*
  Using Newton method to solve the optimization problem
    parameter: the options of interior point method
    h: ICF factorized matrix
    doc: data points
    model: store the optimization result
  */
  proc Solve(parameter: PrimalDualIPMParameter, h: [], doc: Document,
            model: Model, failsafe: bool) {

  }

  /* Compute $HH^T\alpha$, which is part of $z$, $\alpha$ is primal variable */
  proc ComputePartialZ(icf: [], x: [] real, to: real, localNumRows: int,
                      z: [] real) {

  }

  /*
  // Compute surrogate gap
  double ComputeSurrogateGap(double c_pos,
                             double c_neg,
                             const double *label,
                             int local_num_rows,
                             const double *x,
                             const double *la,
                             const double *xi);

  // Compute direction of primal vairalbe $x$
  int ComputeDeltaX(const ParallelMatrix& icf,
                    const double *d,
                    const double *label,
                    const double dnu,
                    const LLMatrix& lra,
                    const double *z,
                    const int local_num_rows,
                    double *dx);

  // Compute direction of primal varialbe $\nu$
  int ComputeDeltaNu(const ParallelMatrix& icf,
                     const double *d,
                     const double *label,
                     const double *z,
                     const double *x,
                     const LLMatrix& lra,
                     const int local_num_rows,
                     double *dnu);

  // Solve a special form of linear equation using
  // Sherman-Morrison-Woodbury formula
  int LinearSolveViaICFCol(const ParallelMatrix& icf,
                           const double *d,
                           const double *b,
                           const LLMatrix& lra,
                           const int local_num_rows,
                           double *x);

  // Loads the values of alpha, xi, lambda and nu to resume from an interrupted
  // solving process.
  void LoadVariables(const PrimalDualIPMParameter& parameter,
                     int num_local_doc, int num_total_doc, int *step,
                     double *nu, double *x, double *la, double *xi);

  // Saves the values of alpha, xi, lambda and nu.
  void SaveVariables(const PrimalDualIPMParameter& parameter,
                     int num_local_doc, int num_total_doc, int step,
                     double nu, double *x, double *la, double *xi);
   */
};


/* The parameters for Interior Point Method */
record PrimalDualIPMParameter {
  // ICF factorization resulted $p/n$
  var rankRatio: real,
      // ICF stop iteration number
      iteration: int,
      // $C$ in optimiation
      hyperParm: real,
      // threshold for primaliable to be deemed as zero
      epsilonX: real,
      // threshold for support vector
      epsilonSv: real,
      // feasibility threshold
      feasThresh: real,
      // stop condition for surrogate gap
      sgap: real,
      // maximum iterations of IPM
      maxIter: int,
      // increasing factor
      muFactor: real,
      // constant to be substracted from diagonal
      tradeoff: real,
      threshold: real,
      // the weight of POSITIVE sample in $C$ of optimization
      weightPositive: real,
      // the weight of NEGATIVE sample in $C$ of optimization
      weightNegative: real,
      // verbose output for diagnostic
      verb: int,
      // path to store model result
      modelPath: string,
      // number of seconds between two save operations
      saveInterval: real;
}
