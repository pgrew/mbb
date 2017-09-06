/* Stores the properties of a document sample, including its document id,
   class label, the square of its two norm and all its features. */
record Sample {
  var id, classLabel: int;
  var twoNormSq: real;
  var featureDom: domain(1);
  var features: [featureDom] Feature;
};

/* Stores the properties of a feature, including id and weight. */
record Feature {
  var id: int;
  var weight: real;
};

/*
  Reads samples according to processor id and provides methods for accessing
  them. Suppose there are N processors, the first processor will read the 0th,
  Nth, 2Nth, ... samples, the second processor will read the first, (N+1)th,
  (2N+1)th, ... samples, and so forth. Sample usage:
     Document document();
     document.Read("sample.dat");
     const Sample* sample = document.GetLocalSample(0);
     const Feature& feature = sample.features[0];

 */
class Document {

  // Sample domain
  var samplesDom: domain(1);
  // Stores the samples assigned to this processor.
  var samples: [samplesDom] Sample;

  // keeps track of the total number of samples.
  // keeps track of the total number of positive samples.
  // keeps track of the total number of negative samples.
  var numTotal, numPos, numNeg: int;

  // TODO
  /*
     Reads samples from the file specified by filename. If the file does not
     exist or the file format is illegal, false is returned. Otherwise true
     is returned. The file format whould strickly be:
        label word-id:word-weight word-id:word-weight ...
        label word-id:word-weight word-id:word-weight ...
        ...
     Each line in the file corresponds to one sample. The samples will be
     evenly distributed across all the processors. Suppose there are N
     processors, with processor ids 0, 1, ..., (N-1). Then processor 0 will
     read the 0th, Nth, 2Nth, ... samples from the file, processor 1 will read
     the first, (N+1)th, (2N+1)th, ... samples form the file, and so forth.
   */
  proc read(filename: string) {
    this.numTotal = 0;
    this.numPos = 0;
    this.numNeg = 0;

    if filename.length == 0 then
      halt('Name required');

    var f = open(filename, iomode.r);

    // TODO: Parallelize IO
    for line in f.lines() {
      const fields = line.split();
      var classLabel = fields[1]: int;

      // Increment positive/negative samples
      if classLabel == 1 then
        this.numPos += 1;
      else if classLabel == -1 then
        this.numNeg += 1;
      else
        halt('Unknown classLabel in this line: ', numTotal + 1, ' label: ', classLabel);

      var sample = new Sample(id=this.numTotal, classLabel=classLabel);

      // Extract sample's features
      const kvPairs = fields[2..];
      for kvPair in kvPairs {
        const kv = kvPair.split(':');
        var feature = new Feature();
        feature.id = kv[1]: int;
        feature.weight = kv[2]: real;
        sample.features.push_back(feature);
        sample.twoNormSq += feature.weight * feature.weight;
      }
      samples.push_back(sample);
      this.numTotal += 1;
    }
    f.close();
  }

  // TODO (maybe not)
  /*
     Returns a const pointer to the local_row_index'th sample. But if
     local_row_index is less then 0 or points to a non-existent position, NULL
     will be returned.
   */
  proc getLocalSample(localRowIndex: int) {

  }

  // TODO (maybe not)
  proc getLocalSample(localRowIndex: int) {

  }

  // TODO:
  /*
     Returns a const pointer to the global_row_index'th sample. But when any of
     the following conditions is satisfied, NULL will be returned:
        1. global_row_index is less then 0 or points to a non-existent
           position.
        2. The global_row_index'th sample is not assigned to this processor.
           (See comment of method 'Read')
   */
  proc getGlobalSample(globalRowIndex: int) { }

  // Frees the memory occupied by the samples assigned to this processor.
  proc destroy() {
    this.samples.clear();
  }

  // Returns the number of the samples assigned to this processor.
  proc getLocalNumberRows {
    return this.samples.size();
  }

  // TODO
  // Copies the labels of the samples assigned to this processor to the array
  // specified by the output parameter 'labels'. The class labels will be
  // stored in the same order as the samples. It is the caller's responsibility
  // to allocate enough memory for the labels.
  proc GetLocalLabels(labels: [] int) {

  }

  // TODO
  // The following methods are used to encode Sample to or decode Sample from
  // a memory block, which is used to transfer Sample in the network.

  // Computes the size of the memory block needed to encode sample to.
  proc getPackSize(sample: Sample) {

  }

  // Packs a Sample into 'buffer'. If buffer != NULL, it should be a
  // pre-allocated memory block, with proper block size. Otherwise,
  // this method will use GetPackSize to determine how much memory is
  // needed and then allocate enough memory to hold it. It is the caller's
  // responsibility to free the memory. The return value is the number
  // of bytes used in buffer.
  proc packSample(buffer: string, sample: Sample) {

  }

  // Decodes sample from the memory block pointed to by 'buffer'. If 'sample' is
  // NULL, the method will allocate a new Sample. On return of the method,
  // the decoded Sample is put in the output parameter 'sample'. It's the
  // caller's responsility to free the memory. The method returns how many
  // bytes is decoded from 'buffer'
  proc unpackSample(sample: Sample, buffer: string) {

  }


}
