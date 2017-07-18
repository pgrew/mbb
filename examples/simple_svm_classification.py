import svm
import svmutil

class TruthLabelMisingInDictError(Exception):
    pass

def read_iris_dataset(path_to_file, names_to_integers):
    """Reads the iris dataset.

    Args:
        path_to_file: The full path to the iris dataset.
        names_to_integers: A dict of flower names to integer values.

    Returns:
        x: A multidimensional array with feature values
        y: A 1D array of integer truth labels

    Raises:
        IOError: An error occurred accessing the file.
        TruthLabelMisingInDictError: A truth label in file is not in the provided dict.
    """
    x = []
    y = []
    with open(path_to_file, 'r') as in_file:
        for line in in_file:
            # the last line is empty
            if len(line) <= 1:
                break
            # split the line on commas, last element is truth label
            values = line.rstrip().split(',')
            arr = []
            # convert elements to floats
            for i in range(0,4):
                arr.append(float(values[i]))
            x.append(arr)
            if values[4] not in names_to_integers:
                raise TruthLabelMissingInDictError("Could not find \"" + values[4] + "\" in file")
            y.append(names_to_integers[values[4]])
            #print values
    return x, y

if __name__ == "__main__":
    flower_truth = {"Iris-setosa": 1, "Iris-versicolor": 2, "Iris-virginica": 3}
    x, y = read_iris_dataset("../datasets/iris.data", flower_truth)
    print x,y

    prob = svm.svm_problem(y, x)
    param = svm.svm_parameter('-t 0 -c 4 -b 1')
    m = svmutil.svm_train(prob, param)

    p = svmutil.svm_predict(y, x, m)
    print "DONE"
