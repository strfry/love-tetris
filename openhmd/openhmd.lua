ffi = require 'ffi'


ffi.cdef[[
typedef enum {
 OHMD_S_OK = 0,
 OHMD_S_UNKNOWN_ERROR = -1,
 OHMD_S_INVALID_PARAMETER = -2,
 OHMD_S_UNSUPPORTED = -3,
 OHMD_S_INVALID_OPERATION = -4,


 OHMD_S_USER_RESERVED = -16384,
} ohmd_status;


typedef enum {
 OHMD_VENDOR = 0,
 OHMD_PRODUCT = 1,
 OHMD_PATH = 2,
} ohmd_string_value;


typedef enum {
 OHMD_GLSL_DISTORTION_VERT_SRC = 0,
 OHMD_GLSL_DISTORTION_FRAG_SRC = 1,
 OHMD_GLSL_330_DISTORTION_VERT_SRC = 2,
 OHMD_GLSL_330_DISTORTION_FRAG_SRC = 3,
 OHMD_GLSL_ES_DISTORTION_VERT_SRC = 4,
 OHMD_GLSL_ES_DISTORTION_FRAG_SRC = 5,
} ohmd_string_description;



typedef enum {
 OHMD_GENERIC = 0,
 OHMD_TRIGGER = 1,
 OHMD_TRIGGER_CLICK = 2,
 OHMD_SQUEEZE = 3,
 OHMD_MENU = 4,
 OHMD_HOME = 5,
 OHMD_ANALOG_X = 6,
 OHMD_ANALOG_Y = 7,
 OHMD_ANALOG_PRESS = 8,
 OHMD_BUTTON_A = 9,
 OHMD_BUTTON_B = 10,
 OHMD_BUTTON_X = 11,
 OHMD_BUTTON_Y = 12,
 OHMD_VOLUME_PLUS = 13,
 OHMD_VOLUME_MINUS = 14,
 OHMD_MIC_MUTE = 15,
} ohmd_control_hint;

typedef enum {
 OHMD_DIGITAL = 0,
 OHMD_ANALOG = 1
} ohmd_control_type;

typedef enum {
 OHMD_ROTATION_QUAT = 1,
 OHMD_LEFT_EYE_GL_MODELVIEW_MATRIX = 2,
 OHMD_RIGHT_EYE_GL_MODELVIEW_MATRIX = 3,
 OHMD_LEFT_EYE_GL_PROJECTION_MATRIX = 4,
 OHMD_RIGHT_EYE_GL_PROJECTION_MATRIX = 5,
 OHMD_POSITION_VECTOR = 6,
 OHMD_SCREEN_HORIZONTAL_SIZE = 7,
 OHMD_SCREEN_VERTICAL_SIZE = 8,
 OHMD_LENS_HORIZONTAL_SEPARATION = 9,
 OHMD_LENS_VERTICAL_POSITION = 10,
 OHMD_LEFT_EYE_FOV = 11,
 OHMD_LEFT_EYE_ASPECT_RATIO = 12,
 OHMD_RIGHT_EYE_FOV = 13,
 OHMD_RIGHT_EYE_ASPECT_RATIO = 14,
 OHMD_EYE_IPD = 15,
 OHMD_PROJECTION_ZFAR = 16,
 OHMD_PROJECTION_ZNEAR = 17,
 OHMD_DISTORTION_K = 18,
 OHMD_EXTERNAL_SENSOR_FUSION = 19,
 OHMD_UNIVERSAL_DISTORTION_K = 20,
 OHMD_UNIVERSAL_ABERRATION_K = 21,
 OHMD_CONTROLS_STATE = 22,
} ohmd_float_value;

typedef enum {
 OHMD_SCREEN_HORIZONTAL_RESOLUTION = 0,
 OHMD_SCREEN_VERTICAL_RESOLUTION = 1,
 OHMD_DEVICE_CLASS = 2,
 OHMD_DEVICE_FLAGS = 3,
 OHMD_CONTROL_COUNT = 4,
 OHMD_CONTROLS_HINTS = 5,
 OHMD_CONTROLS_TYPES = 6,
} ohmd_int_value;


typedef enum {
 OHMD_DRIVER_DATA = 0,
 OHMD_DRIVER_PROPERTIES = 1,
} ohmd_data_value;

typedef enum {
 OHMD_IDS_AUTOMATIC_UPDATE = 0,
} ohmd_int_settings;


typedef enum
{
 OHMD_DEVICE_CLASS_HMD = 0,
 OHMD_DEVICE_CLASS_CONTROLLER = 1,
 OHMD_DEVICE_CLASS_GENERIC_TRACKER = 2,
} ohmd_device_class;

typedef enum
{
 OHMD_DEVICE_FLAGS_NULL_DEVICE = 1,
 OHMD_DEVICE_FLAGS_POSITIONAL_TRACKING = 2,
 OHMD_DEVICE_FLAGS_ROTATIONAL_TRACKING = 4,
 OHMD_DEVICE_FLAGS_LEFT_CONTROLLER = 8,
 OHMD_DEVICE_FLAGS_RIGHT_CONTROLLER = 16,
} ohmd_device_flags;

typedef struct ohmd_context ohmd_context;
typedef struct ohmd_device ohmd_device;
typedef struct ohmd_device_settings ohmd_device_settings;

 ohmd_context* ohmd_ctx_create(void);
 void ohmd_ctx_destroy(ohmd_context* ctx);
 const char* ohmd_ctx_get_error(ohmd_context* ctx);
 void ohmd_ctx_update(ohmd_context* ctx);
 int ohmd_ctx_probe(ohmd_context* ctx);
 int ohmd_gets(ohmd_string_description type, const char** out);
 const char* ohmd_list_gets(ohmd_context* ctx, int index, ohmd_string_value type);
 int ohmd_list_geti(ohmd_context* ctx, int index, ohmd_int_value type, int* out);
 ohmd_device* ohmd_list_open_device(ohmd_context* ctx, int index);
 ohmd_device* ohmd_list_open_device_s(ohmd_context* ctx, int index, ohmd_device_settings* settings);
 ohmd_status ohmd_device_settings_seti(ohmd_device_settings* settings, ohmd_int_settings key, const int* val);

 ohmd_device_settings* ohmd_device_settings_create(ohmd_context* ctx);

 void ohmd_device_settings_destroy(ohmd_device_settings* settings);
 int ohmd_close_device(ohmd_device* device);
 int ohmd_device_getf(ohmd_device* device, ohmd_float_value type, float* out);
 int ohmd_device_setf(ohmd_device* device, ohmd_float_value type, const float* in);
 int ohmd_device_geti(ohmd_device* device, ohmd_int_value type, int* out);
 int ohmd_device_seti(ohmd_device* device, ohmd_int_value type, const int* in);
 int ohmd_device_set_data(ohmd_device* device, ohmd_data_value type, const void* in);
 void ohmd_get_version(int* out_major, int* out_minor, int* out_patch);
 ohmd_status ohmd_require_version(int major, int minor, int patch);
]]

lib = ffi.load('openhmd')

return lib

