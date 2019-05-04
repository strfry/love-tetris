ohmd = require 'openhmd'

ohmd.ohmd_require_version(1, 0, 0)

local ctx = ohmd.ohmd_ctx_create()

ffi.gc(ctx, function(x)
    ohmd.ohmd_ctx_destroy(x)
end)


num_devices = ohmd.ohmd_ctx_probe(ctx)
print("num devices", num_devices)

for i = 0,num_devices-1 do
    names = {"HMD", "Controller", "Generic Tracker", "Unknown"}
    device_class_p = ffi.new("int[1]")
	ohmd.ohmd_list_geti(ctx, i, ohmd.OHMD_DEVICE_CLASS, device_class_p);
    print('class ', names[device_class_p[0] + 1])


end

local hmd = ohmd.ohmd_list_open_device(ctx, 0)

if not hmd then
    print ("failed to open HMD???")
    exit()
end

hmd_w = ffi.new("int[1]")
hmd_h = ffi.new("int[1]")

ohmd.ohmd_device_geti(hmd, ohmd.OHMD_SCREEN_HORIZONTAL_RESOLUTION, hmd_w)
ohmd.ohmd_device_geti(hmd, ohmd.OHMD_SCREEN_VERTICAL_RESOLUTION, hmd_h)

print ("device resolution: ", hmd_w[0], 'x', hmd_h[0])

tf = love.math.newTransform()

function ohmd_get_transform(hmd, index)
    local t = love.math.newTransform()
    
    local proj_p = ffi.new("float[16]")
    ohmd.ohmd_device_getf(hmd, index, proj_p)

    t:setMatrix(
        proj_p[0], proj_p[1], proj_p[2], proj_p[3],
        proj_p[4], proj_p[5], proj_p[6], proj_p[7],
        proj_p[8], proj_p[9], proj_p[10], proj_p[11],
        proj_p[12], proj_p[13], proj_p[14], proj_p[15]
    )

    print ('getting', proj_p[0])

    return t
end

function love.update(dt)
    ohmd.ohmd_ctx_update(ctx)

    modelview_left = ohmd_get_transform(hmd, ohmd.OHMD_LEFT_EYE_GL_MODELVIEW_MATRIX)
    proj_left = ohmd_get_transform(hmd, ohmd.OHMD_LEFT_EYE_GL_PROJECTION_MATRIX)
    
    modelview_right = ohmd_get_transform(hmd, ohmd.OHMD_RIGHT_EYE_GL_MODELVIEW_MATRIX)
    proj_right = ohmd_get_transform(hmd, ohmd.OHMD_RIGHT_EYE_GL_PROJECTION_MATRIX)

    --ohmd.ohmd_device_getf(hmd, ohmd.OHMD_ROTATION_QUAT, proj_p)

    print ("Proj Left: ", proj_left:getMatrix())
end

g = love.graphics
function love.draw()
    g.setDepthMode()
    g.push()

    g.applyTransform(proj_left)
    g.applyTransform(modelview_left)
    g.rectangle('line', 200, 200, 400, 400)

    g.pop()
end

-------------

function hmd_init()
end
