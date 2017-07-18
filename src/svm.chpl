// Generated with c2chapel version 0.1.0

// Header given to c2chapel:
require "svm.h";
require "svm_wrap.h";

// Note: Generated with fake std headers

// #define'd integer literals:
// Note: some of these may have been defined with an ifdef
extern const LIBSVM_VERSION : int;

// End of #define'd integer literals

extern var libsvm_version : c_int;

extern record svm_node {
  //var _index : c_int;
  var value : c_double;
  proc _index ref { return get_index(this).deref(); }
  proc svm_node(_index: c_int, value: c_double) {
    this.value = value;
    this._index = _index;
  }
}

extern record svm_problem {
  var l : c_int;
  var y : c_ptr(c_double);
  var x : c_ptr(c_ptr(svm_node));

  proc svm_problem(y, x) {
    this.l = y.size;
    this.y = y;

  }
}

// Enum: anonymous
extern const C_SVC :c_int;
extern const NU_SVC :c_int;
extern const ONE_CLASS :c_int;
extern const EPSILON_SVR :c_int;
extern const NU_SVR :c_int;


// Enum: anonymous
extern const LINEAR :c_int;
extern const POLY :c_int;
extern const RBF :c_int;
extern const SIGMOID :c_int;
extern const PRECOMPUTED :c_int;


extern record svm_parameter {
  var svm_type : c_int;
  var kernel_type : c_int;
  var degree : c_int;
  var gamma : c_double;
  var coef0 : c_double;
  var cache_size : c_double;
  var eps : c_double;
  var C : c_double;
  var nr_weight : c_int;
  var weight_label : c_ptr(c_int);
  var weight : c_ptr(c_double);
  var nu : c_double;
  var p : c_double;
  var shrinking : c_int;
  var probability : c_int;
}

extern record svm_model {
  //var _param : svm_parameter;
  var nr_class : c_int;
  var l : c_int;
  var SV : c_ptr(c_ptr(svm_node));
  var sv_coef : c_ptr(c_ptr(c_double));
  var rho : c_ptr(c_double);
  var probA : c_ptr(c_double);
  var probB : c_ptr(c_double);
  //var _label : c_ptr(c_int);
  var nSV : c_ptr(c_int);
  var free_sv : c_int;
  proc _param ref { return get_param(this).deref(); }
  proc _label ref { return get_label(this).deref(); }
}

// keyword-conflict getters
extern proc get_index(ref n: svm_node): c_ptr(c_int);
extern proc get_param(ref m: svm_model): c_ptr(svm_parameter);
extern proc get_label(ref m: svm_model) : c_ptr(c_ptr(c_int));

extern proc svm_train(ref prob : svm_problem, ref param_arg : svm_parameter) : c_ptr(svm_model);

extern proc svm_cross_validation(ref prob : svm_problem, ref param_arg : svm_parameter, nr_fold : c_int, ref target : c_double) : void;

extern proc svm_save_model(model_file_name : c_string, ref model : svm_model) : c_int;

extern proc svm_load_model(model_file_name : c_string) : c_ptr(svm_model);

extern proc svm_get_svm_type(ref model : svm_model) : c_int;

extern proc svm_get_nr_class(ref model : svm_model) : c_int;

extern proc svm_get_labels(ref model : svm_model, ref label_arg : c_int) : void;

extern proc svm_get_svr_probability(ref model : svm_model) : c_double;

extern proc svm_predict_values(ref model : svm_model, ref x : svm_node, ref dec_values : c_double) : c_double;

extern proc svm_predict(ref model : svm_model, ref x : svm_node) : c_double;

extern proc svm_predict_probability(ref model : svm_model, ref x : svm_node, ref prob_estimates : c_double) : c_double;

extern proc svm_free_model_content(ref model_ptr : svm_model) : void;

extern proc svm_free_and_destroy_model(ref model_ptr_ptr : c_ptr(svm_model)) : void;

extern proc svm_destroy_param(ref param_arg : svm_parameter) : void;

extern proc svm_check_parameter(ref prob : svm_problem, ref param_arg : svm_parameter) : c_string;

extern proc svm_check_probability_model(ref model : svm_model) : c_int;

extern proc svm_set_print_string_function(ref print_func : c_fn_ptr) : void;

