How is a particular kubernetes resource or object represented in your go source code


try to define this...

any go struct implements runtime.Object interface from apimachinery package, that particular go struct is a kubernetes object

what are the methods this interface exposes?

Object interface
two methods
DeepCopyObject()
GetObjectKing() -> this leads to another interface
    -SetGroupVersionKind() *can se g
    -GroupVersionKind()


DeepCopyObject - method that can be used against any kubernetes object to create a copy of object
Why?

Any go struct can be called as a kubernetes struct if it implements these three methods


looking at Pod struct...

metav1.TypeMeta (inline embedded?)

TypeMeta implements SetGroupVersionKind and GroupVersionKind
look in pkg/meta.go in apimachinery


confusing...
Pod implements runtime object interface with help of TypeMeta
Pod directly implements DeepCopyObject


might have changed from vivks version. pkg/meta.go has func (obj objectAccessor) not TypeMeta. Pod still has TypeMeta

seems that deepcopy is implemented by Pod resource in k8s.api/core/v1/zz_generated.deepcopy.go

meta.TypeMeta used in almost any kubernetes object

k8s object
    typeMeta
        kind
        apiversion
    objectmeta
    spec
    status


can use type meta to specify type of particular resource
ex.

apiVersion: apps/v1
kind: deployment

this iswhat type meta acutally means. that is what is mapped to type meta in go code


Look now into ObjectMeta

Typemeta  is used to define or specify type of objecet, ObectMeta is used to specify other metadata details about object
ex. name, namespace, labels, annotations, resource version, etc

spec is what we specify as expected state
status is field controller updates for the object