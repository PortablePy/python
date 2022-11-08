try:
    # This code might raise an exception
    do_something()
except ValueError as e:
    # ValueError caught and handled
    handle_value_error(e)
else:
    # No exception was raised
    # We know that do_something() succeeded, so
    do_something_else()
