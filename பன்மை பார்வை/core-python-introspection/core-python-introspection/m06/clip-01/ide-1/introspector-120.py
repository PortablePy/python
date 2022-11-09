import inspect
import reprlib


def dump(obj):
    print("Type")
    print("====")
    print(type(obj))
    print()

    print("Documentation")
    print("=============")
    print(inspect.getdoc(obj))
    print()

    all_attr_names = set(dir(obj))
    method_names = set(
        filter(lambda attr_name: callable(getattr(obj, attr_name)),
               all_attr_names))
    assert method_names <= all_attr_names
    attr_names = all_attr_names - method_names

    print("Attributes")
    print("==========")
    attr_names_and_values = [(name, reprlib.repr(getattr(obj, name)))
                             for name in attr_names]
    print_table(attr_names_and_values, "Name", "Value")
    print()

    print("Methods")
    print("=======")
    methods = (getattr(obj, method_name) for method_name in method_names)
    method_names_and_doc = sorted((full_sig(method), brief_doc(method))
                                  for method in methods)
    print()
