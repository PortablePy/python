bl_info = {
    "name": "Add Smooth Monkey",
    "author": "Patrick W. Crawford",
    "version": (1, 0),
    "blender": (2, 77, 0),
    "location": "View3D > Add > Mesh > New Object",
    "description": "Adds a new smooth monkey",
    "warning": "",
    "wiki_url": "",
    "category": "Add Mesh",
    }


import bpy


# operator, add smooth monkey
class OBJECT_OT_add_smooth_monkey(bpy.types.Operator):
    """Create a new smooth monkey"""
    bl_idname = "mesh.add_smooth_monkey"
    bl_label = "Add Smooth Monkey"
    bl_options = {'REGISTER', 'UNDO'}

    smoothness = bpy.props.IntProperty(
            name="Smoothness",
            default=2,
            description="Subsurf level"
            )
    size = bpy.props.FloatProperty(
            name = "Size",
            default=1,
            description="Size of added monkey"
            )
    name = bpy.props.StringProperty(
            name = "Name",
            default = "Monkey",
            description = "Added object name"
            )

    def execute(self, context):
        
        print("Running add smooth monkey, with smoothness/size of {x}/{y}".format(x=self.smoothness, y=self.size))
        bpy.ops.mesh.primitive_monkey_add(radius=self.size)
        bpy.ops.object.shade_smooth()
        bpy.ops.object.modifier_add(type='SUBSURF')
        context.object.modifiers["Subsurf"].levels = self.smoothness
        context.object.name = self.name

        return {'FINISHED'}


# add the operator to the shift-A add mesh menu
def add_object_button(self, context):
    self.layout.operator(
        OBJECT_OT_add_smooth_monkey.bl_idname,
        text="Add Smooth Monkey",
        icon='MESH_MONKEY')


# panel, for name and show oeprator
class smooth_monkey_panel(bpy.types.Panel):
    """Creates a Panel in the Object properties window"""
    bl_label = "Smooth Monkey"
    bl_idname = "OBJECT_PT_hello"
    bl_space_type = 'VIEW_3D'
    bl_region_type = 'TOOLS'
    bl_category = "Create"
    bl_context = "objectmode"

    def draw(self, context):
        layout = self.layout

        row = layout.row()
        row.label(text="Add smooth monkey named:")

        row = layout.row()
        row.prop(context.scene, "smooth_monkey_name", text="", icon = "MESH_MONKEY")

        row = layout.row()
        p = row.operator(OBJECT_OT_add_smooth_monkey.bl_idname)
        p.name = context.scene.smooth_monkey_name



# Registration

def register():
    # our custom property, a name
    bpy.types.Scene.smooth_monkey_name = bpy.props.StringProperty(
        name = "Monkey Name",
        default = "Suzanne",
        description = "Name of the object after using the add smooth monkey operator"
        )
    
    bpy.utils.register_class(OBJECT_OT_add_smooth_monkey)
    bpy.utils.register_class(smooth_monkey_panel)
    bpy.types.INFO_MT_mesh_add.append(add_object_button)


def unregister():
    bpy.utils.unregister_class(OBJECT_OT_add_smooth_monkey)
    bpy.utils.unregister_class(smooth_monkey_panel)
    bpy.types.INFO_MT_mesh_add.remove(add_object_button)
    
    del bpy.types.Scene.smooth_monkey_name


if __name__ == "__main__":
    register()
