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
