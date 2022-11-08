try:
    # statements that can raise exceptions
    potentially_raising_operation() 
except:
     # executed to handle exceptions
    handle_raised_exception()
else:
    # executed if there is no exception
    dependent_on_success()
finally:
    # executed regardless
    always_before_moving_on()
