# Requirements

The examples in this directory require the libsvm submodule.

```bash
# Clone recursively to ensure you get the libsvm submodule
git clone --recursive https://github.com/pgrew/mbb.git

cd mbb

# Add libsvm python directory to PYTHONPATH
export PYTHONPATH=$(pwd)/libsvm/python
```

### Run Examples

`python simple_svm_classification.py`
