#ifndef _LIBSVM_WRAP_H
#define _LIBSVM_WRAP_H

#include "svm.h"

#ifdef __cplusplus
extern "C" {
#endif

typedef struct svm_node svm_node;

int* get_index(struct svm_node* n);
struct svm_parameter* get_param(struct svm_model* m);
int** get_label(struct svm_model* m);

int* get_index(struct svm_node* n) {
  return &(n->index);
}

struct svm_parameter* get_param(struct svm_model* m) {
  return &(m->param);
}

int** get_label(struct svm_model* m) {
  return &(m->label);
}
#ifdef __cplusplus
}
#endif

#endif /* _LIBSVM_H */
