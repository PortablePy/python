# Import bpy only needed if this is ran as a script outside the console
import bpy


# Task 1 solution
for ob in bpy.context.selected_objects:
    ob.scale = (2,2,2)


# Task 2 solution
for ob in bpy.context.scene.objects:
    print(ob.name)