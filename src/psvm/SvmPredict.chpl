use Time;
use Model;

config const dataFile: string,
             batchSize: int,
             modelPath: string,
             outputPath: string;

proc main() {
  var t: Timer(); // TODO: port timer.cc to a timer class
  t.start();

  var predictor = new SvmPredictor();
  predictor.readModel(modelPath);
  var result = predictor.predictDocument(dataFile,
                                         outputPath + '/PredictResult',
                                         batchSize);


  t.stop();

  delete predictor;
}

// TODO
proc printInfo(result: EvaluationResult, predictor: SvmPredictor) {

}


// TODO
class SvmPredictor {

  var model: Model;

  proc readModel(modelFile) {
    this.model = new Model();
    this.model.load(modelFile, 'model');
  }

  // TODO
  proc predictDocument(testDataFilename,
                       predictFilename,
                       chunkSize)
  {
    var result: EvaluationResult;
    return result;
  }

  // TODO
  proc printTimeInfo() { }

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
