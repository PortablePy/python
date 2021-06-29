import bpy

class multi_column_panel(bpy.types.Panel):
    """Multiple columns in a panel"""
    bl_label = "Multi-Column Panel Challenge"
    bl_idname = "multi_columns"
    bl_space_type = 'VIEW_3D'
    bl_region_type = 'TOOLS'
    bl_context = "objectmode"
    bl_category = "Tools"
    
    def draw(self, context):
        layout = self.layout
        
        # use this operator button or any others to fill the panel
        layout.operator("mesh.primitive_cube_add", text="col1")
        
        # write the layout code below here
        
        # complete writing the layout code above here


def register():
    bpy.utils.register_class(multi_column_panel)

def unregister():
    bpy.utils.unregister_class(multi_column_panel)

if __name__ == "__main__":
    register()

