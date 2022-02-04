bl_info = {
    "name": "Add splotlamps above meshes",
    "author": "Your name here",
    "version": (1, 0),
    "blender": (2, 77, 0),
    "location": "View3D > Tools > Create > Add Spotlamps per Mesh",
    "description": "Adds a spotlamp above every selected mesh",
    "warning": "",
    "wiki_url": "",
    "category": "Object",
    }


import bpy


# primary operator
class OBJECT_OT_add_splotlamps_per_mesh(bpy.types.Operator):
    """Create splotlamps above all selected"""
    bl_idname = "mesh.add_splotlamps_per_mesh"
    bl_label = "Add Spotlamps"
    bl_options = {'REGISTER', 'UNDO'}

    # distance float property
    distance = bpy.props.FloatProperty(
        name = "Distance",
        default = 5,
        description = "How far above each object to place the spotlamps"
        )
    
    # execute function
    def execute(self, context):
        # to get a COPY (not reference) of object location:
        # loc = ob.location.copy()
        
        for ob in context.selected_objects:
            if ob.type == 'MESH':
                loc = ob.location.copy()
                loc[2] += self.distance
                bpy.ops.object.lamp_add(type='SPOT',location=loc)
                
                
        return {'FINISHED'}
    

# append to tools/create tab panel
class VIEW3D_PT_add_spotlights_above_meshes(bpy.types.Panel):
    """Panel for adding spotlamps above objects"""
    bl_label = "Add spotlights"
    bl_idname = "VIEW3D_PT_add_spotlights_above_meshes"
    bl_space_type = "VIEW_3D"
    bl_region_type = "TOOLS"
    bl_category = "Create"
    bl_context = "objectmode"
    
    def draw(self, context):
        self.layout.operator(
            OBJECT_OT_add_splotlamps_per_mesh.bl_idname,
            icon = "LAMP_SPOT"
            )

# Registration

def register():
    
    bpy.utils.register_class(OBJECT_OT_add_splotlamps_per_mesh)
    bpy.utils.register_class(VIEW3D_PT_add_spotlights_above_meshes)


def unregister():
    bpy.utils.unregister_class(OBJECT_OT_add_splotlamps_per_mesh)
    bpy.utils.unregister_class(VIEW3D_PT_add_spotlights_above_meshes)


if __name__ == "__main__":
    register()
