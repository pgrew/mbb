use Time;
use Help;

use Model;

config const dataFile: string,
             batchSize: int = 10000,
             modelPath: string = '.',
             outputPath: string = '.';

proc main() {
  // TODO: port timer.cc to a timer class
  var t: Timer();

  if dataFile.length == 0 {
    Usage();
    exit(3);
  }

  // Begin timing
  t.start();

  // Load the SVM model and predict the samples
  var predictor = new SvmPredictor();
  predictor.readModel(modelPath);
  var result = predictor.predictDocument(dataFile,
                                         outputPath + '/PredictResult',
                                         batchSize);

  // Predict

  // End timing
  t.stop();

  // Save time info (if a 'save' flag is set?)

  // Clean up
  delete predictor;
}


proc Usage() {
      printUsage();
      writeln();
      writeln("SvmPredict: This program predicts the class labels of samples. Usage:");
      writeln("  SvmPredict --dataFile=<dataFile>");
      writeln("The predict result is saved in dataFile.predict.");
      writeln();
}

// TODO
proc printInfo(result: EvaluationResult, predictor: SvmPredictor) {

}


// TODO
class SvmPredictor {

  /* Stores model information including kernel info and support vectors. */
  var model: Model;

  /* Loads the model from the modelFile */
  proc readModel(modelFile) {
    this.model = new Model();
    this.model.load(modelFile, 'model');
  }

  // TODO
  /*
    Predicts the class label for the samples in dataFile. The result is
    stored in 'result' on return of the method.
   */
  proc predictDocument(testDataFilename,
                       predictFilename,
                       chunkSize)
  {
    var result: EvaluationResult;

    const ref kernel = model.kernel;
    const ref supportVector = model.supportVector;

    const chunkDom = {1..chunkSize};

    var localPrediction: [chunkDom] real,
        classLabel: [chunkDom] int,
        // TODO: distributed
        globalPrediction: [chunkDom] real;

    var numTotalDocument,
        numPositivePositive,
        numPositiveNegative,
        numNegativePositive,
        numNegativeNegative,
        numParsedSamples: int;

    var outputBufferPredict = open(predictFilename, iomode.cw),
        reader = open(testDataFilename, iomode.r);

    // TODO -- let's get some test data...
    // Parse & Predict
    for line in reader.lines() {
      if numParsedSamples == chunkSize {
        // TODO: Reduction block
      }


    }

    // Clean up
    reader.close();
    outputBufferPredict.close();

    // TODO
    // Compute some statistics and record some numbers

    return result;
  }

  // TODO
  /* Prints the time information of current processor. */
  proc printTimeInfo() { }

  // TODO
  /*
    Save time statistic information into a file.
    For processor #, it is stored in "path/file_name.#"
   */
  proc SaveTimeInfo(path: string, fileName: string) { }

  proc deinit() {
    delete model;
  }

}



record EvaluationResult {
  var num_total: int,
      num_pos: int,
      num_neg: int,
      num_pos_pos: int,
      num_pos_neg: int,
      num_neg_pos: int,
      num_neg_neg: int;

  var positive_precision: real,  // a/(a+c)
      positive_recall: real,     // a/(a+b)
      negative_precision: real,  // d/(b+d)
      negative_recall: real,     // d/(c+d)
      accuracy: real;            // (a+d)/(a+b+c+d)
};
