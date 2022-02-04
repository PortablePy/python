bl_info = {
    "name":"Add Smooth Monkey",
    "author":"Patrick W. Crawford",
    "version":(1,0),
    "blender":(2,77),
    "location":"View3D > Add > Mesh > Add Smooth Monkey",
    "description":"Adds a new smooth monkey",
    "warning":"",
    "wiki_url":"",
    "category":"Add Mesh"
    }

import bpy

# classes
class OBJECT_OT_add_smooth_monkey(bpy.types.Operator):
    """Adds a smooth monkey to the 3D view"""
    bl_label = "Add smooth monkey"
    bl_idname = "mesh.add_smooth_monkey"
    bl_options = {'REGISTER', 'UNDO'}
    
    smoothness = bpy.props.IntProperty(
        name = "Smoothness",
        default = 2,
        description = "Subsurf level"
        )
    size = bpy.props.FloatProperty(
        name = "Size",
        default = 1,
        description = "Size of monkey added"
        )
    name = bpy.props.StringProperty(
        name = "Name",
        default = "Monkey",
        description = "Name of added monkey"
        )
        
    
    def execute(self, context):
        
        bpy.ops.mesh.primitive_monkey_add(radius=self.size)
        bpy.ops.object.shade_smooth()
        bpy.ops.object.modifier_add(type='SUBSURF')
        bpy.context.object.modifiers["Subsurf"].levels = self.smoothness
        bpy.context.object.name = self.name
        
        return {'FINISHED'}

class smooth_monkey_panel(bpy.types.Panel):
    """The smooth monkey add panel"""
    bl_label = "Smooth Monkey"
    bl_idname = "OBJECT_PT_smooth_monkey"
    bl_space_type = "VIEW_3D"
    bl_region_type = "TOOLS"
    bl_category = "Create"
    bl_context = "objectmode"
    
    def draw(self, context):
        layout = self.layout
        col = layout.column()
        col.label(text="Add smooth monkey named:")
        col.prop( context.scene, "smooth_monkey_name", text="", icon="MESH_MONKEY")
        p = col.operator( OBJECT_OT_add_smooth_monkey.bl_idname)
        p.name = context.scene.smooth_monkey_name

def add_object_button(self, context):
    self.layout.operator(
            OBJECT_OT_add_smooth_monkey.bl_idname,
            icon = "MESH_MONKEY"
            )

# registration
def register():
    
    bpy.types.Scene.smooth_monkey_name = bpy.props.StringProperty(
        name = "Monkey Name",
        default = "Suzanne",
        description = "Name of the object after adding to the scene"
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